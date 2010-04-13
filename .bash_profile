
PATH=~/bin:$PATH
set -o vi

# rvm-install added line:
if [[ -s /Users/dkastner/.rvm/scripts/rvm ]] ; then source /Users/dkastner/.rvm/scripts/rvm ; fi

export HISTCONTROL=ignoreboth
shopt -s histappend
export PROMPT_COMMAND='history -a'
export HISTIGNORE="sudoh"
export PATH=$PATH:/usr/local/mysql/bin

function gemdir () {
  gem env gemdir;
}

function gpr () {
  remote=${1:-"origin"}
  branch=${2:-"master"}
  git pull --rebase $remote $branch
}

function rakedb() {
  rake db:migrate
  rake db:migrate RAILS_ENV=test
}

function cuke() {
  cucumber --tags @dev
}
