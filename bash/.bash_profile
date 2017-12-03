PATH=~/bin:~/node_modules/.bin:$PATH

export PATH=$PATH:/usr/local/mysql/bin:/usr/local/sbin:/usr/local/share/npm/bin
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export JRUBY_OPTS="--1.9"
export GH_USERNAME=dkastner

if [ -f ~/.vault-token ]; then
  export VAULT_MASTER_TOKEN=$(cat ~/.vault-token)
fi

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


# rails
#######

function generate_migration() {
  script/generate migration $1 > /tmp/migration_output
  cat /tmp/migration_output | grep create | awk '{ print $2 }' | pbcopy
  cat /tmp/migration_output
}


# misc
######

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

if xmodmap 2>/dev/null > /dev/null; then
  xmodmap ~/.xmodmap 2>/dev/null >/dev/null
fi

# aliases

## git
alias grcontinue='git rebase --continue'
alias grskip='git rebase --skip'
alias gpom='git push origin master'
alias gpum='git push upstream master'
alias gphm='git push heroku master'
alias gpor='git fetch origin; git reset --hard origin/master'

## ruby
alias chrome='open -a "Google Chrome"'
alias preview='open -a Preview'

# MacPorts Installer addition on 2011-06-08_at_12:27:42: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

alias tmux='tmux -2'
alias ack='ag'

if [ -f $HOME/.rbenv/bin/rbenv ]; then
  export EDITOR=/usr/bin/vim
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

if [ -f $HOME/.nodenv/bin/nodenv ]; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

if dircolors 2>/dev/null >/dev/null; then
  eval `dircolors $HOME/.dircolors`
  alias ls='ls --color=auto'
else
  export CLICOLOR=1
fi

export PATH="$HOME/.cargo/bin:$PATH"
