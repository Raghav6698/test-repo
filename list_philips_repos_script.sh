#!/usr/bin/env bash
# ------------------------------------------------------------
# list_philips_repos.sh
# Lists all public repositories in the philips-software GitHub org.
# Usage: ./list_philips_repos.sh [GITHUB_TOKEN]
# A token is optional but recommended to avoid rate-limiting.
# ------------------------------------------------------------

set -euo pipefail

ORG="philips-software"
API_BASE="https://api.github.com/orgs/${ORG}/repos"
PER_PAGE=100
PAGE=1
TOTAL=0

AUTH_HEADER=""
if [[ -n "${GITHUB_TOKEN:-}" ]]; then
  AUTH_HEADER="Authorization: Bearer ${GITHUB_TOKEN}"
  echo "Using provided GitHub token."
fi

echo "============================================"
echo " Repositories in: https://github.com/${ORG}"
echo "============================================"

while true; do
  if [[ -n "$AUTH_HEADER" ]]; then
    RESPONSE=$(curl -s -H "$AUTH_HEADER" \
      "${API_BASE}?per_page=${PER_PAGE}&page=${PAGE}&type=public")
  else
    RESPONSE=$(curl -s \
      "${API_BASE}?per_page=${PER_PAGE}&page=${PAGE}&type=public")
  fi

  # Parse repo names using grep + sed (no jq dependency)
  NAMES=$(echo "$RESPONSE" | grep '"full_name"' | sed 's/.*"full_name": "\(.*\)".*/\1/')

  [[ -z "$NAMES" ]] && break

  COUNT=$(echo "$NAMES" | wc -l | tr -d ' ')
  echo "$NAMES"
  TOTAL=$((TOTAL + COUNT))

  [[ "$COUNT" -lt "$PER_PAGE" ]] && break
  PAGE=$((PAGE + 1))
done

echo "--------------------------------------------"
echo " Total repositories found: ${TOTAL}"
echo "============================================"
