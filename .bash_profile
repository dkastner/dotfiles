PATH=~/bin:$PATH

# rvm-install added line:
if [[ -s /Users/dkastner/.rvm/scripts/rvm ]] ; then source /Users/dkastner/.rvm/scripts/rvm ; fi

export HISTCONTROL=ignoreboth
shopt -s histappend
export PROMPT_COMMAND='history -a'
export HISTIGNORE="sudoh"
export PATH=$PATH:/usr/local/mysql/bin:/usr/local/sbin

# git
#####

function gpr () {
  remote=${1:-"origin"}
  branch=${2:-"master"}
  git pull --rebase $remote $branch
}

function gpo () {
  git push origin $1
}


# ruby
######

function geminstall () {
  gem install $1 --no-rdoc --no-ri
}

# rails
#######

function generate_migration() {
  script/generate migration $1 > /tmp/migration_output
  cat /tmp/migration_output | grep create | awk '{ print $2 }' | pbcopy
  cat /tmp/migration_output
}


# misc
######

function sudoh() {
  hist_item=`tail -n 1 ~/.bash_history` 
  echo "SUDO $hist_item"
  echo $hist_item | xargs sudo
}

function mod_devgem() {
  var="LOCAL_`echo $2 | tr 'a-z' 'A-Z'`"

  if [ "$1" == "disable" ]
  then
    echo "unset $var"
    unset $var
  else
    dir=${3:-"~/$2"}
    echo "export $var=$dir"
    export $var=$dir
  fi
}

function devgems () {
  # Usage: devgems [enable|disable] [gemname]
  cmd=${1:-"enable"}

  if [ "$1" == "list" ]
  then
    env | grep LOCAL
    return
  fi

  if [ -z $2 ]
  then
    mod_devgem $cmd characterizable
    mod_devgem $cmd cohort_scope
    mod_devgem $cmd falls_back_on
    mod_devgem $cmd leap
    mod_devgem $cmd loose_tight_dictionary
    mod_devgem $cmd sniff
    mod_devgem $cmd data_miner
    mod_devgem $cmd earth
  else
    mod_devgem $cmd $2
  fi

  export NOBUNDLE=true
  rake gemspec
  unset NOBUNDLE
}

function delline () {
  sed -i '' "$2d" $1
}

function search_and_replace() {
  ext=$1
  search=$2
  replace=$3
  path=${4:-"."}
  for file in $(find $path -type f -name "*$ext")
  do
    echo "sar $file"
    file=`echo $file | sed "s/\.//"`
    file="$file"
    sed -e "s/$search/$replace/g" -i .sed $file
    rm -f $file.sed
  done
}

function clean() {
  ext=${1:-"swp"}
  find . -name *.$ext | xargs rm -f
}

function emitters() {
  cmd=$1
  # emitters=(automobile bus_trip diet flight fuel_purchase motorcycle pet rail_trip purchase rail_trip residence)
  emitters=( diet flight fuel_purchase motorcycle pet rail_trip purchase rail_trip residence )
    
  if [ "$1" == "release" ]
  then
    msg=$2
    for emitter in ${emitters[@]}
    do
      echo "Processing $emitter"
      cd "/Users/dkastner/$emitter"
      rake gemspec
      git commit -am $cmd
      patch_release
    done
  fi
}


# aliases

## git
alias grcontinue='git rebase --continue'
alias grskip='git rebase --skip'
alias gpom='git push origin master'
alias gphm='git push heroku master'

## ruby
alias cuke='cucumber --tags @dev'
alias gemdir='gem env gemdir'
alias rakedb='rake db:migrate; rake db:migrate RAILS_ENV=test'

alias patch_release='rake version:bump:patch release'
alias minor_release='rake version:bump:minor release'
alias major_release='rake version:bump:major release'

