test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

source ~/.script/git-completion.bash
source ~/.script/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
# export PS1='[\u💀\h \w$(__git_ps1)]\n\$ '
# export PS1='[\w$(__git_ps1)]\n\$ '
SKULL=$'\xE2\x98\xA0'
export PS1=$'[\w$(__git_ps1)]\n$SKULL '

# kill macos zsh > bash warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# bash aliases
alias ls='ls -GFh'
alias ll="ls -al"
alias cls="printf '\e]50;ClearScrollback\a'"


# git aliases
alias gs="git status -sb"
alias gc="git commit"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"
alias gall="git add -A"
alias gu="git push"
alias gU="git push -u origin HEAD"
alias gYOLO="git push --force-with-lease"
alias ghm="git push heroku master"
alias gfh="git log --follow -p"

alias be="bundle exec"

# # coverhound
# alias cap-reset-db="bundle install && be rake db:snapshot:import && be rake db:migrate && be rake db:test:prepare && be rake commercial_agency:db:seed && be rake commercial_agency:elasticsearch:reindex && git checkout -- db/schema.rb"
alias t="BACKTRACE=YES bin/rails test"
alias t_no_spring="spring stop && BACKTRACE=YES bin/rails test"
# alias rh="cd $HOME/Dev/ch/coverhound && ru"
# alias rc="cd $HOME/Dev/ch/commercial && ru"
# alias cg="cd $HOME/Dev/ch/commercial && cls && gs"
# alias cc="cd $HOME/Dev/ch/commercial && bin/rails c"
# alias ct="cd $HOME/Dev/ch/commercial && tig"
# alias cr="cd $HOME/Dev/ch/commercial && spring stop && cls && HOT_RELOADING=TRUE bundle exec rails s -p 3000"
# alias cs="cd $HOME/Dev/ch/commercial && be sidekiq"
# alias cw="cd $HOME/Dev/ch/commercial && fnm use && sh -c 'rm -rf public/business-insurance/webpack || true && yarn run hot-assets'"
# alias foreman-dev="cls && spring stop && foreman start -f Procfile.dev"

# # cyberpolicy
# alias ry="cd $HOME/Dev/ch/cyberpolicy && ru"
# alias yg="cd $HOME/Dev/ch/cyberpolicy && cls && gs"
# alias yc="cd $HOME/Dev/ch/cyberpolicy && bin/rails c"
# alias ys='cd $HOME/Dev/ch/cyberpolicy && nvm use $(cat .node-version) && foreman start'

# kill the unicorns
alias unicornkill="ps aux | grep -ie unicorn | awk '{print $2}' | xargs kill"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export EDITOR=vim

# # cvrrrhound
# export CH_USER="willfloyd@coverhound.com"

# # other env vars
# export STAGING1="deploy@staging-1.coverhound.us"
# export STAGING2="deploy@staging-2.coverhound.us"
# export STAGING3="deploy@staging-3.coverhound.us"
# export STAGING4="deploy@staging-4.coverhound.us"
# export STAGING5="deploy@staging-5.coverhound.us"
# export STAGING6="deploy@staging-6.coverhound.us"
# export APP1="deploy@ch-p-consumer-app-1.coverhound.us"
# export APP2="deploy@ch-p-consumer-app-2.coverhound.us"

# # fix `git checkout` autocomplete to show heads not refs
# # (use `git checkoutr` for original behavior)
# _git_checkout ()
# {
# 	__git_has_doubledash && return

# 	case "$cur" in
# 	--conflict=*)
# 		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
# 		;;
# 	--*)
# 		__gitcomp "
# 			--quiet --ours --theirs --track --no-track --merge
# 			--conflict= --orphan --patch
# 			"
# 		;;
# 	*)
# 		# check if --track, --no-track, or --no-guess was specified
# 		# if so, disable DWIM mode
# 		local flags="--track --no-track --no-guess" track=1
# 		if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
# 			track=''
# 		fi
#     if [ "$command" = "checkoutr" ]; then
#       __gitcomp_nl "$(__git_refs '' $track)"
#     else
#       __gitcomp_nl "$(__git_heads '' $track)"
#     fi
# 		;;
# 	esac
# }

# # show local branches that have been merged into master
# merged_branches()
# {
#   git branch --merged master | grep -v \* | grep -v integ* | grep -v production | grep -v master
# }

deploy_this_branch_to()
{
  branch=$(git rev-parse --abbrev-ref HEAD) bundle exec cap $1 deploy
}

# what_branch_is_deployed_to()
# {
#   ssh $1 tail -1 cvhnd-comm/revisions.log
# }


# if we've dropped into a shell from ranger, exit the shell, otherwise start ranger
ru() {
  if [ -z "$RANGER_LEVEL" ]
  then
    ranger
  else
    exit
  fi
}

# # colorize them manpages
# man() {
# 	env \
# 		LESS_TERMCAP_md=$'\e[1;36m' \
# 		LESS_TERMCAP_me=$'\e[0m' \
# 		LESS_TERMCAP_se=$'\e[0m' \
# 		LESS_TERMCAP_so=$'\e[1;40;92m' \
# 		LESS_TERMCAP_ue=$'\e[0m' \
# 		LESS_TERMCAP_us=$'\e[1;32m' \
# 			man "$@"
# }

# export PATH="$HOME/.rbenv:$PATH"
# export PATH="/usr/local/heroku/bin:$PATH"
# export PATH="$PATH:$HOME/.script"
# export PATH="/usr/local/sbin:$PATH"
# export PATH="/usr/local/bin:$PATH"
# # openssl shit
# export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
# export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
# export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

# # export PATH="$HOME/.yarn/bin:$PATH"
# # export LIBRARY_PATH="/usr/local/opt/openssl@1.1/lib"

# PATH
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
export PATH="/usr/local/bin:$PATH"
eval "$(rbenv init -)"
eval "$(fnm env --multi --use-on-cd)"
