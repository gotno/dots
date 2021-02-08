# kill macos zsh > bash warning
export BASH_SILENCE_DEPRECATION_WARNING=1

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
export PS1=$'[\w$(__git_ps1)]\n$SKULL '

# bash aliases
alias ls='ls -GFh'
alias ll="ls -al"
alias cls="printf '\e]50;ClearScrollback\a'"

alias be="bundle exec"

alias t="BACKTRACE=YES bin/rails test"
alias t_no_spring="spring stop && BACKTRACE=YES bin/rails test"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=vim

deploy_this_branch_to()
{
  branch=$(git rev-parse --abbrev-ref HEAD) bundle exec cap $1 deploy
}

# if we've dropped into a shell from ranger, exit the shell, otherwise start ranger
ru() {
  if [ -z "$RANGER_LEVEL" ]
  then
    ranger
  else
    exit
  fi
}

 # asdf config should go after any other $PATH stuff
. /usr/local/opt/asdf/asdf.sh
. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash
