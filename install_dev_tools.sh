if [ "$(id -u)" -ne 0 ]; then
    echo "root permissions are required (sudo)."
    exit 1
fi

# Update/Upgrade
apt-get update -y
apt-get upgrade -y
echo "Upgrade done."

#  Install Docker
apt install -y apt-transport-https ca-certificates curl software-properties-common
if ! apt-key list 2>/dev/null | grep -q "Docker Release"; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
fi
if ! grep -Rq "^deb .\+download.docker.com/linux/ubuntu" /etc/apt/sources.list /etc/apt/sources.list.d/; then
    add-apt-repository -y \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt update
fi
apt install -y docker-ce docker-ce-cli containerd.io
echo "Docker installed."
docker --version

# Install Docker-compose
apt-get install -y docker-compose-plugin || apt-get install -y docker-compose
echo "Docker-compose installed."
docker compose version || docker-compose --version

# Install Python3 and pip
apt-get install -y python3 python3-pip
echo "Python3 and pip installed."
python3 --version
python3 -m pip --version

# Install Django
python3 -m pip install django
echo "Django installed."
python3 -m django --version

# Note: apt-get and pip install don't install packages if they are already installed.
