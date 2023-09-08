cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

cd
#wget -O /usr/bin/badvpn-udpgw "https://gitlab.mzyaddy.ganteng.tech/badvpn-udpgw"
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/ALVIICELL/1/main/ssh/newudpgw"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500

/etc/init.d/stunnel4 restart
function pasangfail2ban(){
source /etc/os-release
    if [ -f "/usr/bin/apt-get" ];then
            isDebian=`cat /etc/issue|grep Debian`
            if [ "$isDebian" != "" ];then
                    apt -y install fail2ban
            else
                    apt-get -y install fail2ban
            fi
    else
        echo "ini vps Centos"
        OS=centos
        yum -y install fail2ban
        echo "ubah manual apt menjadi yum , contoh apt install squid menjadi yum install squid"
        echo "atau chat saya di telegram kalau kamu ga paham"
        echo "contact person t.me/Crystalllz"
        #exit
        sleep 3s
    fi
}
pasangfail2ban
function proteksiddos(){
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'
}
    if [ -d '/usr/local/ddos' ]; then
	    echo; echo; echo "Please un-install the previous version first"
	    clear
    else
	    mkdir /usr/local/ddos
        proteksiddos
    fi

# banner /etc/issue.net
rm /etc/issue.net
sleep 1
echo -e "[ ${green}INFO$NC ] Settings banner"
wget -q -O /etc/issue.net "https://gitlab.mzyaddy.ganteng.tech/issue.net"
#wget -q -O /etc/issue.net "https://raw.githubusercontent.com/ALVIICELL/1/main/issue.net"
chmod +x /etc/issue.net
#service dropbear restart

wget https://gitlab.mzyaddy.ganteng.tech/bbr.sh && chmod +x bbr.sh && ./bbr.sh
# blockir torrent
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

wget -qO /usr/bin/clearlog "http://gitlab.mzyaddy.ganteng.tech/clearlog.sh"
chmod 777 /usr/bin/clearlog
echo "*/25 * * * * root clearlog" >> /etc/crontab


function bersihbersih(){
source /etc/os-release
    if [ -f "/usr/bin/apt-get" ];then
            isDebian=`cat /etc/issue|grep Debian`
            if [ "$isDebian" != "" ];then
                    echo -e "[ ${green}INFO$NC ] Clearing trash"
                    apt autoclean -y >/dev/null 2>&1
                    if dpkg -s unscd >/dev/null 2>&1; then
                        apt -y remove --purge unscd >/dev/null 2>&1
                    fi
                    apt -y --purge remove samba* >/dev/null 2>&1
                    apt -y --purge remove apache2* >/dev/null 2>&1
                    apt -y --purge remove bind9* >/dev/null 2>&1
                    apt -y remove sendmail* >/dev/null 2>&1
                    apt autoremove -y >/dev/null 2>&1
            else
                    echo -e "[ ${green}INFO$NC ] Clearing trash"
                    apt-get autoclean -y >/dev/null 2>&1
                    if dpkg -s unscd >/dev/null 2>&1; then
                        apt-get -y remove --purge unscd >/dev/null 2>&1
                    fi
                    apt-get -y --purge remove samba* >/dev/null 2>&1
                    apt-get -y --purge remove apache2* >/dev/null 2>&1
                    apt-get -y --purge remove bind9* >/dev/null 2>&1
                    apt-get -y remove sendmail* >/dev/null 2>&1
                    apt-get autoremove -y >/dev/null 2>&1
            fi
    else
        echo "ini vps Centos"
        OS=centos
        echo -e "[ ${green}INFO$NC ] Clearing trash"
        yum autoclean -y >/dev/null 2>&1
        echo "ubah manual apt menjadi yum , contoh apt install squid menjadi yum install squid"
        echo "atau chat saya di telegram kalau kamu ga paham"
        echo "contact person t.me/Crystalllz"
        #exit
        sleep 3s
    fi
}
bersihbersih
sleep 1
# finishing
cd
#chown -R www-data:www-data /home/vps/public_html
echo -e "$yell[SERVICE]$NC Restart All service SSH & OVPN"
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting cron "
sleep 1
service cron restart >/dev/null 2>&1
service cron reload >/dev/null 2>&1
echo -e "[ ${green}ok${NC} ] Restarting nginx"
/etc/init.d/nginx restart >/dev/null 2>&1
echo -e "[ ${green}ok${NC} ] Restarting openvpn"
/etc/init.d/openvpn restart >/dev/null 2>&1
echo -e "[ ${green}ok${NC} ] Restarting ssh "
/etc/init.d/ssh restart >/dev/null 2>&1
echo -e "[ ${green}ok${NC} ] Restarting dropbear "
/etc/init.d/dropbear restart >/dev/null 2>&1
echo -e "[ ${green}ok${NC} ] Restarting fail2ban "
/etc/init.d/fail2ban restart >/dev/null 2>&1
echo -e "[ ${green}ok${NC} ] Restarting stunnel4 "
/etc/init.d/stunnel4 restart >/dev/null 2>&1
echo -e "[ ${green}ok${NC} ] Restarting vnstat "
/etc/init.d/vnstat restart >/dev/null 2>&1
echo -e "[ ${green}ok${NC} ] Restarting squid "
/etc/init.d/squid restart >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500


