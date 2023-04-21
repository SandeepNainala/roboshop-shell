echo -e "\e[36m<<<<<<<<<<< install python >>>>>>>>>>>>>\e[0m"
yum install python36 gcc python3-devel -y
echo -e "\e[36m<<<<<<<<<<< add app user >>>>>>>>>>>>>\e[0m"
useradd roboshop
echo -e "\e[36m<<<<<<<<<<< create app dir >>>>>>>>>>>>>\e[0m"
mkdir /app
echo -e "\e[36m<<<<<<<<<<< download app content >>>>>>>>>>>>>\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
rm -rf /app
cd /app
echo -e "\e[36m<<<<<<<<<<< unzip payment content >>>>>>>>>>>>>\e[0m"
unzip /tmp/payment.zip
cd /app
echo -e "\e[36m<<<<<<<<<<< install pip3.6 >>>>>>>>>>>>>\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m<<<<<<<<<<< copy systemd files  >>>>>>>>>>>>>\e[0m"
cp payment.service /etc/systemd/system/payment.service

echo -e "\e[36m<<<<<<<<<<< start payment service >>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl start payment