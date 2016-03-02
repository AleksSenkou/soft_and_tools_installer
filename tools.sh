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

install_pg(){
    sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
    wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

    sudo apt-get update

    install postgresql-common postgresql-9.3 libpq-dev
    sudo -u postgres createuser aleks -s
}