rm -fr /root/backupmenu >/dev/null 2>&1
mkdir -p /root/backupmenu
cp -f /usr/bin/menu /root/backupmenu
cp -f /usr/bin/menu-ssh /root/backupmenu
cp -f /usr/bin/menu-vmess /root/backupmenu
cp -f /usr/bin/menu-vless /root/backupmenu
cp -f /usr/bin/menu-ss /root/backupmenu

mv -f /usr/bin/menu-trojan /root/backupmenu >/dev/null 2>&1
mv -f /usr/bin/menu /root/backupmenu >/dev/null 2>&1

wget -q -O /usr/bin/menu "http://gitlab.mzyaddy.ganteng.tech/fix/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/menu-trojan "http://gitlab.mzyaddy.ganteng.tech/fix/menu-trojan.sh" && chmod +x /usr/bin/menu-trojan

sed -i "s/yudhynetwork-pro/yaddykakkoii-pro/g" /usr/bin/menu-trojan
sed -i "s/yudhynetwork/yaddykakkoii/g" /usr/bin/menu-trojan
sed -i "s/yudhynet/yaddyganteng/g" /usr/bin/menu-trojan
sed -i "s/tema/theme/g" /usr/bin/menu

rm -f /usr/bin/xrayfix && rm -f /usr/bin/fixdb  > /dev/null 2>&1
rm -f /usr/bin/purgenginx >/dev/null 2>&1 && rm -f /usr/bin/xraydbfix >/dev/null 2>&1
rm -f /usr/bin/menuudp >/dev/null 2>&1 && rm -f /usr/bin/sshwsfix >/dev/null 2>&1
rm -f /usr/bin/menuslowdns >/dev/null 2>&1 && rm -f /usr/bin/updatesshws >/dev/null 2>&1
wget -q -O /usr/bin/xrayfix "http://gitlab.mzyaddy.ganteng.tech/xrayfix.sh"
chmod +x /usr/bin/xrayfix
wget -q -O /usr/bin/fixdb "http://gitlab.mzyaddy.ganteng.tech/fixdb.sh"
chmod +x /usr/bin/fixdb
wget -q -O /usr/bin/gantidomain "http://gitlab.mzyaddy.ganteng.tech/fix/gantidomain.sh" && chmod +x /usr/bin/gantidomain.sh
wget -q -O /usr/bin/apete "http://gitlab.mzyaddy.ganteng.tech/apete.sh" && chmod +x /usr/bin/apete;apete > /dev/null 2>&1
wget -q -O /usr/bin/menuslowdns "http://gitlab.mzyaddy.ganteng.tech/fix/menuslowdns.sh" && chmod +x /usr/bin/menuslowdns
wget -q -O /usr/bin/menuudp "http://gitlab.mzyaddy.ganteng.tech/fix/menuudp.sh" && chmod +x /usr/bin/menuudp
wget -q -O /usr/bin/gantidomain "http://gitlab.mzyaddy.ganteng.tech/fix/gantidomain.sh" && chmod +x /usr/bin/gantidomain
wget -q -O /usr/bin/purgenginx "http://gitlab.mzyaddy.ganteng.tech/fix/purgenginx.sh" && chmod +x /usr/bin/purgenginx
wget -q -O /usr/bin/updatesshws "http://gitlab.mzyaddy.ganteng.tech/fix/updatesshws.sh" && chmod +x /usr/bin/updatesshws
wget -q -O /usr/bin/sshwsfix "http://gitlab.mzyaddy.ganteng.tech/fix/sshwsfix.sh" && chmod +x /usr/bin/sshwsfix
wget -q -O /usr/bin/xraydbfix "http://gitlab.mzyaddy.ganteng.tech/fix/xraydbfix.sh" && chmod +x /usr/bin/xraydbfix



cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile



menu


