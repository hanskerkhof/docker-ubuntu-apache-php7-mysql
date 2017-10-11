FROM ubuntu:16.04

# Reference 
# https://github.com/hanskerkhof/docker-ubuntu-apache-php7-mysql

RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get install -y  --no-install-recommends \
    sudo \
    ca-certificates \
    apt-utils \
    locales \
    curl \
    less \
    nano \
    mysql-server \
    apache2 \
    php7.0 php7.0-mysql php7.0-curl php7.0-gd php7.0-mcrypt php7.0-xml php7.0-mbstring libapache2-mod-php7.0 \
    unzip wget git

# Enable apache mods.
RUN a2enmod php7.0
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod ssl

RUN service mysql start && service apache2 start

ADD entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh
ENTRYPOINT /entrypoint.sh

# Expose apache mysql 
EXPOSE 80 3306
