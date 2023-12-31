#!/bin/bash
cd /etc
nmap -p 22 $(curl -sS ipv4.icanhazip.com) > cekip
cpu=$(grep -c -E "open" "cekip")
    if [[ ${cpu} == '0' ]]; then
        apt install nmap -y
        shutdown -r now
    fi
cd /root
xray2=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [[ $xray2 == "running" ]]; then
        echo -ne
    else
        systemctl restart xray
        systemctl start xray
    fi
nginx2=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
    if [[ $nginx2 == "running" ]]; then
        echo -ne
    else
        systemctl restart nginx
        systemctl start nginx
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
