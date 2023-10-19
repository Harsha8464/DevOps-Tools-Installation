#Add helm repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

#Update helm repo
helm repo update

#Install helm
helm install prometheus prometheus-community/prometheus

#Expose Prometheus Service
#This is required to access prometheus-server using your browser.

kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-ext

minikube service <service name> --url



##################################Install Prometheus on Ubuntu 22.04 LTS#########################

sudo useradd --no-create-home --shell /bin/false prometheus

sudo mkdir /etc/prometheus

sudo mkdir /var/lib/prometheus

sudo chown prometheus:prometheus /var/lib/prometheus
cd /tmp/

wget https://github.com/prometheus/prometheus/releases/download/v2.47.2/prometheus-2.47.2.linux-amd64.tar.gz

sudo tar -xvf prometheus-2.47.2.linux-amd64.tar.gz

cd prometheus-2.47.2.linux-amd64

sudo mv console* /etc/prometheus

sudo mv prometheus.yml /etc/prometheus

sudo chown -R prometheus:prometheus /etc/prometheus

sudo mv prometheus /usr/local/bin/

sudo chown prometheus:prometheus /usr/local/bin/prometheus

sudo nano /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target




sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
sudo systemctl status prometheus

<server-ip>:9090

###################################Install Node Exporter on Ubuntu 22.04 LTS#########################

wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz

sudo tar xvfz node_exporter-*.*-amd64.tar.gz
sudo mv node_exporter-*.*-amd64/node_exporter /usr/local/bin/
sudo useradd -rs /bin/false node_exporter
sudo nano /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
[Install]
WantedBy=multi-user.target


sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
sudo systemctl status node_exporter

sudo nano /etc/prometheus/prometheus.yml
- job_name: 'Node_Exporter'

    scrape_interval: 5s

    static_configs:

      - targets: ['<Server_IP_of_Node_Exporter_Machine>:9100']

 sudo systemctl restart prometheus.service     
