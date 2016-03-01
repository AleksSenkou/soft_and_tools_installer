RED='\033[0;31m'
GREEN='\033[0;32m'
BLACK='\033[0;30m'
BLUE='\033[0;34m'
BROWN='\033[0;33m'

green_msg() {
    printf "${GREEN} $1 ${BLACK}"
}

blue_msg() {
    printf "${BLUE}"
    echo $1
    printf "${BLACK}"
}

brown_msg() {
    printf "${BROWN} $1 ${BLACK}"
}

red_msg(){
    printf "${RED} $1"
}

# Cyan         0;36
# Purple       0;35
