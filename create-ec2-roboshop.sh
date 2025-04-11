#!/bin/bash

# This script is used to create an EC2 instance in AWS and install the Roboshop application on it.

instance=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "web")

for name in ${instance[@]}; do
  if [ $name == "shipping" ] || [ $name == "mysql"]
  then
    instance_type = "t3.medium"
  else
    instance_type = "t3.micro"
  fi
  echo "Creating instance for: $name with the instance: $instance_type"
done