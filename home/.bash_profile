PATH=~/bin:~/node_modules/.bin:$PATH

# rvm-install added line:
if [[ -s /Users/dkastner/.rvm/scripts/rvm ]] ; then source /Users/dkastner/.rvm/scripts/rvm ; fi

export HISTCONTROL=ignoreboth
shopt -s histappend
export PROMPT_COMMAND='history -a'
export HISTIGNORE="sudoh"
export PATH=$PATH:/usr/local/mysql/bin:/usr/local/sbin:./bin:/usr/local/share/npm/bin
export JRUBY_OPTS="--1.9"
#export GEM_REPO=http://localhost:8808

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

function github() {
  if [ "$2" == "" ]
  then
    open "http://github.com/$1"
  elif [ "$3" == "" ]
  then
    open "http://github.com/$1/$2"
  elif [ "$4" == "" ]
  then
    open "http://github.com/$1/$2/tree/master/$3"
  else
    open "http://github.com/$1/$2/tree/$3/$4"
  fi
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

function delline () {
echo $1
echo $2
  sed -i '' "$2d" $1
}

function delline_search () {
  for line in `ack $1 --noheading`
  do
    echo $line | awk 'BEGIN { FS = ":" } ; { print $1 } { print $2 }' | xargs delline
  done
}

function search_and_replace() {
  ext=$1
  search=$2
  replace=$3
  path=${4:-"."}
  for file in $(find $path -type f -name "*$ext")
  do
    echo "sar $file"
    file_with_dot=$file
    file=`echo $file | sed "s/\.//"`
    file="$file"
    sed -e "s/$search/$replace/g" -i .sed $file_with_dot
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
alias gpum='git push upstream master'
alias gphm='git push heroku master'
alias gpor='git fetch origin; git reset --hard origin/master'

## ruby
alias cuke='cucumber --tags @dev'
alias gemdir='gem env gemdir'
alias rakedb='rake db:migrate; rake db:migrate RAILS_ENV=test'

alias patch_release='rake version:bump:patch release'
alias minor_release='rake version:bump:minor release'
alias major_release='rake version:bump:major release'

alias chrome='open -a "Google Chrome"'
alias preview='open -a Preview'

# MacPorts Installer addition on 2011-06-08_at_12:27:42: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

alias ls='ls --color=auto'

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

export EDITOR=/usr/bin/vim
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

eval `dircolors $HOME/.dircolors`
