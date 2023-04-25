script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

mysql_root_password=$1

component=shipping

func_nodejs

print_head Install mysql
yum install mysql -y

print_head start mysql schema
mysql -h mysql-dev.devops71.cloud -uroot -p${mysql_root_password} < /app/schema/shipping.sql

systemctl restart ${component}