source colors.sh

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
