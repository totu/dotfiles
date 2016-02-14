alias g=git
alias pe=perl6
alias rec="asciinema rec"
alias mac2emoji="py ~/Code/emoji/emoji.py"
alias jup="jupyter notebook ~/.notes"
alias py=python3
alias js=node
alias sshh='ssh -i ~/.ssh/aws.pem ec2-user@52.91.118.108'
alias sscp='scp -i ~/.ssh/aws.pem ec2-user@52.91.118.108'
alias grepr="grep -riI"
alias hugogen="hugo --theme=hugo-zen"
alias hugos="hugo server --theme=hugo-zen"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gallifrey"
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git vundle osx pyenv python pylin)

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
alias bd=". bd -s"
export PATH="$PATH:$HOME/.scripts/"
export PATH=~/.rakudobrew/bin:$PATH
export PATH=/Users/totu/.rakudobrew/moar-2015.12/install/share/perl6/site/bin:$PATH

# source ~/.scripts/git-completion.zsh
