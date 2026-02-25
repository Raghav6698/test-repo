#!/bin/bash

# curl --silent --user "Philips Software" "https://github.com/philips-software" | npx jq '.[].ssh_url' | while read repo
# do
#     repo="${repo%\"}"
#     repo="${repo#\"}"
#     echo "$repo"
# done

USERNAME="Philips Software"

curl -s "https://api.github.com/users/$USERNAME/repos" \
| jq -r '.[].name'
