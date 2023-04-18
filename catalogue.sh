echo -e "\e[36m<<<<<<<<<<Configuring NodeJS repos>>>>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[33m<<<<<<<<< Installing NodeJS >>>>>>>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[36m<<<<<<<<<<< Adding Application User>>>>>>>>>>>>>>>>\e[0m"
useradd roboshop
echo -e "\e[36m<<<<<<<<<<<<<<< Creating Application directory >>>>>>>>>>>>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[33m<<<<<<<<<< Downloading application content >>>>>>>>>>>>>>>>>\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[33m<<<<<<<<<<<< unzip app content >>>>>>>>>>>>>>>>>>>>>>\e[0m"
unzip /tmp/catalogue.zip
echo -e "\e[33m<<<<<<<<<<<<<<<< Installing NodeJS packages >>>>>>>>>>>>>>>>>>\e[0m "
npm install
echo -e "\e[33m<<<<<<<<<<<<<< copying catalogue systemd files  >>>>>>>>>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[33m<<<<<<<<<<<<<< starting catalogue serices >>>>>>>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
echo -e "\e[33m<<<<<<<<<<<<<< copy MongoDB repo >>>>>>>>>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[33m<<<<<<<<<<<<<< Installing MongoDB client  >>>>>>>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[33m<<<<<<<<<<<<<< Load schema >>>>>>>>>>>>>>>>>>\e[0m"
mongo --host 172.31.19.96 </app/schema/catalogue.js
