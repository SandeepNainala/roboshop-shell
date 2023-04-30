app_user=roboshop

print_head(){
  echo -e "\e[36m<<<<<<<<<<< $* >>>>>>>>>>>>>\e[0m"
}

schema_setup() {
  if [ "$schema_setup" == "mongo" ]; then
    print_head copy MongoDB repo
    cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
    eprint_head Installing MongoDB client
    yum install mongodb-org-shell -y
    print_head Load schema
    mongo --host 172.31.19.96 </app/schema/${component}.js

fi
}

func_nodejs(){
  print_head "Configuring NodeJS repo"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  print_head "Install nodeJS repo"
  yum install nodejs -y

  print_head "Add App user"
  useradd ${app_user}

  print_head "create App dir"
  rm -rf /app
  mkdir /app
  print_head "download app content"
  curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
  cd /app
  print_head "unzip cart content"
  unzip /tmp/${component}.zip
  print_head "Download Package"
  npm install
  print_head "Copying user systemd files"
  cp /${script_path}/${component}.service /etc/systemd/system/${component}.service

  print_head "Start user services"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl restart ${component}

func_nodejs
schema_setup

}