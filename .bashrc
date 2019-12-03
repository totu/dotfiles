#!/usr/bin/env bash
# Source stuff
for file in ~/.bashrc.d/*.rc; do
     source "$file"
done

# for file in ~/.bash_completion.d/*; do
#     source "$file"
# done

# Get aliases and path stuff
. ~/.bash_aliases

set show-all-if-ambiguous on

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
