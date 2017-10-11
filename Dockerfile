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

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
#RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini
#RUN sed -i "s|;error_log = php_errors.log|error_log = /var/log/php_errors.log|" /etc/php/7.0/apache2/php.ini
#RUN sed -i "s/display_errors = Off/display_errors = On/" /etc/php/7.0/apache2/php.ini
#RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.0/apache2/php.ini

#RUN touch /var/log/php_errors.log
#RUN chmod 777 /var/log/php_errors.log

## Manually set up the apache environment variables
#ENV APACHE_RUN_USER www-data
#ENV APACHE_RUN_GROUP www-data
#ENV APACHE_LOG_DIR /var/log/apache2
#ENV APACHE_LOCK_DIR /var/lock/apache2
#ENV APACHE_PID_FILE /var/run/apache2.pid


## Update the default apache site with the config we created.
#ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf
#RUN a2ensite 000-default.conf

## Install MySQL.
## add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
#RUN groupadd -r mysql && useradd -r -g mysql mysql

# add gosu for easy step-down from root
#ENV GOSU_VERSION 1.7
#RUN set -x \
#	&& apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/* \
#	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
#	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
#	&& export GNUPGHOME="$(mktemp -d)" \
#	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
#	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
#	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
#	&& chmod +x /usr/local/bin/gosu \
#	&& gosu nobody true \
#	&& apt-get purge -y --auto-remove ca-certificates

#RUN mkdir /docker-entrypoint-initdb.d

#RUN apt-get update && apt-get install -y --no-install-recommends \
## for MYSQL_RANDOM_ROOT_PASSWORD
#		pwgen \
## for mysql_ssl_rsa_setup
#		openssl \
## FATAL ERROR: please install the following Perl modules before executing /usr/local/mysql/scripts/mysql_install_db:
## File::Basename
## File::Copy
## Sys::Hostname
## Data::Dumper
#		perl \
#	&& rm -rf /var/lib/apt/lists/*

#RUN set -ex; \
## gpg: key 5072E1F5: public key "MySQL Release Engineering <mysql-build@oss.oracle.com>" imported
#	key='A4A9406876FCBD3C456770C88C718D3B5072E1F5'; \
#	export GNUPGHOME="$(mktemp -d)"; \
#	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
#	gpg --export "$key" > /etc/apt/trusted.gpg.d/mysql.gpg; \
#	rm -r "$GNUPGHOME"; \
#	apt-key list > /dev/null
#
#ENV MYSQL_MAJOR 5.7
#ENV MYSQL_VERSION 5.7.19-1debian8
#
#RUN echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-${MYSQL_MAJOR}" > /etc/apt/sources.list.d/mysql.list
#
## the "/var/lib/mysql" stuff here is because the mysql-server postinst doesn't have an explicit way to disable the mysql_install_db codepath besides having a database already "configured" (ie, stuff in /var/lib/mysql/mysql)
## also, we set debconf keys to make APT a little quieter
#RUN { \
#		echo mysql-community-server mysql-community-server/data-dir select ''; \
#		echo mysql-community-server mysql-community-server/root-pass password ''; \
#		echo mysql-community-server mysql-community-server/re-root-pass password ''; \
#		echo mysql-community-server mysql-community-server/remove-test-db select false; \
#	} | debconf-set-selections \
#	&& apt-get update && apt-get install -y mysql-server="${MYSQL_VERSION}" \
#	&& rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
#	&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
## ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
#	&& chmod 777 /var/run/mysqld

# comment out a few problematic configuration values
# don't reverse lookup hostnames, they are usually another container
#RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/mysql.conf.d/mysqld.cnf \
#	&& echo '[mysqld]\nskip-host-cache\nskip-name-resolve' > /etc/mysql/conf.d/docker.cnf


## Install Zsh
#RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
#      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
#      && chsh -s /bin/zsh
#
#RUN sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"avit\"/"  ~/.zshrc

RUN service mysql start && service apache2 start

ADD entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh
ENTRYPOINT /entrypoint.sh

# Expose apache mysql 
EXPOSE 80 3306
