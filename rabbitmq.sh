echo -e "\e[36m<<<<<<<<<<< download erlang >>>>>>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
echo -e "\e[36m<<<<<<<<<<< install erlang >>>>>>>>>>>>>\e[0m"
yum install erlang -y
echo -e "\e[36m<<<<<<<<<<< download rabbitmq server script >>>>>>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
echo -e "\e[36m<<<<<<<<<<< install rabbitmq server >>>>>>>>>>>>>\e[0m"
yum install rabbitmq-server -y
echo -e "\e[36m<<<<<<<<<<< enable and start rabbitmq server >>>>>>>>>>>>>\e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
echo -e "\e[36m<<<<<<<<<<< configure user password >>>>>>>>>>>>>\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
