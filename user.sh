source ${script_path}/common.sh
script=$(realpath "$0")
script_path=$(dirname "$script")

component=user

func_nodejs

echo -e "\e[33m<<<<<<<<<<<<<< start mongodb >>>>>>>>>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[33m<<<<<<<<<<<<<< install mongodb >>>>>>>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[33m<<<<<<<<<<<<<< connect mongodb >>>>>>>>>>>>>>>>>>\e[0m"
mongo --host 172.31.19.96 </app/schema/user.js