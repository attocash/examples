Steps to Run the Atto Node in Docker:
Install Docker:

Go to the official Docker website and follow the installation instructions for your operating system: https://www.docker.com/
Clone the Atto repository:

Run the following command to clone the Atto repository:
git clone https://github.com/attocash/docker-atto
Update docker-compose.yml:

Open the docker-compose.yml file in a text editor.
Replace {external-ip} with your machine's external IP address. For example:
ATTO_PUBLIC_URI: "ws://123.1.2.3:8082"
Start the service in the background:

To run the Atto node in the background (detached mode), use the following command:
docker compose -f docker-compose.yml --project-name atto up -d
Or run without detached mode (foreground):

If you prefer to run the node in the foreground (attached mode), use this command:
docker-compose -f docker-compose.yml --project-name atto up
Check the health of the node:

You can check the health status of your node with this command:
docker-compose exec node curl -f http://localhost:8081/health
Alternatively, Use the atto_installer.sh Script:
Make the script executable:

Run the following command to make the installer script executable:
chmod +x atto_installer.sh
Run the installer script:

Execute the script to automate the setup:
./atto_installer.sh
Provide your external IP:

The script will ask for your local machine’s IP. You can find your IP by visiting WhatIsMyIP.
Choose detached mode:

At the end of the script, it will ask if you want to run the node in detached mode (background) or not. Choose accordingly.
