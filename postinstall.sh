#!/usr/bin/env bash

# ----------------------------- VARIÁVEIS ----------------------------- #
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"
PPA_OPENJDK_8="ppa:openjdk-r/ppa"

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_SIMPLE_NOTE="https://github.com/Automattic/simplenote-electron/releases/download/v1.12.0/Simplenote-linux-1.12.0-amd64.deb"

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(
  snapd
  mint-meta-codecs
  build-essential
  libssl-dev
  gcc-multilib
  lib32z1
  lib32gcc1
  libc6-i386
  lib32stdc++6
  libc6-dev
  git
  openjdk-8-jdk
)

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

## Atualizando o repositório ##
sudo apt-get update

sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y
sudo apt-add-repository "$PPA_OPENJDK_8" -y

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt-get update

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_SIMPLE_NOTE"         -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt-get install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

## instalando docker

## uninstall old versions of docker
sudo apt-get remove docker docker-engine docker.io containerd runc -y

sudo apt-get update

### dependencias docker
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

### add official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

### add repository
sudo apt-add-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

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

sudo apt install --no-install-recommends yarn -y

sudo apt-get update && sudp apt dist-upgrade
