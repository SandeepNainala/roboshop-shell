source ${script_path}/common.sh
script=$(realpath "$0")
script_path=$(dirname "$script")
mysql_root_password=$1

echo -e "\e[36m<<<<<<<<<<< install maven packages >>>>>>>>>>>>>\e[0m"
yum install maven -y
echo -e "\e[36m<<<<<<<<<<< add app user  >>>>>>>>>>>>>\e[0m"
useradd ${app-user}
echo -e "\e[36m<<<<<<<<<<< add app dir >>>>>>>>>>>>>\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[36m<<<<<<<<<<< downlaod app content >>>>>>>>>>>>>\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
echo -e "\e[36m<<<<<<<<<<< unzip app content >>>>>>>>>>>>>\e[0m"
unzip /tmp/shipping.zip
echo -e "\e[36m<<<<<<<<<<< clean maven packages >>>>>>>>>>>>>\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[36m<<<<<<<<<<< systemd files copy >>>>>>>>>>>>>\e[0m"

cp ${script_path}/shipping.service /etc/systemd/system/shipping.service

echo -e "\e[36m<<<<<<<<<<< install mysql>>>>>>>>>>>>>\e[0m"
yum install mysql -y
echo -e "\e[36m<<<<<<<<<<< start mysql schema >>>>>>>>>>>>>\e[0m"
mysql -h mysql-dev.devops71.cloud -uroot -p${mysql_root_password} < /app/schema/shipping.sql
echo -e "\e[36m<<<<<<<<<<< start shipping service  >>>>>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping