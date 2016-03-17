source lib/colors.sh

new_conf="$(pwd)/../configs/"

paste_skype_configs() {
    cp -avr $new_conf/Skype ~/.config
}

paste_terminator_configs() {
    local term_conf=~/.config/terminator

    if [ ! -d $term_conf ]; then
      mkdir $term_conf
    fi

    cp $new_conf/terminator/config $term_conf/config
}

install_subl_package_control(){
    (
     mkdir ~/.config/sublime-text-3/Installed\ Packages
     cd ~/.config/sublime-text-3/Installed\ Packages &&
     wget https://sublime.wbond.net/Package%20Control.sublime-package
    )
}

install_subl_abgrammer_theme(){
    (
     cd ~/.config/sublime-text-3/Packages &&
     git clone https://github.com/bahit/abgrammer-theme/ "Theme - Abgrammer"
    )
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

set_default_programs(){
    gsettings set org.gnome.desktop.background show-desktop-icons false
    xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

    cp $new_conf/defaults.list ~/.local/share/applications/defaults.list
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
    gsettings set org.gnome.desktop.interface clock-show-date true
    gsettings set org.gnome.desktop.interface clock-show-seconds true
}

set_system_shortcuts(){
    ### Windows swithing
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Ctrl><Alt>Down']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Ctrl><Alt>Up']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['']"

    ### Screenshots shortcuts
    gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip '<Ctrl>Print'
    gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip '<Ctrl><Shift>Print'

    ### Volume up/down
    gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up '<Ctrl>equal'
    gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down '<Ctrl>minus'
}

link_to_zukitre_theme(){
    echo 'find zukitre here:'
    brown_msg "www.deviantart.com/download/499776227/zukitre_shell_by_tgraeca84-d89jxsz.zip?token=f6dfbd58a594cd30c8b13951d636bdfe191ba7cf&ts=1456844663 \n"
}

create_user_account(){
    brown_msg 'Type user name, please:'
    read user_name

    sudo adduser $user_name
    sudo adduser $user_name sudo
    su $user_name
}

config_nginx(){
    local nginx_default=/etc/nginx/sites-enabled/default
    local nginx_conf=/etc/nginx/nginx.conf

    brown_msg 'Type domain name, please:'
    read domain
    brown_msg "\nType app name, please:"
    read app_name

    sudo cp nginx/nginx.conf $nginx_conf
    sudo sed -ibak -e "s/USER/$user_name/g" $nginx_conf

    sudo cp nginx/default $nginx_default
    sudo sed -ibak -e "s/USER/$user_name/g" $nginx_default
    sudo sed -ibak -e "s/DOMAIN/$domain/g" $nginx_default
    sudo sed -ibak -e "s/APP/$app_name/g" $nginx_default
}

# disable_caps_lock(){
#     setxkbmap -option caps:none
# }

# start_low_power_mode(){
#     sudo tlp start
# }
