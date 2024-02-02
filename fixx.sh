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
sleep 2 
menu
}
fixhaproxydanxray
