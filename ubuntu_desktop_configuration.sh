#! /bin/bash

for file in lib/*.sh; do source $file; done

green_msg "....... Soft and tools installation .......\n\n"

select_text_color

###### SOFT ######
add_soft_repositories &&

install tmux terminator sublime-text-installer skype gparted geary vlc rar &&
install wine playonlinux &&
install nemo nemo-fileroller &&
install firefox devilspie google-chrome-stable chromium-browser opera &&
install grub-customizer gimp unetbootin &&
install virtualbox vagrant &&
install xbindkeys xbindkeys-config &&

###### TOOLS ######
install git-all &&
install zsh git-core &&
install cmake &&
install_oh_my_zsh &&
install build-essential libgl1-mesa-dev && # qt
install ssh gnome-alsamixer &&
install_java_with_elastic &&
install_helping_tools &&
install_mysql &&
install_pg &&
install libsqlite3-dev && #sqlite dependencies

###### CONFIGS ######
set_default_programs &&
install_subl_package_control &&
install_subl_abgrammer_theme &&
configure_subl &&
configure_skype &&
configure_terminator &&
configure_zsh &&
configure_git &&
configure_firefox &&
configure_xbindkeys &&
disable_apport &&
disable_caps_lock_on_startup &&

remove update-notifier emacs24 emacs &&

###### GUI ######
install numix-icon-theme-circle &&
set_numix_icons &&
show_date_and_seconds_in_top_bar &&
set_system_shortcuts &&

###### LNG ######
install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev libgmp-dev libreadline-dev &&
install python3.5 &&
install_nodejs &&
install_rbenv &&
install_ruby_and_rails &&

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
