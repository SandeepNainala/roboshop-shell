source ${script_path}/common.sh
script=$(realpath "$0")
script_path=$(dirname "$script")

component=catalogue

func_nodejs

echo -e "\e[33m<<<<<<<<<<<<<< copy MongoDB repo >>>>>>>>>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[33m<<<<<<<<<<<<<< Installing MongoDB client  >>>>>>>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[33m<<<<<<<<<<<<<< Load schema >>>>>>>>>>>>>>>>>>\e[0m"
mongo --host 172.31.19.96 </app/schema/catalogue.js
