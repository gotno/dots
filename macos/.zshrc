HISTSIZE=100000
SAVEHIST=100000

alias ls='ls -GFh'
alias ll="ls -al"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=nvim
export TERM=xterm-256color

PROMPT=$(date +%H:%M:%S)
PROMPT=$'[%4~] $(git_prompt_info)\n '

# if .secrets exists, source it
if [ -f "$HOME/.secrets" ]; then
  source "$HOME/.secrets"
fi

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

# chrome log to stderr
alias cdb="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-logging=stderr --v=1"

alias tma="tmux attach || tmux"

alias nvconf="cd $HOME/.config/nvim/ && nvim ."

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

if [ -d "$HOME/.script" ]; then
  export PATH="$HOME/.script:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# asdf-vm
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit

# if .zshrc.local exists, source it
if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi

setopt IGNORE_EOF
exit_or_fg() {
  if jobs %%; then
    fg
  else
    exit 0
  fi
}
zle -N exit_or_fg
bindkey '^D' exit_or_fg
