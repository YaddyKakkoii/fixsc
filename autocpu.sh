#!/bin/bash
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
yellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
grenbo="\e[92;1m"
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
export KEY="6654578153:AAEL08DFbdrgtirDqtBU6DkP_acq31uZPik"
export CHATID="1117211252"
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
#CHATID="$CHATID"    #KEY="$KEY"    #TIME="$TIME"    #URL="$URL"
function restartallservis(){
netfilter-persistent restart
systemctl restart ws
systemctl restart haproxy
systemctl restart xray
systemctl restart openvpn
/etc/init.d/ssh restart
systemctl restart ssh
/etc/init.d/dropbear restart
/etc/init.d/openvpn restart
/etc/init.d/fail2ban restart
/etc/init.d/nginx restart
systemctl disable udp-mini-1
systemctl stop udp-mini-1
systemctl enable udp-mini-1
systemctl start udp-mini-1
systemctl disable udp-mini-2
systemctl stop udp-mini-2
systemctl enable udp-mini-2
systemctl start udp-mini-2
systemctl disable udp-mini-3
systemctl stop udp-mini-3
systemctl enable udp-mini-3
systemctl start udp-mini-3

}

function bannerhaproxy() {
bang="\033[1;93m"
purple="\033[1;95m"
NC='\033[0m'
echo -e  "${bang}╭════════════════════════════════════════╮${NC}"
echo -e "${bang}│  $NC   ${purple}    FIXED HAPROXY OFFLINE   $NC    ${bang}   │${NC}"
echo -e  "${bang}╰════════════════════════════════════════╯${NC}"
echo -e ""
echo -e "  \033[1;91m service fixed haproxy\033[1;37m"

}

function notif_ssl() {
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
green "Notif AddHost Tele"
sleep 2
CHATID="1117211252"
KEY="6654578153:AAEL08DFbdrgtirDqtBU6DkP_acq31uZPik"
TIME="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
domain=$(cat /etc/xray/domain)
TEXT="
<code>====================</code>
<code>Notif Pasang SSL & Fix Xray off  </code>
<b>DOMAIN</b> <code>$domain</code>
<b>STATUS X ERROR</b> <code>$(systemctl status xray | grep "error" | wc -l)</code>
<b>STATUS X RUNNING</b> <code>$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)</code>
<b>STATUS H RUNNING</b> <code>$(systemctl status haproxy | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)</code>
<code>====================</code>
<code>FIXED XRAY OFFLINE DONE</code>
<code>FIXED HAPROXY OFFLINE DONE</code>
<code>PERBARUI SERTIFIKAT SSL DONE</code>
<code>====================</code>
"

curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

}

function pasang_ssl() {
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
green "Renew Cert SSL"
sleep 2
rm -rf /etc/xray/xray.key
rm -rf /etc/xray/xray.crt
domain=$(cat /etc/xray/domain)
STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
rm -rf /root/.acme.sh
mkdir /root/.acme.sh
systemctl stop ${STOPWEBSERVER}
systemctl stop nginx
systemctl stop haproxy
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
chmod 777 /etc/xray/xray.key
bannerhaproxy
rm -fr /etc/haproxy/hap.pem
cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem
systemctl restart nginx
systemctl restart xray
echo -e "  \033[1;91m service restart daemon-reload\033[1;37m"
systemctl daemon-reload
echo -e "  \033[1;91m service restart haproxy\033[1;37m"    
systemctl restart haproxy

}

function fixhaproxydanxray(){
echo -e""
pasang_ssl
notif_ssl
echo ""
sleep 6

}

cd /etc
nmap -p 22 $(curl -sS ipv4.icanhazip.com) > cekip
cpu=$(grep -c -E "open" "cekip")
    if [[ ${cpu} == '0' ]]; then
        apt install nmap -y
        shutdown -r now
    fi
cd /root

function bannerxrayfix() {
bang="\033[1;93m"
purple="\033[1;95m"
NC='\033[0m'
echo -e  "${bang}╭════════════════════════════════════════╮${NC}"
echo -e "${bang}│  $NC   ${purple}    FIXED XRAY OFFLINE   $NC       ${bang}   │${NC}"
echo -e  "${bang}╰════════════════════════════════════════╯${NC}"
echo -e ""
echo -e "  \033[1;91m service fixed xray\033[1;37m"

}

function kirimstatusketelegram() {
TEXT="
<code>====================</code>
<code>Notif auto FIX XRAY offline</code>
<b>DOMAIN</b> <code>$(cat /etc/xray/domain)</code>
<b>STATUS ERROR</b> <code>$(systemctl status xray | grep "error" | wc -l)</code>
<b>STATUS RUNNING</b> <code>$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)</code>
<code>====================</code>
<code>FIXED XRAY OFFLINE DONE</code>
<code>====================</code>
"

