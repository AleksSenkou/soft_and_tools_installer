source colors.sh

clone() {
    brown_msg ". Cloning configs... \n"

    local folder=$1

    cd .. &&
    git clone https://github.com/AleksSenkou/$folder &&
    cd $folder

    new_conf="$(pwd)"
}

paste_skype_configs() {
    cp -avr $new_conf/Skype ~/.config/Skype
}

paste_terminator_configs() {
    local term_conf=~/.config/terminator

    if [ ! -d $term_conf ]; then
      mkdir $term_conf
    fi

    cp $new_conf/terminator/config $term_conf/config
}

install_subl_package_control(){
    cd ~/.config/sublime-text-3/Installed\ Packages &&
    wget https://sublime.wbond.net/Package%20Control.sublime-package
}

paste_subl_configs(){
    local subl_user_conf=~/.config/sublime-text-3/Packages/User

    cp $new_conf/subl/keymap $subl_user_conf/Default\ \(Linux\).sublime-keymap &&
    cp $new_conf/subl/settings $subl_user_conf/Preferences.sublime-settings &&
    cp $new_conf/subl/package_control_settings $subl_user_conf/Package\ Control.sublime-settings
}

change_shell_to_zsh(){
    chsh -s `which zsh`
}

paste_zsh_configs(){
    cp $new_conf/.zshrc ~/.zshrc
}

make_nemo_default_file_manager(){
    gsettings set org.gnome.desktop.background show-desktop-icons false
    xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
}

disable_apport(){
    sudo service apport stop
    sudo sed -ibak -e s/^enabled\=1$/enabled\=0/ /etc/default/apport
}

config_git(){
    local email name

    git config --global color.ui true

    brown_msg "Enter git user.email:"
    read email
    git config --global user.email $email

    brown_msg "Enter git user.name:"
    read name
    git config --global user.name $name

    blue_msg "Saving credentials \n"
    git config credential.helper store
    git push https://github.com/AleksSenkou/soft_and_tools_installer.git
}

config_firefox(){
    mkdir ~/.devilspie
    touch ~/.devilspie/flash-fullscreen-firefox.ds
    printf '%s\n%s\n' '(if' '(is (application_name) "plugin-container")' '(begin' '(focus)' ')' ')' >> ~/.devilspie/flash-fullscreen-firefox.ds
}

set_numix_icons(){
    gsettings set org.gnome.desktop.interface icon-theme 'Numix-Circle'
}

show_date_and_seconds_in_top_bar(){
    gsettings set org.gnome.deskop.interface clock-show-date true
    gsettings set org.gnome.desktop.interface clock-show-seconds true
}

link_to_zukitre_theme(){
    echo 'find zukitre here:'
    brown_msg "www.deviantart.com/download/499776227/zukitre_shell_by_tgraeca84-d89jxsz.zip?token=f6dfbd58a594cd30c8b13951d636bdfe191ba7cf&ts=1456844663 \n"
}

# disable_caps_lock(){
#     setxkbmap -option caps:none
# }

# start_low_power_mode(){
#     sudo tlp start
# }
