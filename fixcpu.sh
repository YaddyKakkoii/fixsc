#!/bin/bash
apt-get install psmisc
apt install nmap -y
function cekcronjob(){
cat> /etc/cron.d/autocpu << END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/7 * * * * root /usr/bin/autocpu
END

}

function cekotherfile(){
REPO="https://raw.githubusercontent.com/YaddyKakkoii/fixsc/main/"
if [ ! -e /etc/cekip ]; then
    cd /etc
    nmap -p 22 $(curl -sS ipv4.icanhazip.com) > cekip
    cd /root
fi
    if [ ! -e /usr/bin/autocpu ]; then
        wget -qO /usr/bin/autocpu "${REPO}autocpu.sh" && chmod +x /usr/bin/autocpu
    else
        rm -f /usr/bin/autocpu && wget -qO /usr/bin/autocpu "${REPO}autocpu.sh" && chmod +x /usr/bin/autocpu
    fi
if [ ! -e /etc/cron.d/autocpu ]; then
    cekcronjob
fi

}

cekotherfile
cekcronjob

echo "Auto-Reboot CPU 100% TURN ON."

sleep 1
service cron restart
sleep 2
systemctl restart cron
sleep 3
/etc/init.d/cron restart
sleep 4
/etc/init.d/cron status
