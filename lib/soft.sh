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

add() {
    sudo add-apt-repository -y "$1"
}

add_soft_repositories() {
    add "ppa:webupd8team/sublime-text-3" &&
    add "ppa:numix/ppa" &&
    add "ppa:yorba/ppa" &&
    add "ppa:danielrichter2007/grub-customizer" &&
    add "ppa:fkrull/deadsnakes" &&
    add "ppa:otto-kesselgulasch/gimp" &&
    add "ppa:gezakovacs/ppa" &&
    add "ppa:webupd8team/java" &&
    add "ppa:linrunner/tlp" &&
    add "ppa:mc3man/trusty-media" &&


    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

    sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list.d/opera.list'
    sudo sh -c 'wget -O - http://deb.opera.com/archive.key | apt-key add -'

    sudo dpkg --add-architecture i386 # 32-bits skype and wine
    add "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
    add "ppa:ubuntu-wine/ppa"

    sudo sed -i -e 's/deb http/deb [arch=amd64] http/' "/etc/apt/sources.list.d/google-chrome.list"


    sudo apt-get update
}

add_passenger_repo(){
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
    install apt-transport-https ca-certificates

    sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
    sudo apt-get update
}
