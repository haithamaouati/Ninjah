#!/bin/bash

# Author: Haitham Aouati
# GitHub: github.com/haithamaouati

# Clear the screen
clear

# Colors
nc="\e[0m"
bold="\e[1m"
underline="\e[4m"
bold_green="\e[1;32m"
bold_red="\e[1;31m"
bold_yellow="\e[1;33m"

# Config
BASE_URL="https://raw.githubusercontent.com/ErcinDedeoglu/proxies/main/proxies"
FILES=(socks4.txt socks5.txt http.txt https.txt)

# ASCII Banner
banner() {
    echo -e "${bold_green}"
    cat << 'EOF'
     __  _           _         _
  /\ \ \(_) _ __    (_)  __ _ | |__
 /  \/ /| || '_ \   | | / _` || '_ \
/ /\  / | || | | |  | || (_| || | | |
\_\ \/  |_||_| |_| _/ | \__,_||_| |_|
                  |__/
EOF
    echo -e "${nc}"
    echo -e "${bold_green} Ninjah${nc} — Proxy list updated hourly.\n"
    echo -e " Author: Haitham Aouati"
    echo -e " GitHub: ${underline}github.com/haithamaouati${nc}\n"
}

# Functions

download_proxy() {
    local choice=$1
    local file=${FILES[$choice]}

    if [[ -f $file ]]; then
        echo -e "\n${bold_yellow}[!]${nc} $file already exists. Removing old version..."
        rm -f "$file"
    fi

    echo -e "\n${bold}[*]${nc} Downloading $file..."
    if curl -fsSL -o "$file" "$BASE_URL/$file"; then
        echo -e "${bold_green}[+]${nc} Download complete: $file"
    else
        echo -e "${bold_red}[!]${nc} Failed to download $file. Check your connection or the source URL."
    fi
}

download_all() {
    echo -e "\n${bold}[*]${nc} Downloading all proxy lists..."
    for i in "${!FILES[@]}"; do
        download_proxy "$i"
    done
}

remove_all() {
    echo -e "\n${bold}[*]${nc} Removing all proxy files..."
    for file in "${FILES[@]}"; do
        [[ -f $file ]] && rm -f "$file" && echo -e "${bold_green}[+]${nc} Removed $file"
    done
}

show_menu() {
    banner
    echo -e "${bold}Proxy Downloader Menu${nc}\n"
    echo -e "${bold_yellow} [1]${nc} Download SOCKS4"
    echo -e "${bold_yellow} [2]${nc} Download SOCKS5"
    echo -e "${bold_yellow} [3]${nc} Download HTTP"
    echo -e "${bold_yellow} [4]${nc} Download HTTPS"
    echo -e "${bold_yellow} [5]${nc} Download All Proxies"
    echo -e "${bold_yellow} [6]${nc} Remove All Proxies"
    echo -e "${bold_red} [7]${nc} Exit\n"
    echo -n "Select an option [1-7]: "
}

# Main Loop

while true; do
    show_menu
    read -r opt
    case $opt in
        1) download_proxy 0 ;;
        2) download_proxy 1 ;;
        3) download_proxy 2 ;;
        4) download_proxy 3 ;;
        5) download_all ;;
        6) remove_all ;;
        7) echo -e "${bold_red}Exiting.${nc}\n"; break ;;
        *) echo -e "${bold_red}[!]${nc} Invalid option." ;;
    esac
done
