#!/bin/bash

set -e

# Variables
USERNAME=$(logname)

# --- System Setup ---

# Enable DNF auto-confirm
echo "assumeyes=True" | sudo tee -a /etc/dnf/dnf.conf

# Enable RPM Fusion (free & nonfree)
sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Enable COPR repositories
sudo dnf copr enable -y kwizart/fedy

# Update everything
sudo dnf upgrade -y

# --- Core Tools & Utilities ---
sudo dnf install -y \
  git curl wget unzip neovim htop btop ncdu \
  gnome-tweaks gnome-extensions-app gparted timeshift \
  p7zip p7zip-plugins vlc ffmpeg ffmpeg-libs gimp \
  libreoffice inkscape transmission qbittorrent \
  gnome-boxes file-roller redshift util-linux-user \
  java-latest-openjdk python3-pip docker-compose podman \
  awscli azure-cli zsh firewall-config dconf-editor \
  papirus-icon-theme gnome-shell-extension-pop-shell \
  steam discord dropbox \
  r-base R R-core R-devel R-doc \
  jetbrains-mono-fonts fira-code-fonts \
  freetype-freeworld fontconfig fontconfig-enhanced-defaults \
  samba cifs-utils fuse fuse-sshfs gvfs-fuse \
  flameshot calibre vlc

# --- Browsers ---

# LibreWolf (main browser)
sudo dnf install -y librewolf

# Chromium (backup browser)
sudo dnf install -y chromium

# Tor Browser (for privacy)
flatpak install -y flathub com.github.micahflee.torbrowser-launcher

# --- VS Code (official repo, not Flatpak) ---
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install -y code

# --- Dropbox Daemon Setup ---
systemctl --user enable dropbox
systemctl --user start dropbox

# --- RStudio ---
wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-latest-amd64.rpm -O /tmp/rstudio.rpm
sudo dnf install -y /tmp/rstudio.rpm

# --- Spotify (via RPM Fusion) ---
sudo dnf install -y lpf-spotify-client
sudo lpf update

# --- Mullvad VPN ---
wget https://mullvad.net/download/app/rpm/latest -O /tmp/mullvad.rpm
sudo dnf install -y /tmp/mullvad.rpm

# --- GNOME & Shell Adjustments ---

# Enable Pop Shell for tiling windows
gnome-extensions enable pop-shell@system76.com

# Set ZSH as default shell
sudo chsh -s $(which zsh) "$USERNAME"

# Create Timeshift Snapshot
sudo timeshift --create --comments "Initial Snapshot" --tags D

# --- Fonts (Windows and Dev Fonts) ---
sudo dnf install -y \
  curl cabextract xorg-x11-font-utils fontconfig \
  msttcore-fonts-installer

# Enable firewall and necessary services
sudo systemctl enable --now firewalld
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

# --- Personalization ---
sudo dnf install -y dconf-editor gnome-shell-extension-user-theme

# --- Conda (optional) ---
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
bash /tmp/miniconda.sh -b -p "$HOME/miniconda"
eval "$($HOME/miniconda/bin/conda shell.bash hook)"
conda init
conda create -y -n ds python=3.11
conda activate ds

# --- Performance Tweaks ---
sudo timedatectl set-local-rtc 0
sudo systemctl disable NetworkManager-wait-online.service

# --- Cleanup ---
sudo dnf autoremove -y
sudo dnf clean all

# --- Final Message ---
echo -e "\n✅ Fedora post-install completed successfully!"
echo "Reboot recommended before using the system."
