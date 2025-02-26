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

source ~/.script/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1

# prompt
SKULL='💀'
export PS1=$'[\w$(__git_ps1 "(%s)")]\n$SKULL '

alias fd="fdfind"

alias 2424_in="scp -P 2424 -r gotno.hopto.org:/mnt/one/amass/2424_out/* /mnt/c/Users/floyd/Downloads/in"
alias 2424_out="scp -P 2424 -r /mnt/c/Users/floyd/Downloads/out/* gotno.hopto.org:/mnt/one/amass/2424_in"

. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
