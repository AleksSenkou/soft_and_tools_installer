source lib/colors.sh

install() {
    local args=("$@")

    for((i=0; i < $#; i++))
    {
        blue_msg ". ${args[$i]} .\n\n"
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

    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

    sudo dpkg --add-architecture i386 # 32-bits architecture for skype and wine
    add_repo "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
    add_repo "ppa:ubuntu-wine/ppa"

    sudo sed -i -e 's/deb http/deb [arch=amd64] http/' "/etc/apt/sources.list.d/google-chrome.list"
    sudo apt-get update
}

add_passenger_repo(){
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
    install apt-transport-https ca-certificates

    sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
    sudo apt-get update
}
