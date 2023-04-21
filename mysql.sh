echo -e "\e[36m<<<<<<<<<<< disable mySQL old version >>>>>>>>>>>>>\e[0m"
dnf module disable mysql -y
echo -e "\e[36m<<<<<<<<<<< download mySQL repo >>>>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repo.d/mysql.repo
echo -e "\e[36m<<<<<<<<<<< Install mySQL >>>>>>>>>>>>>\e[0m"
yum install mysql-community-server -y
echo -e "\e[36m<<<<<<<<<<< start mySQL service  >>>>>>>>>>>>>\e[0m"
systemctl enable mysqld
systemctl start mysqld
echo -e "\e[36m<<<<<<<<<<< secure install mySQL >>>>>>>>>>>>>\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
mysql -uroot -pRoboShop@1
systemctl restart mysqld

