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

# source ranger when running it so the underlying shell follows in-app navigation
alias ranger=". ranger"

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

# prompt
SKULL=$'\xE2\x98\xA0'
PROMPT=$'[%4d]\n💀 '

alias ls='ls -GFh'
alias ll="ls -al"
alias cls="printf '\e]50;ClearScrollback\a'"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=vim

export PATH="/Users/willfloyd/.script:$PATH"
