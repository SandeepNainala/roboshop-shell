script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

mysql_root_password=$1

if [ -z "$mysql_root_password" ]; then
  echo Input mySQL root password missing
  exit
fi

echo -e "\e[36m<<<<<<<<<<< disable mySQL old version >>>>>>>>>>>>>\e[0m"
dnf module disable mysql -y
echo -e "\e[36m<<<<<<<<<<< download mySQL repo >>>>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repo.d/mysql.repo
echo -e "\e[36m<<<<<<<<<<< Install mySQL >>>>>>>>>>>>>\e[0m"
yum install mysql-community-server -y
echo -e "\e[36m<<<<<<<<<<< start mySQL service  >>>>>>>>>>>>>\e[0m"
systemctl enable mysqld
systemctl restart mysqld
echo -e "\e[36m<<<<<<<<<<< secure install mySQL >>>>>>>>>>>>>\e[0m"
mysql_secure_installation --set-root-pass $mysql_root_password



