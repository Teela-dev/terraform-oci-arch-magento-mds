#!/bin/bash

# Uploads SSH Public Key to authorized keys.
cp /home/opc/.ssh/authorized_keys /home/opc/.ssh/authorized_keys.bak
echo "${ssh_public_key}" >> /home/opc/.ssh/authorized_keys
chown -R opc /home/opc/.ssh/authorized_keys

wget http://epel.brisanet.com.br//epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
yum repolist

wget https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
sudo rpm -Uvh erlang-solutions-1.0–1.noarch.rpm
sudo yum install erlang

wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.9.29/rabbitmq-server-3.9.29-1.el8.noarch.rpm
sudo rpm — import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
sudo yum install rabbitmq-server-3.9.29-1.el8.noarch.rpm

sudo systemctl enable rabbitmq-server
sudo systemctl start rabbitmq-server
sudo systemctl stop rabbitmq-server

sudo rabbitmqctl add_user admin your_password
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin “.*” “.*” “.*”

sudo rabbitmq-plugins enable rabbitmq_management
