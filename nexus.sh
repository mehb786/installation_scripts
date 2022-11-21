
sudo apt-get update
sudo apt install openjdk-8-jre-headless -y
cd /opt
sudo wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz   ## latest version of nexus
tar -zxvf latest-unix.tar.gz
sudo mv /opt/nexus-3.30.1-01 /opt/nexus   
sudo adduser nexus
sudo passwd nexus ##update the password for nexus
sudo visudo
nexus ALL=(ALL) NOPASSWD: ALL
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo vi /opt/nexus/bin/nexus.rc
    run_as_user="nexus"
sudo vi /opt/nexus/bin/nexus.vmoptions
   ## change the below  ../sonatype-work to ./sonatype-work
sudo vi  /etc/systemd/system/nexus.service   
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

sudo systemctl start nexus
sudo systemctl enable nexus
sudo systemctl status nexus
