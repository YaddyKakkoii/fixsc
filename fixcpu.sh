#!/bin/bash
function cekcronjob(){
cat> /etc/cron.d/autocpu << END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/7 * * * * root /usr/bin/autocpu
END
}

function cekotherfile(){
REPO="https://raw.githubusercontent.com/YaddyKakkoii/fixsc/main/"
    if [ ! -e /usr/bin/autocpu ]; then
        wget -qO /usr/bin/autocpu "${REPO}autocpu.sh" && chmod +x /usr/bin/autocpu
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