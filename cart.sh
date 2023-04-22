source common.sh
echo -e "\e[36m<<<<<<<<<<< configure nodeJS repo >>>>>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m<<<<<<<<<<< install nodeJS repo >>>>>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[36m<<<<<<<<<<< add App user >>>>>>>>>>>>>\e[0m"
useradd ${app_user}
echo -e "\e[36m<<<<<<<<<<< create App dir >>>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[36m<<<<<<<<<<< download app content >>>>>>>>>>>>>\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
echo -e "\e[36m<<<<<<<<<<< unzip cart content >>>>>>>>>>>>>\e[0m"
unzip /tmp/cart.zip
echo -e "\e[36m<<<<<<<<<<< download package >>>>>>>>>>>>>\e[0m"
npm install
echo -e "\e[33m<<<<<<<<<<<<<< copying user systemd files  >>>>>>>>>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service
echo -e "\e[33m<<<<<<<<<<<<<< start user services >>>>>>>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart
