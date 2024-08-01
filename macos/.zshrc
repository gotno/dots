HISTSIZE=10000
SAVEHIST=10000

# git aliases
alias gs="git status -sb"
alias gc="git commit"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"
alias gall="git add -A"
alias gu="git push"
alias gU="git push -u origin HEAD"
alias gYOLO="git push --force-with-lease"
alias glf="git log --find-renames --follow --stat -- "
alias gundo="git reset --soft HEAD~1"

alias lc="ssh localcloud"

# source ranger when running it so the underlying shell follows in-app navigation
# alias ranger=". ranger"

# if we've dropped into a shell from ranger and run it again,
# fall back to already running ranger
ru() {
  if [ -z "$RANGER_LEVEL" ]
  then
    ranger
  else
    exit
  fi
}

if [ -f /etc/os-release ]; then
  # this is amazon linux, ie hustle localcloud
  PROMPT=$'[%4~]\n☁️  '
  export PATH="/home/will.floyd/.script:$PATH"
else
  # this is local hustle
  PROMPT=$'[%4~]\n💀 '
  export PATH="/Users/will.floyd/.script:$PATH"
fi


alias ls='ls -GFh'
alias ll="ls -al"
alias cls="printf '\e]50;ClearScrollback\a'"

alias tsnode="npx ts-node"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=vim
export TERM=xterm-256color

source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh

# asdf-vm (https://asdf-vm.com/guide/getting-started.html)
# these should remain after any $PATH settings and after any
# framework sourcing (like oh-my-zsh)
. "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
