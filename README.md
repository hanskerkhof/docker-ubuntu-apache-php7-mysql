# docker-ubuntu-apache-php7-mysql

### build
    docker build -t hanskerkhof/ubuntu-apache-php7-mysql .
    
#### Force rebuild
    docker build --no-cache -t hanskerkhof/ubuntu-apache-php7-mysql .

### run
    docker run -i -t hanskerkhof/ubuntu-apache-php7-mysql

#### run and expose to local machine
    docker run -p 8090:80 -i -t hanskerkhof/ubuntu-apache-php7-mysql

Access it via `http://localhost:8090/` in a browser


### publish
    docker push hanskerkhof/ubuntu-apache-php7-mysql
    
### Installed

| Package     | Version                    |
| ------------|----------------------------|
| Ubuntu      | 16.04.3 LTS (Xenial Xerus) |
| Apache2     | 2 2.4.18                   |
| Mysql       | 5.7.19                     |
| PHP         | 7.1                        |
|             |                            |
| zip         |                            |
| curl        | 7.47.0                     |
| git         | 2.7.4                      |
| ssh         |                            |
| rsync       |                            |

### Notes

https://writing.pupius.co.uk/apache-and-php-on-docker-44faef716150

https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes

#### Check for more php mods
https://hub.docker.com/r/navidonskis/nginx-php7.1/~/dockerfile/
