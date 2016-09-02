# Path to your oh-my-zsh installation.
export ZSH=/home/aleks/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

CUSTOM_CONF=~/Documents/ubuntu_configuration/configs

export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH=$PATH:$CUSTOM_CONF

eval "$(rbenv init -)"

###################################################
# Black        0;30     Dark Gray     1;30
# Blue         0;34     Light Blue    1;34
# Green        0;32     Light Green   1;32
# Cyan         0;36     Light Cyan    1;36
# Red          0;31     Light Red     1;31
# Purple       0;35     Light Purple  1;35
# Brown/Orange 0;33     Yellow        1;33
# Light Gray   0;37     White         1;37
#################  SYSTEM  ###########################

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

alias ohmyzsh="mate ~/.oh-my-zsh"
alias zshrc="subl ~/.zshrc"
alias skype="LD_PRELOAD=/usr/lib/i386-linux-gnu/libv4l/v4l1compat.so skype"
############  Backup configs  ###############

copy_subl_configs() {
    local subl_user_conf=~/.config/sublime-text-3/Packages/User

    cp $subl_user_conf/Default\ \(Linux\).sublime-keymap $CUSTOM_CONF/subl/keymap &&
    cp $subl_user_conf/Preferences.sublime-settings $CUSTOM_CONF/subl/settings &&
    cp $subl_user_conf/Package\ Control.sublime-settings $CUSTOM_CONF/subl/package_control_settings
    cp $subl_user_conf/group_switcher.py $CUSTOM_CONF/subl/group_switcher.py
}

backup_configs() {
    # copy zshrc
    cp ~/.zshrc $CUSTOM_CONF/.zshrc &&
    # copy terminator configs
    cp ~/.config/terminator/config $CUSTOM_CONF/terminator/config &&
    # copy subl configs
    cp -avr ~/.config/Skype $CUSTOM_CONF &&
    # copy custom key bindings
    cp ~/.xbindkeysrc $CUSTOM_CONF/xbindkeys &&

    copy_subl_configs

    cd $CUSTOM_CONF
}

############  GIT  ################################
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gcl="git clone"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gpull="git pull --rebase"
alias gl="git log"
alias gm="git merge"
alias grh="git reset HEAD"
alias gsh="git show"
alias gst="git status"
alias gstore="git config credential.helper store"
alias g-st="git stash"
alias g-sta="git stash apply"

gitinit() {
    local repo=${PWD##*/}
    local repo_name_as_json='{"name":"'"${repo}"'"}'

    curl -u 'AleksSenkou' https://api.github.com/user/repos -d $repo_name_as_json

    git init

    echo "## $repo" >> README.md
    git add README.md
    git commit -m "initialize $repo"

    git remote add origin https://github.com/AleksSenkou/$repo.git
    git push -u origin master
}

gpush() {
    local remote_server
    local remote_branch

    if [ -z "$1" ] ; then
        remote_server="origin"
    else
        remote_server="$1"
    fi

    if [ -z "$2" ] ; then
        remote_branch="master"
    else
        remote_branch="$2"
    fi

    git push $remote_server $remote_branch
}

gacp() {
    local remote_server
    local remote_branch

    if [ -z "$2" ] ; then
        remote_server="origin"
    else
        remote_server="$2"
    fi

    if [ -z "$3" ] ; then
        remote_branch="master"
    else
        remote_branch="$3"
    fi

    git add -A &&
    git commit -m "$1" &&
    git push $remote_server $remote_branch
}
###################################################

############  SYSTEM  #############################
alias x="exit"
alias sapi="sudo apt-get install"
alias sapu="sudo apt-get update"
alias sapp="sudo apt-get purge"
alias s="subl"
###################################################

############  RAILS  ##############################
alias gi="gem install"
alias gu="gem update"
alias cu='cucumber'
alias bi="bundle install"
alias bu="bundle update"
alias rnew="rails new . -m https://raw.github.com/RailsApps/rails-composer/master/composer.rb"
alias rs="rails s"
alias rc="rails c"
alias rcsand="rails c --sandbox"
alias rg="rails g"
alias rgc="rails g controller"
alias rgmo="rails g model"
alias rgmi="rails g migration"
alias rdes="rails d"
alias rdesc="rails d controller"
alias rdesmo="rails d model"
alias rdesmi="rails d migration"
alias rr="rake routes"
alias rdbd="rake db:drop"
alias rdbr="rake db:reset"
alias rdbm="rake db:migrate"
alias rdbs="rake db:setup"
###################################################
