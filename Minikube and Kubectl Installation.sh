#################Dependecies install Docker####################



$ sudo apt update -y
$ sudo apt upgrade -y

$ sudo reboot

#Install the following minikube dependencies by running beneath command,
$ sudo apt install -y curl wget apt-transport-https

#Use the following curl command to download latest minikube binary
$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

#Once the binary is downloaded, copy it to the path /usr/local/bin and set the executable permissions on it
$ sudo install minikube-linux-amd64 /usr/local/bin/minikube

#Verify the minikube version
minikube version

#Kubectl is a command line utility which is used to interact with Kubernetes cluster. It is used for managing deployments, service and pods etc. Use below curl command to download latest version of kubectl.
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

#Once kubectl is downloaded then set the executable permissions on kubectl binary and move it to the path /usr/local/bin.
$ chmod +x kubectl
$ sudo mv kubectl /usr/local/bin/


#Now verify the kubectl version
$ kubectl version -o yaml


#As we are already stated in the beginning that we would be using docker as base for minikue, so start the minikube with the docker driver, run

$ minikube start --driver=docker

#In case you want to start minikube with customize resources and want installer to automatically select the driver then you can run following command,
$ minikube start --addons=ingress --cpus=2 --cni=flannel --install-addons=true --kubernetes-version=stable --memory=6g

echo Run below minikube command to check status,
 minikube status

#Run following kubectl command to verify the Kubernetes version, node status and cluster info.
$ kubectl cluster-info
$ kubectl get nodes

