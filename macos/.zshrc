HISTSIZE=100000
SAVEHIST=100000

# git aliases
alias gs="git status -sb"
alias gc="git commit"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"
alias gall="git add -A"
alias gpa="git add -p"
alias gu="git push"
alias gU="git push -u origin HEAD"
alias gYOLO="git push --force-with-lease"
alias glf="git log --find-renames --follow --stat -- "
alias gundo="git reset --soft HEAD~1"
alias gcommits='git log --pretty=format:"%h %s" -n '
alias hup='git pull && yarn install && cd backend && yarn update-schemas && yarn create-new-indexes && cd ..'

alias lc="ssh localcloud"
alias lcreauth="rm $HOME/.aws/sso/cache/* && aws_profile localcloud"
alias lcreboot="lcreauth && localcloud_ide -f -p reboot"

# chrome log to stderr
alias cdb="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-logging=stderr --v=1"

alias tma="tmux attach || tmux"

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

PROMPT=$(date +%H:%M:%S)
PROMPT+=$' [%5~]\n'
if [ -f /etc/os-release ]; then
  # this is amazon linux, ie hustle localcloud
  PROMPT=$'[%4~] $(git_prompt_info)\n  '
else
  # this is local hustle
  PROMPT=$'[%4~] $(git_prompt_info)\n '
fi
export PATH="$HOME/.script:$PATH"


alias ls='ls -GFh'
alias ll="ls -al"
alias cls="printf '\e]50;ClearScrollback\a'"

alias tsnode="npx ts-node"

alias hgs="cd ~/dev/hello-world && gs"
alias htig="cd ~/dev/hello-world && tig"
alias hservices="cd ~/dev/hello-world && yarn backend:services"
alias hdev="cd ~/dev/hello-world && yarn backend:dev"
alias hinternal-api="cd ~/dev/hello-world/services/internal-api && yarn dev"
alias hadmin="cd ~/dev/hello-world/webapps/admin && yarn dev"
alias hstorybook="cd ~/dev/hello-world/libs/component-library && yarn dev"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=vim
export TERM=xterm-256color

export PATH="/home/will.floyd/.local/bin:$PATH"
export ASDF_DATA_DIR="/home/will.floyd/.asdf"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit

# if .zshrc.local exists, source it
if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
