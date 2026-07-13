#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "[1/6] Aggiorno il sistema..."
sudo apt-get update
sudo apt-get upgrade -y

echo "[2/6] Installo pacchetti base..."
sudo apt-get install -y \
  ca-certificates \
  curl \
  wget \
  gnupg \
  lsb-release \
  openssh-server \
  ufw \
  neovim \
  htop \
  tmux \
  tree \
  jq

echo "[3/6] Abilito e avvio SSH..."
sudo systemctl enable ssh
sudo systemctl start ssh

echo "[4/6] Aggiungo la repo ufficiale Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
if [ ! -f /etc/apt/keyrings/docker.asc ]; then
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
fi
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[5/6] Installo Docker Engine + Compose plugin..."
sudo apt-get update
sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

echo "[6/6] Abilito Docker al boot..."
sudo systemctl enable docker
sudo systemctl enable containerd
sudo systemctl start docker

if id -nG "$USER" | grep -qw docker; then
  echo "Utente già nel gruppo docker."
else
  sudo usermod -aG docker "$USER"
  echo "Aggiunto $USER al gruppo docker. Fai logout/login per usare docker senza sudo."
fi

echo "Fatto."
echo "Verifica con:"
echo "  ssh -V"
echo "  docker --version"
echo "  docker compose version"
echo "  sudo systemctl status ssh"
echo "  sudo systemctl status docker"
