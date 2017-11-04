FROM ubuntu:16.04

# Reference
# https://github.com/hanskerkhof/docker-ubuntu-apache-php7-mysql

#install packages
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get install -y  --no-install-recommends \
    sudo ca-certificates apt-utils locales curl less nano unzip wget git\
    mysql-server \
    apache2 \
    zip \
    rsync \
    php7.0 php7.0-mysql php7.0-curl php7.0-gd php7.0-mcrypt php7.0-xml php7.0-mbstring libapache2-mod-php7.0

# Enable apache mods.
RUN a2enmod headers
RUN a2enmod rewrite
RUN a2enmod ssl

## Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf
RUN rm /var/www/html/*
ADD www /var/www/html

# Set apache servername
RUN sed -i '1iServerName localhost' /etc/apache2/apache2.conf

# restart apache and mysql
RUN service mysql start && service apache2 start

# add entrypont
ADD entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh
ENTRYPOINT /entrypoint.sh

# Expose apache and mysql
EXPOSE 80 3306
