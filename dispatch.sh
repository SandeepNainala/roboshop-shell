echo -e "\e[36m<<<<<<<<<<< install golang >>>>>>>>>>>>>\e[0m"
yum install golang -y
echo -e "\e[36m<<<<<<<<<<< add application user  >>>>>>>>>>>>>\e[0m"
useradd roboshop
echo -e "\e[36m<<<<<<<<<<< create App dir  >>>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[36m<<<<<<<<<<< download app content >>>>>>>>>>>>>\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app
echo -e "\e[36m<<<<<<<<<<< unzip dispatch content  >>>>>>>>>>>>>\e[0m"
unzip /tmp/dispatch.zip
cd /app
echo -e "\e[36m<<<<<<<<<<< package go >>>>>>>>>>>>>\e[0m"
go mod init dispatch
go get
go build
echo -e "\e[36m<<<<<<<<<<< start systemd service  >>>>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service
echo -e "\e[36m<<<<<<<<<<< start dispatch service >>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch
