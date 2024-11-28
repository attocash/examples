#!/bin/bash

# Enable Universe repository and update system
echo "Enabling Universe repository and updating system..."
sudo apt update

# Install Docker and Git (no need for Python tools)
echo "Installing Docker and Git..."
sudo apt install -y docker.io git

# Start Docker service and enable it on boot
echo "Starting Docker and enabling it on boot..."
sudo systemctl start docker
sudo systemctl enable docker

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
