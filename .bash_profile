
PATH=~/bin:$PATH

# rvm-install added line:
if [[ -s /Users/dkastner/.rvm/scripts/rvm ]] ; then source /Users/dkastner/.rvm/scripts/rvm ; fi

export HISTCONTROL=ignoreboth
shopt -s histappend
export PROMPT_COMMAND='history -a'
export HISTIGNORE="sudoh"
export PATH=$PATH:/usr/local/mysql/bin

# git
#####

function gpr () {
  remote=${1:-"origin"}
  branch=${2:-"master"}
  git pull --rebase $remote $branch
}

function gpom () {
  git push origin master
}


# ruby
######

function gemdir () {
  gem env gemdir;
}

function rakedb() {
  rake db:migrate
  rake db:migrate RAILS_ENV=test
}

function cuke() {
  cucumber --tags @dev
}

function sudoh() {
  hist_item=`tail -n 1 ~/.bash_history` 
  echo "SUDO $hist_item"
  echo $hist_item | xargs sudo
}

function hagpull() {
  set -x
  cd ~/cm1
  git pull
  cd ~/data1
  git pull
  cd ~/wlpf1
  git pull
  cd ~/hagar1
  git pull
}


# misc
######

function delline () {
  sed -i '' "$2d" $1
}
