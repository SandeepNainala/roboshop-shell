#!/bin/bash

# This script is used to create an EC2 instance in AWS and install the Roboshop application on it.

instance=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "web")

for name in ${instance[@]}; do
  echo "Creating instance for: $name"
done