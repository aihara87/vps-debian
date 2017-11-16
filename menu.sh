#!/bin/bash
while :
do
clear
        # Reading out system information...
        # Reading CPU model
        cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
        # Reading amount of CPU cores
        cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
        # Reading CPU frequency in MHz
        freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
        # Reading CPU load
        cpuload=$(top -bn1 | grep load | awk '{printf "%.2f\n", $(NF-2)}')
        # Reading total memory in MB
        tram=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
        # Reading Swap in MB
        vram=$( free -m | awk 'NR==4 {print $2}' )
        # Reading system uptime
        up=$( uptime | awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }' | sed 's/^[ \t]*//;s/[ \t]*$//' )
        # Reading operating system and version (simple, didn't filter the strings at the end...)
        opsy=$( cat /etc/issue.net | awk 'NR==1 {print}' ) # Operating System & Version
        arch=$( uname -m ) # Architecture
        lbit=$( getconf LONG_BIT ) # Architecture in Bit
        hn=$( hostname ) # Hostname
        kern=$( uname -r )
        # Output of results
        echo -e "\e[31;1mSystem Info\e[0m"
        echo "-----------"
        echo -e "\e[32;1mProcessor\e[0m : $cname"
        echo -e "\e[32;1mCPU Cores\e[0m : $cores"
        echo -e "\e[32;1mCPU Load\e[0m  : $cpuload"
        echo -e "\e[32;1mFrequency\e[0m : $freq MHz"
        echo -e "\e[32;1mMemory\e[0m    : $tram"
        echo -e "\e[32;1mSwap\e[0m      : $vram MB"
        echo -e "\e[32;1mUptime\e[0m    : $up"
        echo ""
        echo -e "\e[32;1mOS\e[0m        : $opsy"
        echo -e "\e[32;1mArch\e[0m      : $arch ($lbit Bit)"
        echo -e "\e[32;1mKernel\e[0m    : $kern"
        echo -e "\e[32;1mHostname\e[0m  : $hn"
        echo ""
echo "-------------------------------------------"
echo "              Simple Menu                 |"
echo "      Create By: Yusril Rahardiansah      |"
echo "-------------------------------------------"
echo -e " \e[31;1m[1]\e[0m \e[36;1mCreate New Account\e[0m"
echo -e " \e[31;1m[2]\e[0m \e[36;1mCreate Trial Account\e[0m"
echo -e " \e[31;1m[3]\e[0m \e[36;1mTest Speed Internet\e[0m"
echo -e " \e[31;1m[4]\e[0m \e[36;1mCheck User Login (Dropbear&Openssh)\e[0m"
echo -e " \e[31;1m[5]\e[0m \e[36;1mMonitor User Dropbear\e[0m"
echo -e " \e[31;1m[6]\e[0m \e[36;1mList User Active/Expired\e[0m"
echo -e " \e[31;1m[7]\e[0m \e[36;1mDelete Account\e[0m"
echo -e " \e[31;1m[8]\e[0m \e[36;1mRenew Account\e[0m"
echo -e " \e[31;1m[9]\e[0m \e[36;1mBenchmark VPS\e[0m"
echo -e "\e[31;1m[10]\e[0m \e[36;1mClear Cache RAM\e[0m"
echo -e "\e[31;1m[11]\e[0m \e[36;1mCheck Port Open VPS\e[0m"
echo -e "\e[31;1m[12]\e[0m \e[36;1mAdd Port Dropbear\e[0m"
echo -e "\e[31;1m[13]\e[0m \e[36;1mDelete Port Dropbear\e[0m"
echo -e "                                \e[31;1m[0]\e[0m \e[36;1mExit\e[0m"
echo "============================================"
echo -n "Please input your options [1-13]: "
read pilihan
case $pilihan in
     1) read -p "Username : " Login
        read -p "Password : " Pass
        read -p "Expired (hari): " mumetndase
