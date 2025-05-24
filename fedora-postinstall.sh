#!/bin/bash

set -e

# Configurar DNF para confirmar automaticamente
echo "assumeyes=True" | sudo tee -a /etc/dnf/dnf.conf

# Ativar RPM Fusion
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Atualizar sistema
sudo dnf upgrade -y

# Repositórios adicionais
sudo dnf copr enable -y kwizart/fedy

# Ferramentas essenciais
sudo dnf install -y   git neovim curl wget unzip htop btop ncdu   gnome-tweaks gnome-extensions-app   gparted timeshift p7zip p7zip-plugins   vlc ffmpeg ffmpeg-libs gimp obs-studio   libreoffice inkscape transmission qbittorrent   gnome-boxes file-roller redshift   util-linux-user fontconfig   java-latest-openjdk python3-pip   awscli azure-cli docker-compose podman   code conda zsh gnome-shell-extension-pop-shell   mesa-vdpau-drivers-freeworld mesa-va-drivers-freeworld

# Extensões GNOME recomendadas
gnome-extensions install user-theme
gnome-extensions enable user-theme

# Instalar fontes (Fira Code)
sudo dnf install -y fira-code-fonts

# Configurar Timeshift
sudo timeshift --create --comments "Initial Snapshot" --tags D

# Flatpaks úteis
flatpak install -y flathub   com.usebottles.bottles   org.telegram.desktop   com.github.jeromerobert.pdfarranger   org.kde.okular

# Configurar Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
bash /tmp/miniconda.sh -b -p $HOME/miniconda
eval "$($HOME/miniconda/bin/conda shell.bash hook)"
conda init
conda create -y -n ds python=3.11
conda activate ds

# Ajustes de sistema
sudo timedatectl set-local-rtc 0
sudo systemctl disable NetworkManager-wait-online.service

# Fim
echo "Configuração concluída. Reinicie o sistema para aplicar todas as alterações."
