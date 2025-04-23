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

dnf module disable nodejs -y &>> $logfile

VALIDATE $? "Disabeling old nodejs"

dnf module enable nodejs:18 -y &>> $logfile

VALIDATE $? "Enabeling the new nodejs"

dnf install nodejs -y &>> $logfile

VALIDATE $? "Installing the nodejs"

id roboshop

if [ $? -ne 0 ]; then

    adduser roboshop &>> $logfile
    echo -e " $G roboshop user is CREATED $N"

else
    
    echo -e " $Y roboshop user ALREADY avilable in server $N" &>> $logfile

fi

mkdir -p /app &>> $logfile

VALIDATE $? "Creating the application directory"

curl -L -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip &>> $logfile

VALIDATE $? "Downloading the cart application"

cd /app &>> $logfile

VALIDATE $? "going to app directory"

unzip /tmp/cart.zip &>> $logfile

VALIDATE $? "unzipping the application file"

cd /app &>> $logfile

VALIDATE $? "going to application directory"

npm install &>> $logfile

VALIDATE $? "Installing the Dependencies"

cp /root/shellscript-roboshop/cart.service /etc/systemd/system/cart.service

VALIDATE $? "copy the service file"

systemctl daemon-reload

VALIDATE $? "reloading the daemon"

systemctl enable cart

VALIDATE $? "enabeling the cart service"

systemctl start cart

VALIDATE $? "Starting the CART service"

