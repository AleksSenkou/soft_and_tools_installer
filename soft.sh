source colors.sh

install() {
    local args=("$@")

    for((i=0; i < $#; i++))
    {
        blue_msg ". ${args[$i]} ."
        sudo apt-get -y install ${args[$i]}

        printf '\n'
    }
}

remove() {
    sudo apt-get remove -y $1
}

add_repo() {
    sudo add-apt-repository -y "$1"
}

add_soft_repositories() {
    add_repo "ppa:webupd8team/sublime-text-3"
    add_repo "ppa:linrunner/tlp"
    add_repo "ppa:numix/ppa"
    add_repo "ppa:yorba/ppa"
    add_repo "ppa:danielrichter2007/grub-customizer"
    add_repo "ppa:fkrull/deadsnakes"

    sudo dpkg --add-architecture i386 # 32-bits architecture for skype and wine
    add_repo "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
    add_repo "ppa:ubuntu-wine/ppa"

    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

    sudo apt-get update
}
