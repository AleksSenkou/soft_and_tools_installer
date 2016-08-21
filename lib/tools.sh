source lib/colors.sh
source lib/soft.sh

get_imagewriter() {
    blue_msg ". imagewriter ."
    cd ~

    wget http://www.linuxspace.org/wp-content/uploads/imagewriter_1.8-5.1_i386.deb
    sudo dpkg -i imagewriter_1.8-5.1_i386.deb

    cd "$OLDPWD"
}

install_java_with_elastic(){
    # OpenJDK
    install icedtea-7-plugin openjdk-7-jre &&

    # Java8
    install oracle-java8-installer &&

    # Elastic
    wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.2.deb &&
    sudo dpkg -i elasticsearch-1.7.2.deb &&
    sudo update-rc.d elasticsearch defaults &&
    sudo service elasticsearch start &&

    rm elasticsearch-1.7.2.deb
}

install_helping_tools(){
    install tlp tlp-rdw lm-sensors htop whois xclip ffmpeg imagemagicksudo libqt4-dev
}

install_oh_my_zsh(){
    cd ~

    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

    cd "$OLDPWD"
}

install_rbenv(){
    cd
    git clone git://github.com/sstephenson/rbenv.git .rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

    git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    exec $SHELL
}

install_ruby_and_rails(){
    git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

    rbenv install 2.2.4
    rbenv install 2.3.0
    rbenv global 2.3.0

    echo "gem: --no-ri --no-rdoc" > ~/.gemrc

    gem install bundler
    gem install rails -v 4.2.4
}

install_nodejs(){
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    install nodejs
}

install_mysql(){
    install mysql-server mysql-client libmysqlclient-dev
}

install_pg(){
    # install postgresql postgresql-contrib libpq-dev
    # sudo su - postgres
    # createuser --interactive --pwprompt
    # exit

    sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
    wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

    sudo apt-get update

    install postgresql-common postgresql-9.3 libpq-dev &&
    sudo -u postgres createuser $USER -s
}
