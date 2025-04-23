#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
logfile=/tmp/$0-$TIMESTAMP
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

cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $logfile

VALIDATE $? "copied mongodb repo"

dnf install mongodb-org -y &>> $logfile

VALIDATE $? "Installing mongodb"

systemctl enable mongod &>> $logfile

VALIDATE $? "Enabling MONGODB"

systemctl start mongod &>> $logfile

VALIDATE $? "starting MONGODB Service"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>> $logfile

VALIDATE $? "Updating IP ADDRESS" 

systemctl restart mongod &>> $logfile

VALIDATE $? "restarting mongod service"
