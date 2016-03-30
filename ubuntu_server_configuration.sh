#! /bin/bash

for file in lib/*.sh; do source $file; done

green_msg "....... Soft and tools installation .......\n\n"

select_text_color

create_user_account &&

###### TOOLS ######
install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev &&

install_helping_tools &&
install_java &&
install_mysql &&
install_pg &&

###### LNG ######
install python3.5 &&
install_nodejs &&
install_ruby_and_rails &&

###### Passenger & Nginx ######
add_passenger_repo &&

install nginx-extras passenger &&
sudo service nginx start &&

configure_nginx &&
sudo service nginx restart
