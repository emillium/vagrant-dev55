# Trust newRelic repo and add it to source.list
wget -qO - https://download.newrelic.com/548C16BF.gpg | sudo apt-key add -
echo "deb http://apt.newrelic.com/debian/ newrelic non-free" | sudo tee -a /etc/apt/sources.list.d/newrelic.list
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install newrelic-php5
