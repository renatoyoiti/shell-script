#!/usr/bin/env bash

# ----------------------------- VARIÁVEIS ----------------------------- #
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"
PPA_OPENJDK_8="ppa:openjdk-r/ppa"

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_SIMPLE_NOTE="https://github.com/Automattic/simplenote-electron/releases/download/v1.8.0/Simplenote-linux-1.8.0-amd64.deb"

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(
  snapd
  gconf2
  git
  build-essential
  libssl-dev
  openjdk-8-jdk
  gcc-multilib
  lib32z1
  lib32gcc1
  libc6-i386
  lib32stdc++6
  libc6-dev
)

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

## Atualizando o repositório ##
sudo apt update -y
sudo apt upgrade -y
sudo apt-get install openjdk-8-jre

sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y
sudo apt-add-repository "$PPA_OPENJDK_8" -y

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_SIMPLE_NOTE"         -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

## instalando docker

## uninstall old versions of docker
sudo apt-get remove docker docker-engine docker.io containerd runc -y

sudo apt-get update -y

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

## Instalando pacotes Snap ##
sudo snap install spotify
sudo snap install code --classic
sudo snap install skype --classic
sudo snap install insomnia
sudo snap install android-studio --classic

## install zsh ##
cd ~
sudo apt install zsh -y

### change to default shell
chsh -s $(which zsh)

## install oh-my-zsh ##
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

### configure zplugin ###
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

## configure dracula theme for zsh ##
git clone https://github.com/dracula/zsh.git
ln -s $DRACULA_THEME/dracula.zsh-theme $OH_MY_ZSH/themes/dracula.zsh-theme

## install nvm ##
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

## install yarn ##
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update -y

sudo apt install --no-install-recommends yarn -y
