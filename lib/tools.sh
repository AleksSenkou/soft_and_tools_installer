source colors.sh
source soft.sh

get_imagewriter() {
    blue_msg ". imagewriter ."
    cd ~

    wget http://www.linuxspace.org/wp-content/uploads/imagewriter_1.8-5.1_i386.deb
    sudo dpkg -i imagewriter_1.8-5.1_i386.deb

    cd "$OLDPWD"
}

install_oh_my_zsh() {
    cd ~

    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

    cd "$OLDPWD"
}

install_ruby(){
    curl -L https://get.rvm.io | bash -s stable
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    source ~/.rvm/scripts/rvm

    red_msg "Maybe u need to change a terminal for ruby installation"

    rvm install 2.3.0
    rvm use 2.3.0 --default

    echo "gem: --no-ri --no-rdoc" > ~/.gemrc
    gem install bundler
}

install_nodejs(){
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    install nodejs
}

install_pg(){
    sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
    wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

    sudo apt-get update

    install postgresql-common postgresql-9.3 libpq-dev
    sudo -u postgres createuser $USER -s
}
