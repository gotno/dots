# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export QT_AUTO_SCREEN_SCALE_FACTOR=1
export EDITOR=vim

# git
source ~/.script/git-completion.bash
source ~/.script/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true

alias gs="git status -sb"
alias gc="git commit"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"
alias gall="git add -A"
alias gu="git push"
alias gU="git push -u origin HEAD"
alias gYOLO="git push --force-with-lease"
alias glf="git log --find-renames --follow --stat -- "

# prompt
SKULL=$'\xE2\x98\xA0'
export PS1=$'[\w$(__git_ps1)]\n $SKULL '

alias ls='ls --color=auto'
alias pastebin="curl -F 'f:1=<-' ix.io"

# if we've dropped into a shell from ranger, exit the shell, otherwise start ranger
ru() {
  if [ -z "$RANGER_LEVEL" ]
  then
    ranger
  else
    exit
  fi
}

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
