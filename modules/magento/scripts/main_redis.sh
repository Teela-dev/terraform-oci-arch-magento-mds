#!/bin/bash
set -x
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/tmp/tflog.out 2>&1

REDIS_CONFIG_FILE=/etc/redis.conf
SENTINEL_CONFIG_FILE=/etc/sentinel.conf

# Setup firewall rules
firewall-offline-cmd  --zone=public --add-port=${redis_port}/tcp
#firewall-offline-cmd  --zone=public --add-port=${redis_port2}/tcp
#firewall-offline-cmd  --zone=public --add-port=${sentinel_port}/tcp
systemctl restart firewalld

# Install wget and gcc
yum install -y wget gcc

# Download and compile Redis
wget http://download.redis.io/releases/redis-${redis_version}.tar.gz
tar xvzf redis-${redis_version}.tar.gz
cd redis-${redis_version}
make install

# Configure Sentinel
cat << EOF > $REDIS_CONFIG_FILE
port ${redis_port}
requirepass ${redis_password}
masterauth ${redis_password}
EOF

sleep 30
#/usr/local/bin/redis-server $SENTINEL_CONFIG_FILE --sentinel --daemonize yes
#/usr/local/bin/redis-server $REDIS_CONFIG_FILE
#nohup /usr/local/bin/redis-server $SENTINEL_CONFIG_FILE --sentinel > /tmp/redis-server.log &
