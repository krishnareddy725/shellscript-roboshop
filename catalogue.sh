#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

Timestamp=$(date +%Y-%m-%d-%H-%M-%S)
logfile=/tmp/$0-$Timestamp

echo " Scritpt start executing at $Timestamp" &>> $logfile

VALIDATE( ) {
    if [ $? -ne 0 ]; then

        echo -e " $R ERROR..!$2............ is FAILED %N"
        exit 1
    
    else

        echo -e " $G SUCCESS..!$2 .............. is success %N"

    fi    
}

if [ $ID -ne 0 ]; then

    echo -e " $R YOU ARE NOT A ROOT USER $N"
    exit 1

else

    echo -e " %G You are a ROOT user..Please Procced $N"

fi

dnf module disable nodejs -y &>> $logfile

VALIDATE $? "Uninstalling the old nodejs version"

dnf module enable nodejs:18 -y &>> $logfile

VALIDATE $? "Installing the nodejs:18"

dnf install nodejs -y &>> $logfile

VALIDATE $? "Installing the nodejs"

id roboshop &>> $logfile

if [ $? -ne 0 ]; then

    useradd roboshop
    VALIDATE $? "roboshop user has created"

else

    echo -e " roboshop user already created" &>> $logfile 

fi

mkdir -p /app &>> $logfile

VALIDATE $? &>> $logfile

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>> $logfile

VALIDATE $? "download the file to zip file"

unzip -0 /tmp/catalogue.zip $logfile

VALIDATE $? "unzipping the catalogue zip file"

cd /app &>> $logfile

VALIDATE $? "moveing to app folder"

npm install &>> $logfile

VALIDATE $? "Installing the dependencies"

cp /c/Users/vnred/repos/scripting/shellscript roboshoshop/catalogue.service /etc/systemd/system/catalogue.service &>> $logfile

VALIDATE $? "copying the catalogue.service file"

systemctl daemon-reload &>> $logfile

VALIDATE $? "load the service"

systemctl enable catalogue &>> $logfile

VALIDATE $? "enabeling the catalogue service"

systemctl start catalogue &>> $logfile

VALIDATE $? "start the catalogue service"

cp /c/Users/vnred/repos/scripting/shellscript roboshoshop/mongo.repo /etc/yum.repos.d/mongo.repo &>> $logfile

VALIDATE $? "copying the mongo.repo file"

dnf install mongodb-org-shell -y  &>> $logfile

VALIDATE $? "installing the mongodb client"

mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js  &>> $logfile

VALIDATE $? "load the catalogue data into mongodb"