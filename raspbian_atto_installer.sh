#!/bin/bash

# Update the system
echo "Updating system..."
sudo apt update -y
sudo apt upgrade -y

# Install required dependencies for Docker and Git
echo "Installing dependencies..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common git

# Install Docker on Raspberry Pi (Docker's official script is recommended for ARM architecture)
echo "Installing Docker..."
curl -fsSL https://get.docker.com | sh

# Add the current user to the Docker group (so you don't need to use sudo for Docker commands)
echo "Adding the user to the Docker group..."
sudo usermod -aG docker $(whoami)

# Start Docker service and enable it on boot
echo "Starting Docker and enabling it on boot..."
sudo systemctl start docker
sudo systemctl enable docker

# Install Docker Compose (to run multi-container Docker applications)
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Clone the Atto examples repository (skip if already exists)
if [ ! -d "examples" ]; then
    echo "Cloning the Atto examples repository..."
    git clone https://github.com/attocash/examples.git
else
    echo "Repository already cloned. Skipping."
fi

# Navigate to the examples directory
cd examples || { echo "Failed to enter examples directory. Exiting."; exit 1; }

# Ask user for external IP
read -rp "Enter the external IP to use: " EXTERNAL_IP

# Update the ATTO_PUBLIC_URI in docker-compose.yml
echo "Updating docker-compose.yml with the provided IP..."
sed -i "s|ATTO_PUBLIC_URI:.*|ATTO_PUBLIC_URI: \"ws://$EXTERNAL_IP:8082\"|" docker-compose.yml

# Ask whether to run the node in detached mode or not
read -rp "Do you want to run the node in detached mode? (yes/no): " DETACHED_MODE

# Run Docker Compose V2 based on user's choice
if [[ "$DETACHED_MODE" == "yes" ]]; then
    echo "Starting the node in detached mode..."
    sudo docker-compose -f docker-compose.yml --project-name atto up -d
else
    echo "Starting the node in attached mode..."
    sudo docker-compose -f docker-compose.yml --project-name atto up
fi

echo "Setup complete. The Atto node is now running."
