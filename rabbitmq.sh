#!/bin/bash

ID=$(id -u)
Timestamp=$(date +%Y-%m-%d-%H-%M-%S)
logfile=/tmp/$0-$Timestamp.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m

echo "Script execting time is $Timestamp"

VALIDATE( ) {
    IF [ $? -ne 0 ]; then

        echo -e " $2 .......... is $R FAILED..! $N "
        exit 1

    else

        echo -e " $2 .......... is $G SUCCESS..! $N "
    fi

}

if [ $? -ne 0 ]; then

    echo -e "you are $R NOT a root user" &>> $logfile
    exit 1

else

    echo -e "$G You are a root user..! Please procced $N" &>> $logfile

fi

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> $logfile

VALIDATE $? "Configure YUM Repos from the script provided by vendor"

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> $logfile

VALIDATE $? "Configure YUM Repos for RabbitMQ"

dnf install rabbitmq-server -y &>> $logfile

VALIDATE $? "installing RabbitMQ"

systemctl enable rabbitmq-server &>> $logfile

VALIDATE $? "enabeling RabbitMQ"

systemctl start rabbitmq-server &>> $logfile

VALIDATE $? "start the RabbitMQ"

rabbitmqctl add_user roboshop roboshop123 &>> $logfile

VALIDATE $? "adding new user RabbitMQ"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> $logfile

VALIDATE $? "setting new password"