IP=`dig +short myip.opendns.com @resolver1.opendns.com`
        useradd -e `date -d "$mumetndase days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
        echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
        echo -e ""
        echo -e "Informasi SSH"
        echo -e "============-account-==============="
        echo -e "IP Host  : $IP "
        echo -e "Port     : 443 (Dropbear)"
        echo -e "Port     : 22 (Openssh)"
        echo -e "Username : $Login"
        echo -e "Password : $Pass"
        echo -e "------------------------------------"
        echo -e ""
        echo -e ">>>>Aktif Sampai: $exp<<<< "
        echo -e ""
        echo -e "===================================="
        echo -e "Rule:"
        echo -e "Max Login 2/akun"
        echo -e "Max Device 1/akun"
        echo -e "Dilarang menggunakan untuk torrent"
        echo -e ""
        echo -e "===================================="
        echo -e ""
    read -p "Press enter to continue...." ;
     ;;
         2)Login=trial-`</dev/urandom tr -dc X-Z0-9 | head -c4`
        masaaktif="0"
        Pass=`</dev/urandom tr -dc a-f0-9 | head -c9`
        IP=`dig +short myip.opendns.com @resolver1.opendns.com`
		useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
		exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
		echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
		echo -e "===================================="
		echo -e "Informasi SSH"
        echo -e "============-account-==============="
        echo -e "Host: $IP"
        echo -e "Port: 443,80"
        echo -e "Username: $Login "
        echo -e "Password: $Pass"
        echo -e "===================================="
        echo -e ">>>>Aktif Sampai: $exp<<<< "
        echo -e "===================================="
        echo -e "Rule:"
        echo -e "Max Login 2/akun"
        echo -e "Max Device 1/akun"
        echo -e "Dilarang menggunakan untuk torrent"
        echo -e "===================================="
        echo -e ""
        read -p "Press enter to continue...." ;
     ;;
     3) wget https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py -O - -o /dev/null|python
    read -p "Press enter to continue...." ;
     ;;
     4) data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
        echo "======================================";
        echo "Checking user login Dropbear...";
        echo "======================================";

        for PID in "${data[@]}"
        do
        #echo "check $PID";
        NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep $PID | wc -l`;
        USER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep $PID | awk '{print $10}'`;
        IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep $PID | awk '{print $12}'`;
        if [ $NUM -eq 1 ]; then
        echo "$PID - $USER - $IP";
        fi
        done

        echo "=====================================";
        data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);
        echo "Checking user login Openssh...";
        echo "======================================";
        for PID in "${data[@]}"
        do
        #echo "check $PID";
                NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
                USER=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
                IP=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
        if [ $NUM -eq 1 ]; then
                echo "$PID - $USER - $IP";
        fi
        done
        echo "";
    read -p "Press enter to continue...." ;
     ;;
         5) read -p "Masukan Port dropbear yang aktif : " portdrop
         port_dropbear=$portdrop
        log=/var/log/auth.log
        loginsukses='Password auth succeeded'
        echo ' '
        echo ' '
        echo "               Dropbear Users Login Monitor "
        echo "---------------------------------------------------------------"
        echo "  Date-time    |  PID      |  User Name      |  From Host "
        echo "---------------------------------------------------------------"
        pids=`ps ax |grep dropbear |grep  " $port_dropbear" |awk -F" " '{print $1}'`
        for pid in $pids
        do
    pidlogs=`grep $pid $log |grep "$loginsukses" |awk -F" " '{print $3}'`
    i=0
    for pidend in $pidlogs
    do
      let i=i+1
    done
    if [ $pidend ];then
       login=`grep $pid $log |grep "$pidend" |grep "$loginsukses"`
       PID=$pid
       user=`echo $login |awk -F" " '{print $10}' | sed -r "s/'/ /g"`
       waktu=`echo $login |awk -F" " '{print $2,$3}'`
       while [ ${#waktu} -lt 13 ]
       do
           waktu=$waktu" "
       done

       while [ ${#user} -lt 16 ]
       do
           user=$user" "
       done
       while [ ${#PID} -lt 8 ]
       do
           PID=$PID" "
       done

       fromip=`echo $login |awk -F" " '{print $12}' |awk -F":" '{print $1}'`
       echo "  $waktu|  $PID | $user|  $fromip "
    fi
        done
        echo "---------------------------------------------------------------"
        read -p "Press enter to continue...." ;
    ;;
     6) echo "==============================="
                echo "USERNAME     |    EXP DATE     "
                echo "==============================="
        while read mumetndase
        do
        AKUN="$(echo $mumetndase | cut -d: -f1)"
        ID="$(echo $mumetndase | grep -v nobody | cut -d: -f3)"
        exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
        if [[ $ID -ge 1000 ]]; then
        printf "%-17s %2s\n" "$AKUN" "$exp"
        fi
        done < /etc/passwd
        JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
                echo "=============================="
        echo "Jumlah akun: $JUMLAH user"
        read -p "Press enter to continue...." ;
     ;;
     7) echo "Masukan User yang mau di hapus"
                read -p "Username : " usr
                userdel $usr
     read -p "Press enter to continue...." ;
     ;;
     8) echo "Masukan user yang mau renew"
        read -p "Username : " usr1
        read -p "Expired (hari): " exp1
        chage -E `date -d "$exp1 days" +"%Y-%m-%d"` $usr1
        exp="$(chage -l $usr1 | grep "Account expires" | awk -F": " '{print $2}')"
        echo -e "$Pass\n$Pass\n"|passwd $usr1 &> /dev/null
        echo -e "Aktif Sampai: $exp "
        echo -e "Sukses Renew Account"
     read -p "Press enter to continue...." ;
     ;;
     9) wget https://raw.githubusercontent.com/aihara87/vps-debian/master/bench.sh -O - -o /dev/null|bash;
     read -p "Press enter to continue...." ;
     ;;
         10) sync && echo 3 > /proc/sys/vm/drop_caches
         echo -e "\e[32;1mSuccess clear cache RAM!!\e[0m"
         read -p "Press enter to continue...." ;
     ;;
         11) netstat -lntp
     read -p "Press enter to continue...." ;
     ;;
         12) read -p "Masukan port yang di inginkan :" portdrop
         sed -i 's/DROPBEAR_EXTRA_ARGS="/DROPBEAR_EXTRA_ARGS="-p '$portdrop' /g' /etc/default/dropbear
         service dropbear restart
         read -p "Press enter to continue...." ;
     ;;
         13) read -p "Masukan port yang ingin dihapus :" portdrop
         sed -i 's/DROPBEAR_EXTRA_ARGS="-p '$portdrop'/DROPBEAR_EXTRA_ARGS="/g' /etc/default/dropbear
         service dropbear restart
         read -p "Press enter to continue...." ;
     ;;
     0) exit 0 ;;
     *) echo "Maaf, pilihan yang Anda masukkan tidak terdaftar di Menu Utama";
     read -p "Press enter to continue...." ;
     ;;
esac
done
