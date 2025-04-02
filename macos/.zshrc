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

alias lc="ssh localcloud"

# chrome log to stderr
alias cdb="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-logging=stderr --v=1"

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
  PROMPT=$'[%4~] $(git_prompt_info)\n☁️ '
else
  # this is local hustle
  PROMPT=$'[%4~] $(git_prompt_info)\n💀 '
fi
export PATH="$HOME/.script:$PATH"


alias ls='ls -GFh'
alias ll="ls -al"
alias cls="printf '\e]50;ClearScrollback\a'"

alias tsnode="npx ts-node"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=vim
export TERM=xterm-256color

# git clone https://github.com/jeffreytse/zsh-vi-mode.git $HOME/.zsh-vi-mode
source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh

export PATH="/home/will.floyd/.local/bin:$PATH"

# asdf-vm (https://asdf-vm.com/guide/getting-started.html)
# these should remain after any $PATH settings and after any
# framework sourcing (like oh-my-zsh)
# . "$HOME/.asdf/asdf.sh"
# append completions to fpath
# fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
# autoload -Uz compinit && compinit
