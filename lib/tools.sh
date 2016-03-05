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

install_ruby_and_rails(){
    cd
    git clone git://github.com/sstephenson/rbenv.git .rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    exec $SHELL

    git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    exec $SHELL

    git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

    rbenv install 2.2.4
    rbenv global 2.2.4

    echo "gem: --no-ri --no-rdoc" > ~/.gemrc

    gem install bundler
    gem install rails -v 4.2.4

    bundle exec spring binstub --all

    cd "$OLDPWD"
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
