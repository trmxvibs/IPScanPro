#!/bin/bash
set -e

# Tool made by Lokesh Kumar

# --- Define Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[93m'
CYAN='\033[96m'
RESET='\033[0m'

# --- Function to display banner ---
display_banner() {
    clear
    echo -e "${CYAN}"
    # Only use 'figlet' and 'lolcat' after they are installed
    if command -v figlet &> /dev/null && command -v lolcat &> /dev/null; then
        figlet -f slant "IP Scanner Pro" | lolcat
    else
        echo "IP Scanner Pro"
    fi
    echo -e "${GREEN}By Lokesh Kumar${RESET}"
    echo -e "${MAGENTA}---------------------------------${RESET}"
    echo -e "${YELLOW}Advanced IP Scanning Tool - Installer${RESET}"
    echo -e "${MAGENTA}---------------------------------${RESET}"
    sleep 2
}

# --- Detect OS and Package Manager ---
OS="Unsupported"
PKG_MANAGER=""
INSTALL_CMD=""
UPDATE_CMD=""
BIN_DIR="/usr/local/bin" # Default
SUDO_CMD="sudo"

if [[ $(uname -o) == "Android" ]]; then
    OS="Termux"
    PKG_MANAGER="pkg"
    SUDO_CMD="" # Termux doesn't use sudo
    BIN_DIR="$PREFIX/bin"
    # Required packages for Termux
    PACKAGES="git python python3-pip curl wget figlet jq nmap coreutils"
    PYTHON_PACKAGES="requests lolcat"
    PYTHON_CMD="pip"
elif [[ -f /etc/debian_version ]]; then
    OS="Debian-based (e.g., Kali, Ubuntu)"
    PKG_MANAGER="apt-get"
    PACKAGES="git python3 python3-pip curl wget figlet jq nmap"
    PYTHON_PACKAGES="requests lolcat"
    PYTHON_CMD="pip3"
elif [[ -f /etc/arch-release ]]; then
    OS="Arch Linux"
    PKG_MANAGER="pacman"
    PACKAGES="git python python-pip curl wget figlet jq nmap"
    PYTHON_PACKAGES="requests lolcat"
    PYTHON_CMD="pip3"
elif [[ -f /etc/fedora-release ]]; then
    OS="Fedora"
    PKG_MANAGER="dnf"
    PACKAGES="git python3 python3-pip curl wget figlet jq nmap"
    PYTHON_PACKAGES="requests lolcat"
    PYTHON_CMD="pip3"
elif [[ $(uname -s) == "Darwin" ]]; then
    OS="macOS"
    PKG_MANAGER="brew"
    if ! command -v brew &> /dev/null; then
        echo -e "${RED}Homebrew (brew) not found.${RESET}"
        echo -e "${YELLOW}Please install Homebrew first: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"${RESET}"
        exit 1
    fi
    PACKAGES="git python3 curl wget figlet jq nmap"
    PYTHON_PACKAGES="requests lolcat"
    PYTHON_CMD="pip3"
else
    echo -e "${RED}Unsupported operating system.${RESET}"
    exit 1
fi

echo -e "${GREEN}Detected OS: $OS${RESET}"

# --- Define Installation Commands ---
case $PKG_MANAGER in
    "apt-get")
        UPDATE_CMD="$SUDO_CMD apt-get update -y"
        INSTALL_CMD="$SUDO_CMD apt-get install -y $PACKAGES"
        ;;
    "pacman")
        UPDATE_CMD="$SUDO_CMD pacman -Syu --noconfirm"
        INSTALL_CMD="$SUDO_CMD pacman -S --noconfirm $PACKAGES"
        ;;
    "dnf")
        UPDATE_CMD="$SUDO_CMD dnf check-update -y"
        INSTALL_CMD="$SUDO_CMD dnf install -y $PACKAGES"
        ;;
    "brew")
        UPDATE_CMD="brew update"
        INSTALL_CMD="brew install $PACKAGES"
        ;;
    "pkg")
        UPDATE_CMD="pkg update -y && pkg upgrade -y"
        INSTALL_CMD="pkg install -y $PACKAGES"
        ;;
esac

# --- Start Installation ---
clear
echo -e "${YELLOW}Updating $OS packages... (This may take some time)${RESET}"
eval "$UPDATE_CMD"

echo -e "${YELLOW}Installing required packages: $PACKAGES...${RESET}"
eval "$INSTALL_CMD"

echo -e "${YELLOW}Installing Python packages: $PYTHON_PACKAGES...${RESET}"
$SUDO_CMD $PYTHON_CMD install $PYTHON_PACKAGES

# --- Clone/Install the tool ---
REPO_URL="https://github.com/trmxvibs/IPScanPro"
INSTALL_DIR="$HOME/.ipscanner"

if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}Old installation found... Removing it...${RESET}"
    rm -rf "$INSTALL_DIR"
fi

echo -e "${YELLOW}Cloning repository into ${INSTALL_DIR}...${RESET}"
git clone "$REPO_URL" "$INSTALL_DIR"

echo -e "${YELLOW}Copying 'ip' script to ${BIN_DIR}...${RESET}"
$SUDO_CMD cp "$INSTALL_DIR/ip" "$BIN_DIR/ip"
$SUDO_CMD chmod +x "$BIN_DIR/ip"

# --- [SECURITY FIX] Setup API Key ---
CONFIG_DIR="$HOME/.config/ipscanner"
CONFIG_FILE="$CONFIG_DIR/config"
mkdir -p "$CONFIG_DIR"

echo -e "\n${CYAN}--- API Key Setup (Required) ---${RESET}"
echo -e "This tool uses ${GREEN}ipinfo.io${RESET}."
echo -e "Please sign up on their website to get your FREE Access Token."
read -p "Paste your ipinfo.io Access Token here: " access_token

if [ -z "$access_token" ]; then
    echo -e "${RED}API Token not entered. Please add it to $CONFIG_FILE later.${RESET}"
    echo "ACCESS_TOKEN=YOUR_KEY_HERE" > "$CONFIG_FILE"
else
    echo "ACCESS_TOKEN=$access_token" > "$CONFIG_FILE"
    echo -e "${GREEN}API Key successfully saved to $CONFIG_FILE.${RESET}"
fi

# --- Finish ---
display_banner
echo -e "${GREEN}Installation complete!${RESET}"
echo -e "${YELLOW}You can now close this terminal, open a new one, and run the tool using the 'ip' command.${RESET}"
