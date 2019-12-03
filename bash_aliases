#!/usr/bin/env bash
alias open=xdg-open
alias sl=ls
fzfvim() {
    if [ -z $1 ]; then
        nvim $(fzf)
    else
        if [ "$1" == "." ]; then
            nvim
        else
            nvim $@
        fi
    fi
}
alias v=fzfvim

clip() {
    xsel --clipboard --input < "$1"
}

alias gjd="git jump diff"
alias gjm="git jump merge"
alias c=cht.sh
alias ddb=debug_dumper
alias tmux="TERM=xterm-256color tmux"
alias bell="echo -e '\a'"
alias cd..="cd .."
alias dc=cd
alias g=git
alias vim=vi
#alias vi=nvim #"gv"

wttr() {
    if [ -z $1 ]; then
        PAIKKA=Hyvinkää
    else
        PAIKKA=$1
    fi
    curl "wttr.in/$PAIKKA"
}

alias ll="ls -alF"
alias la="ls -A"
alias ipy="bpython"
alias bpy="bpython"
alias ipy3="bpython3"
alias bpy3="bpython3"

# experimental
alias l=exa
alias ls=exa

alias copy='xsel --clipboard --input'
alias paste='xsel --clipboard --output'
