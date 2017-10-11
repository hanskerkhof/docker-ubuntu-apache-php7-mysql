# docker-ubuntu-apache-php7-mysql

### build
    docker build -t hanskerkhof/ubuntu-apache-php7-mysql .
    
#### Force rebuild
    docker build --no-cache -t hanskerkhof/ubuntu-apache-php7-mysql .

### run
    docker run -i -t hanskerkhof/ubuntu-apache-php7-mysql /bin/bash

### publish
    docker push hanskerkhof/ubuntu-apache-php7-mysql
    
    