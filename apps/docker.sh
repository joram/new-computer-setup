
function install_docker() {
  sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"

  sudo apt-get update
  sudo apt-get -y  install docker-ce docker-compose
  sudo usermod -aG docker $USER

  # docker compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

while true; do
  read -p "Do you wish to install docker? (y/N)" yn
  case $yn in
    [Yy]* ) install_docker; break;;
    [Nn]* ) break;;
    * ) break;;
  esac
done

