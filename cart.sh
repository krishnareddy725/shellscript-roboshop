#!/bin/bash

ID=$(id -u)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
logfile=/tmp/$0-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE ( ) {
    if [ $? -ne 0 ]; then

        echo -e " $2..........$R is FAILED $N"
        exit 1
    else
        echo -e " $2..........$G is SUCCESS $N"

    fi
}

if [ $ID -ne 0 ]; then

    echo -e " $R You are NOT a root user $n"
    exit 1

else
   
    echo -e " $G you are a ROOT user..! Please $Y PROCCED $N "

fi

