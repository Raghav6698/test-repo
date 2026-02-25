#!/bin/bash

curl --silent --user "Philips Software" "https://github.com/philips-software" | npx jq '.[].ssh_url' | while read repo
do
    repo="${repo%\"}"
    repo="${repo#\"}"
    echo "$repo"
done
