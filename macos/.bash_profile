# kill macos zsh > bash warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# prompt
SKULL=$'\xE2\x98\xA0'
export PS1=$'[\w]\n$SKULL '

# bash aliases
alias ls='ls -GFh'
alias ll="ls -al"
alias cls="printf '\e]50;ClearScrollback\a'"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=vim

# if we've dropped into a shell from ranger, exit the shell, otherwise start ranger
ru() {
  if [ -z "$RANGER_LEVEL" ]
  then
    ranger
  else
    exit
  fi
}

export PATH="/Users/willfloyd/.script:$PATH"
