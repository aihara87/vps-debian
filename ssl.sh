#!/bin/bash
echo "Install Stunnel"
sleep 3
apt-get install stunnel4 -y
wget https://raw.githubusercontent.com/aihara87/vps-debian/master/stunnel.conf -O /etc/stunnel/stunnel.conf
echo
echo "Create SSL Certificates"
sleep 5
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
echo
echo "Restart Stunnel"
/etc/init.d/stunnel4 restart
