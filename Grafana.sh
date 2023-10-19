#Install using Helm

#Add helm repo
helm repo add grafana https://grafana.github.io/helm-charts

#Update helm repo
helm repo update

#Install helm
helm install grafana grafana/grafana

#Expose Grafana Service
kubectl expose service grafana — type=NodePort — target-port=3000 — name=grafana-ext

minikube service <service name> --url



#########################Install Grafana on Ubuntu 22.04 LTS##############################

wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt update
sudo apt install grafana
sudo systemctl start grafana-server
sudo systemctl status grafana-server
sudo systemctl enable grafana-server
<instance_ip>:3000


