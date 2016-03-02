#! /bin/bash

source colors.sh
source soft.sh
source tools.sh
source configs.sh

green_msg "....... Soft and tools installation .......\n\n"

###### SOFT ######
add_soft_repositories &&
install terminator nemo sublime-text-installer skype gparted wine playonlinux vlc rar &&
install firefox google-chrome-stable &&

###### TOOLS ######
install git-all &&
install zsh git-core &&
install_oh_my_zsh &&
install build-essential libgl1-mesa-dev && # qt
install icedtea-7-plugin openjdk-7-jre &&  # java
install tlp tlp-rdw lm-sensors htop &&
remove update-notifier &&

###### CONFIGS ######
clone 'linux_conf' && # skype, terminator, zsh and subl configs
paste_skype_configs &&
paste_terminator_configs &&
install_subl_package_control &&
paste_subl_configs &&
paste_zsh_configs &&
config_git

###### GUI ######
install numix-icon-theme-circle &&
set_numix_icons &&
show_date_and_seconds_in_top_bar &&

link_to_zukitre_theme

change_shell_to_zsh
# red_msg "Are you ready for shutdown?[ENTER]"
#shutdown_process
#sudo shutdown -r 0
