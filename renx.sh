#!/bin/bash

function renamesh2(){
rm -f binari-output.zip > /dev/null 2>&1
#Yaddy Kakkoii Magelang Phreaker Mywapblog
FOLDER=/root/bahan
mkdir -p $FOLDER/binari-output
mkdir -p $FOLDER/sementara
cd /root/bahan
cp *.sh $FOLDER/sementara
cp *.sh.x $FOLDER/sementara > /dev/null 2>&1
cp *.py $FOLDER/sementara > /dev/null 2>&1
zip -r sementara.zip sementara > /dev/null 2>&1;rm -fr sementara
mv -f sementara.zip /root
cd
for file in $FOLDER/*.sh
do
cp -v "$file" "${file%.sh}"
done
echo "file $FILE berhasil di rename .sh  ke binari"
rm $FOLDER/*.sh
cd /root/bahan
mv -f * $FOLDER/binari-output > /dev/null 2>&1
BIRU=$(tput setaf 4)
echo -e "$BIRU Bungkus semua file ke dalam Zip"
cd /root/bahan
zip -r binari-output.zip binari-output;mv -f *.zip /root;cd
echo -e "$BIRU Tunggu Sambil Ngopi enak nih :D..."
rm -fr /root/bahan/binari-output
cd /root
mv sementara.zip /root/bahan
cd /root/bahan
unzip -q sementara.zip;rm sementara.zip

cd /root/bahan
cp -f /root/bahan/sementara/* /root/bahan/
rm -fr /root/bahan/sementara
cd /root
}
renamesh2
