#!/bin/bash
WORKSPACE=$(echo "${PWD#$HOME}" | awk -F'/' '{ print $2 }')
if [ -d "$HOME/$WORKSPACE/.kit" ]; then
    HASH=$(echo "$WORKSPACE" | sha1sum | sed 's/[^0-9]*//g')
    BG=$((${HASH:0:2}+${HASH:2:2}))
    echo "\e[48;5;${BG}m"
fi
