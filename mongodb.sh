#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
logfile=/tmp/$0-TIMESTAMP
echo "Script started executing at $TIMESTAMP" &>> $logfile

VALIDATE( ) {
    if [ $? -ne 0]; then
        echo -e "$2 .............$R FAILED $N"
        exit 1
    else
        echo -e "$2 .............$G Success $N"
    fi
}

if [ $ID -ne 0 ]; then

    echo -e "$R ERROR: Please run this script as a root user $N"
    exit 1

else

    echo -e "$G SUCCESS: You are a ROOT USER...! Please Procced $N"

fi


