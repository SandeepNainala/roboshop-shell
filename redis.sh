echo -e "\e[32m<<<<<<<<<<<< Install redis repo >>>>>>>>>>>>>>>>\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
echo -e "\e[33m<<<<<<<<<<<<<<< install redis module >>>>>>>>>>>>>>>>\e[0m"
dnf module enable redis:remi-6.2 -y
echo -e "\e[31m<<<<<<<<< Install Redis repo again >>>>>>>>>>>>>>\e[0m"
yum install redis -y
echo -e "\e[33m<<<<<<<<<< update redis.conf file >>>>>>>>>>>>\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0' /etc/redis.conf /etc/redis/redis.conf
echo -e "\e[33m<<<<<<<<<<< start redis server >>>>>>>>>>>>\e[0m"
systemctl enable redis
systemctl start redis