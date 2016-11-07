# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|


  config.vm.provision "shell", inline: <<-SHELL
    set -e

    debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
    debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
    apt-get update
    apt-get install -y --allow-unauthenticated apache2 unzip mysql-server-5.5 python2.7-dev

    mkdir -p /opt/master
    cd /opt/master
    wget https://github.com/colincam/Awesome-Appliance-Repair/archive/master.zip
    unzip master.zip

    cd Awesome-Appliance-Repair-master
    mv AAR /var/www/
    chown -R www-data:www-data /var/www/AAR
    rm -f /etc/apache2/sites-enabled/*
  SHELL
end
