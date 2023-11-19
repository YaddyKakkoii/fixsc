#!/bin/bash
function renamesh(){
MERAH=$(tput setaf 1)
IJO=$(tput setaf 2)
KUNING=$(tput setaf 3)
#Yaddy Kakkoii Magelang Phreaker Mywapblog
rm -f sh-output.zip > /dev/null 2>&1
FOLDER=/root/bahan
    for file in $FOLDER/*
    do
        mv -v "$file" ${file}.sh
    done
echo "file $FILE berhasil di rename binari  ke sh"
decc
}
renamesh