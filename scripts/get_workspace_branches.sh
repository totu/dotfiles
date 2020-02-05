#!/bin/bash

GIT_DIRS=$(find -maxdepth 3 -type d -name .git 2> /dev/null)

printf "$(tput bold)%-15s %s$(tput sgr0)\n" "Workpace" "Branch"

for dir in $GIT_DIRS; do
    if [[ "$dir" == *"kcegc/.git" ]]; then
        pushd "$dir/.." > /dev/null
        branch=$(git describe --contains --all HEAD)
        popd > /dev/null
        workspace=$(echo $dir | awk -F/ '{ print $2 }')
        printf " %-15s %s\n" $workspace $branch
    fi
done
