source lib/colors.sh

new_conf="$(pwd)/configs"

configure_xbindkeys() {
    cp $new_conf/xbindkeys/.xbindkeysrc ~/.xbindkeysrc

    xbindkeys
}

configure_skype() {
    cp -avr $new_conf/Skype ~/.config
}

configure_terminator() {
    local term_conf=~/.config/terminator

    if [ ! -d $term_conf ]; then
      mkdir $term_conf
    fi

    cp $new_conf/terminator/config $term_conf/config
}

install_subl_package_control(){
    (
     mkdir ~/.config/sublime-text-3
     mkdir ~/.config/sublime-text-3/Installed\ Packages
     cd ~/.config/sublime-text-3/Installed\ Packages &&
     wget https://sublime.wbond.net/Package%20Control.sublime-package --no-check-certificate
    )
}

install_subl_abgrammer_theme(){
    (
     mkdir ~/.config/sublime-text-3/Packages
     cd ~/.config/sublime-text-3/Packages &&
     git clone https://github.com/AleksSenkou/abgrammer-theme/ "Theme - Abgrammer"
    )
}

configure_subl(){
    local subl_user_conf=~/.config/sublime-text-3/Packages/User

    cp $new_conf/subl/keymap $subl_user_conf/Default\ \(Linux\).sublime-keymap &&
    cp $new_conf/subl/settings $subl_user_conf/Preferences.sublime-settings &&
    cp $new_conf/subl/package_control_settings $subl_user_conf/Package\ Control.sublime-settings &&
    cp $new_conf/subl/group_switcher.py $subl_user_conf/group_switcher.py
}

change_shell_to_zsh(){
    chsh -s `which zsh`
}

configure_zsh(){
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

configure_git(){
    local email name

    git config --global color.ui true

    brown_msg "Enter git user.email:"
    read email &&
    git config --global user.email $email &&

    brown_msg "Enter git user.name:"
    read name &&
    git config --global user.name $name
}

configure_firefox(){
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
    read user_name &&

    sudo adduser $user_name &&
    sudo adduser $user_name sudo &&
    su $user_name
}

configure_nginx(){
    local nginx_default=/etc/nginx/sites-enabled/default
    local nginx_conf=/etc/nginx/nginx.conf

    brown_msg 'Type domain name, please:'
    read domain &&
    brown_msg "\nType app name, please:"
    read app_name &&

    sudo cp nginx/nginx.conf $nginx_conf &&
    sudo sed -ibak -e "s/USER/$user_name/g" $nginx_conf &&

    sudo cp nginx/default $nginx_default &&
    sudo sed -ibak -e "s/USER/$user_name/g" $nginx_default &&
    sudo sed -ibak -e "s/DOMAIN/$domain/g" $nginx_default &&
    sudo sed -ibak -e "s/APP/$app_name/g" $nginx_default
}

disable_caps_lock_on_startup(){
    sudo cp disable_caps_lock /etc/init.d/
    sudo chmod ugo+x /etc/init.d/disable_caps_lock
    sudo update-rc.d disable_caps_lock defaults
}
