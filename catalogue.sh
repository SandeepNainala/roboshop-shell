echo -e "\e[36m<<<<<<<<<<Configuring NodeJS repos>>>>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[33m<<<<<<<<< Installing NodeJS >>>>>>>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[36m<<<<<<<<<<< Adding Application User>>>>>>>>>>>>>>>>\e[0m"
useradd roboshop
echo -e "\e[36m<<<<<<<<<<<<<<< Creating Application directory >>>>>>>>>>>>>>>>>>>>>>\e[0m"
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install

cp catalogue.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mongodb-dev.devops71.cloud </app/schema/catalogue.js
