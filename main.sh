#! /bin/bash

source colors.sh
source soft.sh
source tools.sh
source configs.sh

green_msg "....... Soft and tools installation .......\n\n"

###### SOFT ######
add_soft_repositories &&
install terminator sublime-text-installer skype gparted geary wine playonlinux vlc &&
install nemo nemo-fileroller &&
install firefox devilspie google-chrome-stable &&

###### TOOLS ######
install git-all &&
install zsh git-core &&
install_oh_my_zsh &&
install build-essential libgl1-mesa-dev && # qt
install icedtea-7-plugin openjdk-7-jre &&  # java
install tlp tlp-rdw lm-sensors htop rar grub-customizer &&
install mysql-server mysql-client libmysqlclient-dev &&
install_pg &&
remove update-notifier &&

###### CONFIGS ######
clone 'linux_conf' && # skype, terminator, zsh and subl configs
paste_skype_configs &&
paste_terminator_configs &&
install_subl_package_control &&
paste_subl_configs &&
paste_zsh_configs &&
set_default_programs &&
config_git &&
config_firefox &&
disable_apport &&

###### GUI ######
install numix-icon-theme-circle &&
set_numix_icons &&
show_date_and_seconds_in_top_bar &&

###### LNG ######
install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev &&
install python3.5 &&
install_nodejs &&
install_ruby &&

###### SHUTDOWN ######
change_shell_to_zsh
link_to_zukitre_theme

red_msg "Are you ready for shutdown?[y/..]"
read shutdown_answer

if [ "$shutdown_answer" = "y" ]
then
  sudo shutdown -r 0
else
  exit
fi
