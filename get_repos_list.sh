#!/bin/bash

TARGET="philips-software"

echo "Listing all repositories for: $TARGET"
echo "-------------------------------------"

gh repo list "$TARGET" --limit 200 --json name --jq '.[].name' > repo_list.txt

cat repo_list.txt

echo "-------------------------------------"
