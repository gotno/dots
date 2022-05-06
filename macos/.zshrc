HISTSIZE=5000
SAVEHIST=5000

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

# using ag, search file contents of files in relevant bc directories,
# skipping duplicates, logs, and bundled code
# usage: `ab [pattern]`
ab() {
  ag \
    `# exlude the following file/directory names from the search` \
    --ignore log \
    --ignore common \
    --ignore string-extractor \
    --ignore string-loader \
    --ignore client-bundler \
    --ignore global_head_bundle.js \
    --ignore global_foot1_bundle.js \
    --ignore global_foot2_bundle.js \
    --ignore global_admin_bundle.js \
    --ignore vendor.js \
    --ignore vendor.js.map \
    --ignore index.js.map \
    --ignore core.js \
    --ignore bcoak_bundle.js \
    --ignore jslib \
    --ignore public-endpoint-haproxy-config-generator \
    -C${2:-0} \
    $1 \
    `# search the following directories` \
    ~/bc/bandcamp/trunk/common \
    ~/bc/bandcamp/trunk/shared \
    ~/bc/bandcamp/trunk/trackpipe \
    ~/bc/bandcamp/trunk/util \
    ~/bc/bandcamp/services
}

# using ag, search file contents of files in a service,
# skipping common
# usage: `abs [pattern]`
abs() {
  ag \
    `# exlude the following file/directory names from the search` \
    --ignore common \
    --ignore var \
    $1 \
    `# search the following directories` \
    .
}

# using fd, search file and directory names in relevant bc directories,
# skipping services/*/common directories
# usage: `fb [pattern]`
fb() {
  fd \
    `# exlude the following file/directory names from the search` \
    --exclude 'common' \
    --exclude 'client-bundler' \
    $1 \
    `# search the following directories` \
    ~/bc/bandcamp/trunk/common \
    ~/bc/bandcamp/trunk/shared \
    ~/bc/bandcamp/trunk/trackpipe \
    ~/bc/bandcamp/trunk/util \
    ~/bc/bandcamp/services
}

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
PROMPT="$(echo $PROMPT | sed s/\%c/\%5~\ \%D\{\%T\}/)"
PROMPT+=$'\n'
PROMPT+="%F{038}☠"
PROMPT+='%{$reset_color%}  '

alias ls='ls -GFh'
alias ll="ls -al"
alias cls="printf '\e]50;ClearScrollback\a'"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=vim

export PATH="/Users/willfloyd/.script:$PATH"
