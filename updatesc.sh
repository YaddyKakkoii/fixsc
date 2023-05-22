#!/bin/bash
#jika versi lokal = versi di repo ku maka SC udah terbaru
echo -e "\e[32mUpdate Menu cepat sudah tersedia!!\e[0m";
sleep 1
echo -e "\e[mulai mengupdate script!!\e[0m";
bash -c "$(wget -qO- https://raw.githubusercontent.com/YaddyKakkoii/fixsc/main/update.sh)"
rm -f update.sh
echo "done....."
