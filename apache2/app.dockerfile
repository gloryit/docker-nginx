FROM ubuntu:latest
RUN apt-get update \
    && apt-get -y install apache2

RUN apt-get -y install libapache2-mod-php7.0 php7.0-common php7.0 php7.0-cli php-xdebug php7.0-mbstring sqlite3 php7.0-mysql php-imagick php-memcached php-pear curl imagemagick php7.0-dev php7.0-phpdbg php7.0-gd npm nodejs-legacy php7.0-json php7.0-curl php7.0-sqlite3 php7.0-intl apache2 vim git-core wget libsasl2-dev libssl-dev libsslcommon2-dev libcurl4-openssl-dev autoconf g++ make openssl libssl-dev libcurl4-openssl-dev pkg-config libsasl2-dev libpcre3-dev \
	&& a2enmod headers \
    && a2enmod ssl \
    && a2enmod rewrite

# Enable apache mods.
RUN a2enmod ssl
RUN a2enmod rewrite
RUN a2enmod headers

RUN mkdir -p /etc/apache2/sites-enabled

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.0/apache2/php.ini

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80 443

CMD service apache2 restart
CMD /usr/sbin/apache2ctl -D FOREGROUND