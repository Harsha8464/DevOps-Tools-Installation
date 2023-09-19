sudo apt install openjdk-8-jdk -y

# Add user&password for nexus 
sudo useradd -d /opt/nexus -s /bin/bash nexus
sudo passwd nexus

#Download the nexus tar file from google
sudo wget https://download.sonatype.com/nexus/3/nexus-3.41.1-01-unix.tar.gz
sudo tar xzf nexus-3.41.1-01-unix.tar.gz

# Next, move those extracted directories to '/opt' using the following command.
#The Nexus package directory will be '/opt/nexus' and the Nexus working directory will be '/opt/sonatype-work'.

sudo mv nexus-3.41.1-01 /opt/nexus
sudo mv sonatype-work /opt/

sudo chown -R nexus:nexus /opt/nexus /opt/sonatype-work
sudo nano /opt/nexus/bin/nexus.rc
run_as_user='nexus'  #inside
sudo vi /opt/nexus/bin/nexus.vmoptions

-Xms1024m
-Xmx1024m
-XX:MaxDirectMemorySize=1024m

-XX:LogFile=./sonatype-work/nexus3/log/jvm.log
-XX:-OmitStackTraceInFastThrow
-Djava.net.preferIPv4Stack=true
-Dkaraf.home=.
-Dkaraf.base=.
-Dkaraf.etc=etc/karaf
-Djava.util.logging.config.file=/etc/karaf/java.util.logging.properties
-Dkaraf.data=./sonatype-work/nexus3
-Dkaraf.log=./sonatype-work/nexus3/log
-Djava.io.tmpdir=./sonatype-work/nexus3/tmp

sudo nano /etc/systemd/system/nexus.service

[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl start nexus.service
sudo systemctl enable nexus.service
sudo systemctl status nexus.service

#if the nexus service is not started, you can the nexus logs using below command
tail -f /opt/sonatype-work/nexus3/log/nexus.log


sudo cat /opt/nexus/sonatype-work/nexus3/admin.password

