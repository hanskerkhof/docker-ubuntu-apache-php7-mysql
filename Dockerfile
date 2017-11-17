FROM ubuntu:16.04

RUN apt-get -y update        # Fetches the list of available updates
RUN apt-get -y upgrade       # Strictly upgrades the current packages
RUN apt-get -y dist-upgrade  # Installs updates (new ones)

# Reference
# https://github.com/hanskerkhof/docker-ubuntu-apache-php7-mysql

#install packages

RUN apt-get install -y software-properties-common python-software-properties

#install php7.1
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && apt-get update && apt-get upgrade -y
RUN apt-get install -y php7.1 php7.1-mysql php7.1-curl php7.1-gd php7.1-mcrypt php7.1-xml php7.1-mbstring libapache2-mod-php7.1

RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get install -y  --no-install-recommends \
    sudo ca-certificates apt-utils locales curl less nano unzip wget git\
    mysql-server \
    apache2 \
    zip \
    ssh \
    rsync



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
