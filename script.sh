#!/bin/bash

# Bash script to list all repositories in the "philips-software" GitHub organization

# GitHub organization
ORG="philips-software"

# GitHub API URL
API_URL="https://api.github.com/orgs/$ORG/repos"

# Fetch repositories using curl
echo "Fetching repositories for organization: $ORG"
curl -s $API_URL | jq -r '.[].name'
