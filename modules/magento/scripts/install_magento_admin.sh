#!/bin/bash
#set -x

cd /var/www/html
magento_version=${magento_version}
wget https://github.com/magento/magento2/archive/$magento_version.tar.gz
tar zxvf $magento_version.tar.gz --directory /var/www/html
  cp -r /var/www/html/magento2-$magento_version/* /var/www/html
  rm -rf /var/www/html/magento2-$magento_version
  rm -rf /var/www/html/$magento_version.tar.gz
chown apache:apache -R /var/www/html
sed -i '/AllowOverride None/c\AllowOverride All' /etc/httpd/conf/httpd.conf
cd /usr/local/bin
wget https://getcomposer.org/composer-1.phar
chmod +x composer-1.phar
mv composer-1.phar composer
cd /var/www/html
/usr/local/bin/composer install
/var/www/html/bin/magento setup:install --no-ansi --db-host ${mds_ip}  --db-name ${magento_schema} --db-user ${magento_name} --db-password '${magento_password}' --admin-firstname='${magento_admin_firstname}' --admin-lastname='${magento_admin_lastname}' --admin-user='${magento_admin_login}' --admin-password='${magento_admin_password}' --admin-email='${magento_admin_email}'
/var/www/html/bin/magento config:set web/unsecure/base_url http://${public_ip}/
/var/www/html/bin/magento config:set web/secure/base_url https://${public_ip}/
/var/www/html/bin/magento config:set web/secure/use_in_frontend 1
/var/www/html/bin/magento config:set web/secure/use_in_adminhtml 0
chown apache:apache -R /var/www/html
systemctl start httpd
systemctl enable httpd

echo "Magento deployed and Apache started !"
