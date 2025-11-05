# 🚀 IP Scanner Pro
  
![GitHub CI](https://github.com/trmxvibs/IPScanPro/actions/workflows/ci.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Version](https://img.shields.io/badge/Version-1.1.0-blue.svg)
![Made with](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)
![Platforms](https://img.shields.io/badge/Platform-Termux%20%7C%20Linux%20%7C%20macOS-lightgrey.svg)

Welcome to IP Scanner Pro! This handy Bash script lets you uncover detailed information about any IPv4 or IPv6 address with ease. It's built for security, portability, and power.


---

##  Features

* **Multi-OS Support:** A smart installer that works on Termux, Debian (Kali, Ubuntu), Arch, Fedora, and macOS.
* **IP Details:** Get comprehensive info: location, organization, timezone, and more.


## 💻 Supported Operating Systems
The installer will automatically detect and work on:

- `Termux (Android)`

- `Debian-based Linux (Ubuntu, Kali Linux, Parrot OS)`

- `Arch-based Linux (Manjaro, Garuda)`

- `Fedora-based Linux`

- `macOS (using Homebrew)`


##  Installation

The smart installer handles all dependencies (like `python`, `jq`, `figlet`, `nmap`) for you.


## 1. Clone the repository
```bash
git clone https://github.com/trmxvibs/IPScanPro
```
## 2. Navigate into the directory
```bash
cd IPScanPro
```

## 3. Make the installer executable
```bash
chmod +x install.sh
```

## 4. Run the installer (use sudo if on Linux/macOS)
```bash
./install.sh
```
## or for Linux/macOS:
```bash
sudo ./install.sh
```
- After installation, restart your terminal and run the tool from anywhere using the ip command.

#  Important: API Key Setup
- ***This tool uses the ipinfo.io API, which requires a free access token.***

- Go to [ipinfo](https://ipinfo.io/signup) to get your free API token.

- Run the install.sh script. It will automatically ask you to paste your token.

- Your token is saved securely in $HOME/.config/ipscanner/config.

- The tool will not work without this token.
##  Example Output
```python
--- IP Address Details ---
IP Address: 8.8.8.8
Hostname: dns.google
City: Mountain View
Region: California
Country: US
Location: 37.4056,-22.0775
Organization: AS15169 Google LLC
Postal Code: 94043
Timezone: America/Los_Angeles
----------------------------
Details saved to: /home/user/IP_Scanner_Results/8.8.8.8_Report.txt
```




  
