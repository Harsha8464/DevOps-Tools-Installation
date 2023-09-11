#Run the following command to uninstall all conflicting packages:
sh for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

#Update the apt package index and install packages to allow apt to use a repository over HTTPS:

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

#Add Docker’s official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

#Use the following command to set up the repository:

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

#To install the latest version, run:

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#Verify that the Docker Engine installation is successful by running the hello-world image.

sudo docker run hello-world

#Add user
usermod -aG docker ubuntu
newgrp docker
chmod 777 /var/run/docker.sock

#Uninstall the Docker Engine, CLI, containerd, and Docker Compose packages:
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

#Images, containers, volumes, or custom configuration files on your host aren’t automatically removed. To delete all images, containers, and volumes:\
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
