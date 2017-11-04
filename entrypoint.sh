#!/bin/sh

# set -e

echo "####### starting the entrypoint ######"
usermod -d /var/lib/mysql/ mysql
service mysql start

#a2enmod headers
service apache2 restart

/bin/bash
