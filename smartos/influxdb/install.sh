hostname influxdb
echo "influxdb" > /etc/hostname

curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list

sudo apt-get update && sudo apt-get install -y influxdb
#sudo service influxdb start
sudo systemctl start influxdb


### Grafana
# modified from http://docs.grafana.org/installation/debian/
# NB wheezy is correct repo even for xenial (ubuntu 16)
echo "deb https://packagecloud.io/grafana/stable/debian/ wheezy main" | sudo tee /etc/apt/sources.list.d/grafana.list
curl https://packagecloud.io/gpg.key | sudo apt-key add -
sudo apt-get update && sudo apt-get install -y grafana

# turns out getcap / setcap not supported in LX brand zones
# Run grafana on port 80
#setcap 'cap_net_bind_service=+ep' /usr/sbin/grafana-server
#sed -i "s/;http_port = 3000/http_port = 80/" /etc/grafana/grafana.ini

# Enable anonymous access
#sed -i '/# enable anonymous access/ !b;n;s/^;enabled = true/enabled = true/' /etc/grafana/grafana.ini

systemctl daemon-reload
systemctl start grafana-server
#systemctl status grafana-server	# meant for interactive
systemctl enable grafana-server.service

# Redirect port 80 to port 3000
#sudo apt-get install -y iptables
#sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000
