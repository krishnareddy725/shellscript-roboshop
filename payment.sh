#!/bin/bash

ID=$(id -u)
Timestamp=$(date +%Y-%m-%d-%H-%M-%S)
logfile=/tmp/$0-$Timestamp.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo -e "Script execution time is $Timestamp"

VALIDATE( ) {

    if [ $? -ne 0 ]; then

        echo -e " $2........is $R FAILED...!"
        exit 1

    else

        echo -e "$2.........is $G SUCCESS...! $N"
    
    fi
}

if [ $ID -ne 0 ]; then

    echo -e " you are $R NOT a root user" &>> logfile
    exit 1

else

    echo -e "You are a $G ROOT USER. PLEASE PROCCED...! $N" &>> logfile

fi

dnf install python36 gcc python3-devel -y &>> logfile

VALIDATE $? "Install Python related packages"

id roboshop

if [ $? -ne 0 ]; then

    useradd roboshop 
    echo -e " $G suceessfully created roboshop user $N " &>> logfile

else

    echo -e " $Y roboshop user is already presented at server $N " &>> logfile

fi

mkdir -p /app &>> logfile

VALIDATE $? "Creating application related directory"

curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip &>> logfile

VALIDATE $? "Downloading the payment related package"

cd /app &>> logfile

VALIDATE $? "going to the application directory"

unzip /tmp/payment.zip &>> logfile

VALIDATE $? "unzipping the payment related applications"

cd /app &>> logfile

VALIDATE $? "going to the application directory"

pip3.6 install -r requirements.txt &>> logfile

VALIDATE $? "installing the requirement applications"

systemctl daemon-reload &>> logfile

VALIDATE $? "reloading the daemon"

systemctl enable payment &>> logfile

VALIDATE $? "enabeling the payment service"

systemctl start payment &>> logfile

VALIDATE $? "starting the payment service"