HISTSIZE=10000
SAVEHIST=10000

alias usql="usql mysql://root:@localhost"

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

# bc logging aliases
staging_log() {
 dev log zappweb$1-staging-webapp$2
}
staging_log1() {
 dev log zappweb1-staging-webapp$1
}
staging_log3() {
 dev log zappweb3-staging-webapp$1
}
staging_log_svc() {
  dev log staging-${1}1
}

# DANGER
# this will delete an important zstore record, after which running bcdevs/setup will completely reset the database
alias destroy_dev_zstore="echo \"delete from z_stores where name = 'dev'\" | mysql zstore < /dev/stdin && rm -rf ~/bc/zstore/*"
alias flush_memcached="echo 'flush_all' | nc localhost 11211"
alias reset_bc_db="destroy_dev_zstore && flush_memcached && ~/bc/bandcamp/services/bcdevs/setup"

# using ag, search file contents of files in relevant bc directories,
# skipping duplicates, logs, and bundled code
# usage: `ab [pattern] [number of preceding/following lines]`
ab() {
  ag \
    `# exlude the following file/directory names from the search` \
    --ignore log \
    --ignore common \
    --ignore client-bundler \
    --ignore core.js \
    --ignore emojidata.js \
    --ignore entry-editLiveShow.js \
    --ignore entry-index.js \
    --ignore EthernetCable.vue \
    --ignore fonts.css \
    --ignore GeoIP2-City-Locations-en.csv \
    --ignore HappyBuildings.vue \
    --ignore ic_cable.svg \
    --ignore ic_computer.svg \
    --ignore ic_homes.svg \
    --ignore jslib \
    --ignore LaptopStars.vue \
    --ignore node_modules \
    --ignore package-lock.json \
    --ignore plyr.polyfilled.js \
    --ignore public-endpoint-haproxy-config-generator \
    --ignore signing-key.asc \
    --ignore spotify_album_data_export.json \
    --ignore store1.data \
    --ignore storedata \
    --ignore string-extractor \
    --ignore string-loader \
    --ignore vendor.js \
    --ignore charts.js \
    --ignore intopia_report.liquid \
    --ignore aboutLive.css \
    --ignore entry-aboutLive.js \
    --ignore 'jquery*.min.js' \
    --ignore 'vite-prod/*' \
    --ignore 'chunk*.js' \
    --ignore '*.js.map' \
    --ignore '*.min.js' \
    --ignore '*.min.css' \
    --ignore '*.fr.js' \
    --ignore '*.ja.js' \
    --ignore '*bundle.js' \
    --ignore '*bundle.css' \
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
    -H \
    $1 \
    `# search the following directories` \
    ~/bc/bandcamp/trunk/common \
    ~/bc/bandcamp/trunk/shared \
    ~/bc/bandcamp/trunk/trackpipe \
    ~/bc/bandcamp/trunk/util \
    ~/bc/bandcamp/services
}
# cat a list of files from fd
# cat $(fb .ruby-version | grep -v '^#')

# source ranger when running it so the underlying shell follows in-app navigation
alias ranger=". ranger"

# svn diff -r r263601:r263627 --diff-cmd /usr/bin/diff | pbcopy
svncopydiff() {
    svn diff --diff-cmd /usr/bin/diff | pbcopy
}

svncopydiff_between() {
    svn diff -r r${1}:r${2} --diff-cmd /usr/bin/diff | pbcopy
}

# svn stash
# todo: make this directory specific, with auto-incremented or timestamped filenames.
# note to self: these are hella dangerous, PAY ATTENTION TO WHAT YOU ARE DOING.
svnbackup_diff() {
    svn diff --diff-cmd /usr/bin/diff > ~/.svnstash/$1
}

svnstash() {
    svn diff --diff-cmd /usr/bin/diff > ~/.svnstash/$1
    svn revert -R .
}

svnstashlist() {
    ls ~/.svnstash
}

svnstashshow() {
    cat ~/.svnstash/$1
}

svnstashrestore() {
    patch -p0 < ~/.svnstash/$1
    rm ~/.svnstash/$1
}

# cypress stuff
cy() {
    if [ "$1" ]; then
        dev service exec --cypress --includedKeys $1
    else
        dev service exec --cypress
    fi
}

cy_int() {
    if [ "$1" ]; then
        dev service exec --cypress --interactive --includedKeys $1
    else
        dev service exec --cypress --interactive
    fi
}


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
PROMPT="$(echo $PROMPT | sed s/\%c/\%5~\ \%\*/)"
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
