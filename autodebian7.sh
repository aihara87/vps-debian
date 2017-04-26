#!/bin/sh

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0'`;
MYIP2="s/xxxxxxxxx/$MYIP/g";

# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install htop
apt-get install htop -y

# add repository webmin
echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc -y

# install wget and curl
apt-get update;apt-get -y install wget curl;

# install webmin
apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python -y
apt-get install apt-transport-https -y
apt-get install webmin -y

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;

# update
apt-get update; apt-get -y upgrade;

# disable exim
service exim4 stop
sysv-rc-conf exim4 off

# update apt-file
apt-file update

# install vnstat
apt-get install vnstat -y

# setting vnstat
vnstat -u -i venet0
service vnstat restart

# install screenfetch
cd
wget 'https://raw.githubusercontent.com/aihara87/vps-debian/master/screeftech-dev'
mv screeftech-dev /usr/bin/screenfetch
chmod +x /usr/bin/screenfetch
echo "clear" >> .profile
echo "screenfetch" >> .profile

# install badvpn
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/aihara87/vps-debian/master/badvpn-udpgw"
if [ "$OS" == "x86_64" ]; then
  wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/aihara87/vps-debian/master/badvpn-udpgw64"
fi
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109 -p 110 -p 80"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart

# install fail2ban
apt-get -y install fail2ban;service fail2ban restart

# install squid3
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/aihara87/vps-debian/master/squid3.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart

# download script
cd
wget -O speedtest_cli.py "https://raw.githubusercontent.com/aihara87/vps-debian/master/speedtest_cli.py"
wget -O bench-network.sh "https://raw.githubusercontent.com/aihara87/vps-debian/master/bench-network.sh"
wget -O ps_mem.py "https://raw.githubusercontent.com/aihara87/vps-debian/master/ps_mem.py"
wget -O limit.sh "https://raw.githubusercontent.com/aihara87/vps-debian/master/limit.sh"
wget -O dropmon "https://raw.githubusercontent.com/aihara87/vps-debian/master/dropmon"
wget -O userlogin.sh "https://raw.githubusercontent.com/aihara87/vps-debian/master/userlogin.sh"
wget -O userexpired.sh "https://raw.githubusercontent.com/aihara87/vps-debian/master/userexpired.sh"
wget -O userlimit.sh "https://raw.githubusercontent.com/aihara87/vps-debian/master/userlimit.sh"
wget -O tendang "https://raw.githubusercontent.com/aihara87/vps-debian/master/tendang"
echo "0 0 * * * root /root/userexpired.sh" > /etc/cron.d/userexpired
echo "0 0 * * * root sleep 5 /root/userexpired.sh" > /etc/cron.d/userexpired
echo "0 0 * * * root sleep 10 /root/userexpired.sh" > /etc/cron.d/userexpired
echo "0 0 * * * root sleep 15 /root/userexpired.sh" > /etc/cron.d/userexpired
echo "0 0 * * * root sleep 20 /root/userexpired.sh" > /etc/cron.d/userexpired
echo "0 0 * * * root sleep 25 /root/userexpired.sh" > /etc/cron.d/userexpired
echo "0 0 * * * root sleep 30 /root/userexpired.sh" > /etc/cron.d/userexpired
echo "0 0 * * * root sleep 35 /root/userexpired.sh" > /etc/cron.d/userexpired
echo "0 0 * * * root sleep 40 /root/userexpired.sh" > /etc/cron.d/userexpired
echo "0 0 * * * root sleep 45 /root/userexpired.sh" > /etc/cron.d/userexpired
echo "0 0 * * * root sleep 50 /root/userexpired.sh" > /etc/cron.d/userexpired
echo "0 0 * * * root sleep 55 /root/userexpired.sh" > /etc/cron.d/userexpired
echo "0 0 * * * root /root/userlimit.sh" > /etc/cron.d/userlimit
echo "0 0 * * * root sleep 5 /root/userlimit.sh" > /etc/cron.d/userlimit
echo "0 0 * * * root sleep 10 /root/userlimit.sh" > /etc/cron.d/userlimit
echo "0 0 * * * root sleep 15 /root/userlimit.sh" > /etc/cron.d/userlimit
echo "0 0 * * * root sleep 20 /root/userlimit.sh" > /etc/cron.d/userlimit
echo "0 0 * * * root sleep 25 /root/userlimit.sh" > /etc/cron.d/userlimit
echo "0 0 * * * root sleep 30 /root/userlimit.sh" > /etc/cron.d/userlimit
echo "0 0 * * * root sleep 35 /root/userlimit.sh" > /etc/cron.d/userlimit
echo "0 0 * * * root sleep 40 /root/userlimit.sh" > /etc/cron.d/userlimit
echo "0 0 * * * root sleep 45 /root/userlimit.sh" > /etc/cron.d/userlimit
echo "0 0 * * * root sleep 50 /root/userlimit.sh" > /etc/cron.d/userlimit
echo "0 0 * * * root sleep 55 /root/userlimit.sh" > /etc/cron.d/userlimit
sed -i '$ i\screen -AmdS limit /root/limit.sh' /etc/rc.local
chmod +x bench-network.sh
chmod +x speedtest_cli.py
chmod +x ps_mem.py
chmod +x userlogin.sh
chmod +x userexpired.sh
chmod +x userlimit.sh
chmod +x limit.sh
chmod +x dropmon
chmod +x tendang

