
#!/bin/bash

set -e


nginx=stable

#add-apt-repository ppa:nginx/$nginx

apt-get update

apt-get install -y nginx

a2enmod ssl

