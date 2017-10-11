# docker-ubuntu-apache-php7-mysql

### build
    docker build -t hanskerkhof/ubuntu-apache-php7-mysql .
    
#### Force rebuild
    docker build --no-cache -t hanskerkhof/ubuntu-apache-php7-mysql .

### run
    docker run -i -t hanskerkhof/ubuntu-apache-php7-mysql /bin/bash

### publish
    docker push hanskerkhof/ubuntu-apache-php7-mysql
    
### Installed

| Package     | Version                    |
| ------------|----------------------------|
| Ubuntu      | 16.04.3 LTS (Xenial Xerus) |
| Apache2     | 2 2.4.18                   |
| Mysql       | 5.7.19                     |
| PHP         | 7.0.22                     |
|             |                            |
| curl        | 7.47.0                     |
| git         | 2.7.4                      |
