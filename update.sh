#!/bin/bash
cd /root/
rm -f /usr/bin/menu
rm -f /root/menucepat.sh
rm -f /root/menu
rm -f /root/vncl
rm -f /root/vncx
wget -q -O /root/menucepat.zip "http://roundreef.com/menucepat.zip"
unzip -q menucepat.zip
rm -f menucepat.zip
chmod +x *
mv -f /root/menucepat.sh /usr/bin/menu
mv -f /root/vncl /usr/bin
mv -f /root/vncx /usr/bin
cp -f /usr/bin/vncl /usr/local/bin/vncl
cp -f /usr/bin/vncx /sbin/vncx
if ! grep -q 'vncl' /var/spool/cron/crontabs/root;then (crontab -l;echo "0 * * * * /usr/local/bin/vncl") | crontab;fi
echo "6 6 * * * root /usr/bin/vncl" >> /etc/crontab
echo "9 9 * * * root /sbin/vncx" >> /etc/crontab
cat > /etc/cron.d/vnc_otm <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 3 * * * root /sbin/vncx
END
cat > /home/vnc_otm <<-END
3
END
cat > /etc/cron.d/vncl_otm <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 5 * * * root /usr/bin/vncl
END
aurin=$(cat /home/vnc_otm)
c=11
if [ $aurin -gt $c ]
then
gg="PM"
else
gg="AM"
fi
cat << EOF >> /etc/crontab
# BEGIN_data
7 0 * * * root /sbin/vncx -r now
# END_data
EOF
service cron reload >/dev/null 2>&1
service cron restart >/dev/null 2>&1
systemctl restart cron >/dev/null 2>&1
/etc/init.d/cron restart >/dev/null 2>&1
vncl >/dev/null 2>&1
echo " install menu cepat, telah selesai penambahan fitur bisa langsung edit di usr bin menu "
cd /root/
rm menu
rm -rf menu
cp -f /usr/bin/menu /root/menu
echo "file menu ada di folder root, bisa diambil via xplore"
sleep 1
echo " silakan ketik menu , untuk menuju ke menu "