curl -s --max-time 10 -d "chat_id=1117211252&disable_web_page_preview=1&text=$TEXT&parse_mode=html" https://api.telegram.org/bot6654578153:AAEL08DFbdrgtirDqtBU6DkP_acq31uZPik/sendMessage >/dev/null

}

function xrayfixawal(){
netfilter-persistent restart
bannerxrayfix
rm -f /etc/systemd/system/runn.service > /dev/null 2>&1
#wget -O /etc/systemd/system/runn.service "myrid.digital/xray/runn.service" >/dev/null 2>&1
#wget -O /etc/systemd/system/runn.service "https://wokszxdstore.net/xray/runn.service" >/dev/null 2>&1
cat > /etc/systemd/system/runn.service <<-END
[Unit]
Description=Automatically
After=network.target

[Service]
Type=simple
ExecStartPre=-/usr/bin/mkdir -p /var/run/xray
ExecStart=/usr/bin/chown www-data:www-data /var/run/xray
Restart=on-abort

[Install]
WantedBy=multi-user.target
END

chmod +x /etc/systemd/system/runn.service

echo -e "  \033[1;91m service restart xray\033[1;37m"
systemctl restart xray
systemctl start xray

sleep 6
kirimstatusketelegram
sleep 9

}

function bangkitcuk(){
if [[ -e /usr/local/sbin/restart ]]; then
    restart
else
    restartallservis > /dev/null 2>&1
fi

sleep 6
kirimstatusketelegram
sleep 9

}

function cekstatusxraydua() {
xray2=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [[ $xray2 == "running" ]]; then
        echo -ne
    else
        bangkitcuk
    fi

}

function cekstatusxraytiga() {
xray2=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [[ $xray2 == "running" ]]; then
        echo -ne
    else
        fixhaproxydanxray
    fi
sleep 10

}

function cekstatusxrayfinal() {
xray2=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [[ $xray2 == "running" ]]; then
        echo -ne
    else
        reboot
    fi

}

function cekstatusxraysatu() {
xray2=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [[ $xray2 == "running" ]]; then
        echo -ne
    else
        xrayfixawal
    fi

}

function fixhaproxy() {
bannerhaproxy
rm -fr /etc/haproxy/hap.pem
cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem
systemctl restart nginx
systemctl restart xray
echo -e "  \033[1;91m service restart daemon-reload\033[1;37m"
systemctl daemon-reload
echo -e "  \033[1;91m service restart haproxy\033[1;37m"    
systemctl restart haproxy

}

function cekhaproxyservis(){
haproxy_service=$(systemctl status haproxy | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [[ $haproxy_service == "running" ]]; then 
        echo -ne
    else
        fixhaproxy
        sleep 9
        if [[ $haproxy_service == "running" ]]; then
            echo -ne
        else
            fixhaproxydanxray
        fi
    fi

}

if [[ -e /etc/haproxy/haproxy.cfg ]]; then
    cekhaproxyservis
fi

cekstatusxraysatu
cekstatusxraydua
cekstatusxraytiga
cekstatusxrayfinal

nginx2=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
    if [[ $nginx2 == "running" ]]; then
        echo -ne
    else
        systemctl restart nginx
        systemctl start nginx
        sleep 6
        if [[ $nginx2 == "running" ]]; then
            echo -ne
        else
            bangkitcuk
            sleep 6
            if [[ $nginx2 == "running" ]]; then
                echo -ne
            else
                fixhaproxydanxray
            fi
        fi
    fi

cd /root
    if [[ -e /usr/bin/kyt ]]; then
        nginx=$( systemctl status kyt | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
        if [[ $nginx == "running" ]]; then
            echo -ne
        else
            systemctl restart kyt
            systemctl start kyt
        fi
        kyt=$( systemctl status kyt | grep "TERM" | wc -l )
        if [[ $kyt == "0" ]]; then
            echo -ne
        else
            systemctl restart kyt
            systemctl start kyt
        fi
    fi
stunnel=$( systemctl status ws-stunnel | grep "Errno" | wc -l )
    if [[ $stunnel == "0" ]]; then
        echo -ne
    else
        systemctl restart ws-stunnel
        systemctl start ws-stunnel
    fi
stunnel2=$( systemctl status ws-stunnel | grep "TERM" | wc -l )
    if [[ $stunnel2 == "0" ]]; then
        echo -ne
    else
        systemctl restart ws-stunnel
        systemctl start ws-stunnel
    fi
xrray=$( systemctl status xray | grep "error" | wc -l )
    if [[ $xrray == "0" ]]; then
        echo -ne
    else
        systemctl restart xray
        systemctl start xray
        systemctl restart nginx
        systemctl start nginx
    fi
bash2=$( pgrep bash | wc -l )
    if [[ $bash2 -gt "20" ]]; then
        killall bash
    fi
