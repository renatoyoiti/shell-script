#!/usr/bin/env bash

# ----------------------------- VARIÁVEIS ----------------------------- #
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"
PPA_OPENJDK_8="ppa:openjdk-r/ppa"

#URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock
sudo rm /etc/apt/preferences.d/nosnap.pref
sudo apt-get update

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

## Atualizando o repositório ##
sudo apt-get update

#sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y
sudo apt-add-repository "$PPA_OPENJDK_8" -y

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt-get update

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
#wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
#wget -c "$URL_SIMPLE_NOTE"         -P "$DIRETORIO_DOWNLOADS"

## Instalando programas necessários ##
sudo apt-get install mint-meta-codecs build-essential git openjdk-8-jdk -y

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

## instalando docker

## uninstall old versions of docker
sudo apt-get remove docker docker-engine docker.io containerd runc -y

sudo apt-get update

### dependencias docker
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

### add official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

### add repository
sudo apt-add-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu hirsute stable"

sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

### permission to user execute docker as root
sudo usermod -aG docker $USER

## install zsh ##
cd ~
sudo apt-get install zsh -y

### change to default shell
chsh -s $(which zsh)

sudo apt-get update

sudo apt update && sudo apt install --no-install-recommends yarn -y

sudo apt-get update && sudp apt dist-upgrade
