RED='\033[0;31m'
GREEN='\033[0;32m'
WHITE="\033[1;37m"
BLACK="\033[0;30m"
BLUE='\033[0;34m'
BROWN='\033[0;33m'

# Cyan         0;36
# Purple       0;35

select_text_color(){
    local selected_color=""

    brown_msg "Select black or white text output color\n"

    while [[ "$selected_color" != "b" && "$selected_color" != "w" ]]; do
      brown_msg "Enter 'w' or 'b': "
      read selected_color
    done

    if [[ "$selected_color" = "w" ]]; then text_color=$WHITE; else text_color=$BLACK; fi

    printf "${text_color} \n"
}

green_msg() {
    printf "${GREEN}$1${text_color}"
}

brown_msg() {
    printf "${BROWN}$1${text_color}"
}

red_msg(){
    printf "${RED}$1${text_color}"
}

blue_msg() {
    printf "${BLUE}$1${text_color}"
}
