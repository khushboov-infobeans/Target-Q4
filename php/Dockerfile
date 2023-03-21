 
FROM ubuntu:20.04
MAINTAINER Vicky Nandode <vicky.nandode@infobeans.com>

# Install apache, PHP, and supplimentary programs. openssh-server, curl, and lynx-cur are for debugging the container.


RUN  apt-get update  && DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update && apt-get -y install supervisor

# supervisord configuration

RUN /usr/bin/echo_supervisord_conf > /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor
RUN sed -i -e "s/^nodaemon=false/nodaemon=true/" /etc/supervisord.conf
RUN mkdir /etc/supervisord.d
RUN echo [include] >> /etc/supervisord.conf
RUN echo 'files = /etc/supervisord.d/*.ini' >> /etc/supervisord.conf

# apache php mysql installation


RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    apache2 php8.2 
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install php8.2-mysql libapache2-mod-php8.2 php8.2-xml php8.2-mbstring php8.2-gettext zip unzip php8.2-zip curl php8.2-curl php8.2-gd

RUN apt-get install nano

# Enable apache mods.

RUN a2enmod php8.2
RUN a2enmod rewrite

# Update the PHP.ini file, enable <? ?> tags and quieten logging.

RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/8.2/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/8.2/apache2/php.ini

# Manually set up the apache environment variables
RUN a2enmod rewrite
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV ALLOW_OVERRIDE All
ENV DATE_TIMEZONE UTC

# Expose apache.
EXPOSE 80

# Copy this repo into place.
#ADD src /var/www/html

VOLUME [ "/var/www/html"]

# Update the default apache site with the config we created.
ADD docker.tid.com.conf /etc/apache2/sites-available
RUN a2ensite docker.tid.com.conf


# By default start up apache in the foreground, override with /bin/bash for interative.
#CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]


# add apache2 program to supervisord config

RUN echo [program:apache2] >> /etc/supervisord.d/apache2.ini
RUN echo 'command=/usr/sbin/apache2ctl -D FOREGROUND' >> /etc/supervisord.d/apache2.ini
RUN echo 'stdout_logfile=/var/log/supervisor/%(program_name)s-stdout.log' >> /etc/supervisord.d/apache2.ini
RUN echo 'stderr_logfile=/var/log/supervisor/%(program_name)s-stderr.log' >> /etc/supervisord.d/apache2.ini
RUN echo  >> /etc/supervisord.d/apache2.ini


# add varnish program to supervisord config

RUN echo [program:varnish] >> /etc/supervisord.d/varnish.ini
RUN echo 'command=/usr/sbin/varnishd -f /etc/varnish/default.vcl  -a :80 -s malloc,1G -F' >> /etc/supervisord.d/varnish.ini
RUN echo 'stdout_logfile=/var/log/supervisor/%(program_name)s-stdout.log' >> /etc/supervisord.d/varnish.ini
RUN echo 'stderr_logfile=/var/log/supervisor/%(program_name)s-stderr.log' >> /etc/supervisord.d/varnish.ini
RUN echo  >> /etc/supervisord.d/varnish.ini

# add nginx program to supervisord config

RUN echo [program:nginx] >> /etc/supervisord.d/nginx.ini
RUN echo 'command=/usr/sbin/nginx -g "daemon off;"' >> /etc/supervisord.d/nginx.ini
RUN echo 'stdout_logfile=/var/log/supervisor/%(program_name)s-stdout.log' >> /etc/supervisord.d/nginx.ini
RUN echo 'stderr_logfile=/var/log/supervisor/%(program_name)s-stderr.log' >> /etc/supervisord.d/nginx.ini
RUN echo  >> /etc/supervisord.d/nginx.ini

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

# Install Composer
RUN apt-get update && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr


#update apache2.config


RUN echo "<Directory /var/www/html>" >> /etc/apache2/apache2.conf
RUN echo "RewriteEngine On" >> /etc/apache2/apache2.conf
RUN echo "RewriteBase /" >> /etc/apache2/apache2.conf
RUN echo "RewriteCond %{REQUEST_FILENAME} !-f" >> /etc/apache2/apache2.conf
RUN echo "RewriteCond %{REQUEST_FILENAME} !-d" >> /etc/apache2/apache2.conf
RUN echo "RewriteRule ^(.*)$ index.php?q=$1 [L,QSA]" >> /etc/apache2/apache2.conf
RUN echo "</Directory>" >> /etc/apache2/apache2.conf
RUN echo "ServerName 172.18.0.1" >> /etc/apache2/apache2.conf
RUN echo  >> /etc/apache2/apache2.conf



#RUN netstat -napl