# finishing
service vnstat restart
service ssh restart
service dropbear restart
service fail2ban restart
service squid3 restart
rm -rf ~/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile

# info
clear
echo ""  | tee -a log-install.txt
echo "AUTOSCRIPT INCLUDES" | tee log-install.txt
echo "===============================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Service"  | tee -a log-install.txt
echo "-------"  | tee -a log-install.txt
echo "OpenVPN  : TCP 1194 (client config : http://$MYIP:81/client.tar)"  | tee -a log-install.txt
echo "OpenSSH  : 22, 80, 143"  | tee -a log-install.txt
echo "Dropbear : 109, 110, 443"  | tee -a log-install.txt
echo "Squid3   : 8080 (limit to IP SSH)"  | tee -a log-install.txt
echo "badvpn   : badvpn-udpgw port 7300"  | tee -a log-install.txt
echo "nginx    : 81"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Tools"  | tee -a log-install.txt
echo "-----"  | tee -a log-install.txt
echo "axel"  | tee -a log-install.txt
echo "bmon"  | tee -a log-install.txt
echo "htop"  | tee -a log-install.txt
echo "iftop"  | tee -a log-install.txt
echo "mtr"  | tee -a log-install.txt
echo "nethogs"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Script"  | tee -a log-install.txt
echo "------"  | tee -a log-install.txt
echo "screenfetch"  | tee -a log-install.txt
echo "./ps_mem.py"  | tee -a log-install.txt
echo "./speedtest_cli.py --share"  | tee -a log-install.txt
echo "./bench-network.sh"  | tee -a log-install.txt
echo "./user-login.sh" | tee -a log-install.txt
echo "./user-expire.sh" | tee -a log-install.txt
echo "./user-limit.sh 2" | tee -a log-install.txt
echo "sh dropmon [port] contoh: ./dropmon.sh 443" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Fitur lain"  | tee -a log-install.txt
echo "----------"  | tee -a log-install.txt
echo "Webmin   : https://$MYIP:10000/"  | tee -a log-install.txt
echo "vnstat   : http://$MYIP:81/vnstat/"  | tee -a log-install.txt
echo "MRTG     : http://$MYIP:81/mrtg/"  | tee -a log-install.txt
echo "Timezone : Asia/Jakarta"  | tee -a log-install.txt
echo "Fail2Ban : [on]"  | tee -a log-install.txt
echo "IPv6     : [off]"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Log Installasi --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "SILAHKAN REBOOT VPS ANDA"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "==============================================="  | tee -a log-install.txt
