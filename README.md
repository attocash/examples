Atto Node Setup Guide
Steps to Run the Atto Node in Docker
1. Install Docker
Ubuntu:
Open a terminal and update the package list:

sudo apt update
sudo apt upgrade -y
Install Docker:

sudo apt install -y docker.io
Enable and start the Docker service:

sudo systemctl enable docker
sudo systemctl start docker
Optionally, add your user to the Docker group to avoid using sudo with Docker commands:

sudo usermod -aG docker $(whoami)
newgrp docker
Fedora:
Open a terminal and update the package list:

sudo dnf update -y
Install Docker and the required dependencies:

sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo=https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io
Enable and start the Docker service:

sudo systemctl enable docker
sudo systemctl start docker
Optionally, add your user to the Docker group to avoid using sudo with Docker commands:

sudo usermod -aG docker $(whoami)
newgrp docker
Raspbian (Raspberry Pi OS):
Update your system:

sudo apt update -y
sudo apt upgrade -y
Install dependencies for Docker:

sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
Install Docker using the official script for ARM:

curl -fsSL https://get.docker.com | sh
Add your user to the Docker group to avoid using sudo with Docker commands:

sudo usermod -aG docker $(whoami)
newgrp docker
Enable and start the Docker service:

sudo systemctl enable docker
sudo systemctl start docker
2. Clone the Atto Repository
Run the following command to clone the Atto repository:

git clone https://github.com/attocash/docker-atto.git
3. Update docker-compose.yml
Open the docker-compose.yml file in a text editor (e.g., nano, vim, or a graphical editor).

nano docker-compose.yml
Replace {external-ip} with your machine's external IP address. For example:

ATTO_PUBLIC_URI: "ws://123.1.2.3:8082"
To find your external IP, you can visit a website like WhatIsMyIP.
4. Start the Service in the Background (Detached Mode)
To run the Atto node in the background (detached mode), use the following command:

docker compose -f docker-compose.yml --project-name atto up -d
5. Or Run Without Detached Mode (Foreground)
If you prefer to run the node in the foreground (attached mode), use this command:

docker-compose -f docker-compose.yml --project-name atto up
6. Check the Health of the Node
You can check the health status of your node with this command:

docker-compose exec node curl -f http://localhost:8081/health
Alternatively, Use the atto_installer.sh Script
1. Make the Script Executable
To make the installer script executable, run the following command:

chmod +x atto_installer.sh
2. Run the Installer Script
Execute the script to automate the setup:

./atto_installer.sh
3. Provide Your External IP
The script will prompt you to enter your local machine’s external IP address. You can find your IP by visiting a website like WhatIsMyIP.

4. Choose Detached Mode
At the end of the script, it will ask if you want to run the node in detached mode (background) or not. Choose accordingly.

Installation via atto_installer.sh Script for Different Operating Systems
For Ubuntu:
Install Docker using the instructions above.
Run the atto_installer.sh script:
./atto_installer.sh
For Fedora:
Install Docker using the instructions above.
Run the atto_installer.sh script:
./atto_installer.sh
For Raspbian (Raspberry Pi OS):
Install Docker using the instructions above.
Run the atto_installer.sh script:
./atto_installer.sh

