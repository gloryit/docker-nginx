FROM php:7.1-apache

RUN apt-get update \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libicu-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-install pdo pdo_mysql mysqli \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install redis-3.1.4 \
    && pecl install xdebug-2.5.5 \
    && docker-php-ext-enable redis xdebug mysqli pdo pdo_mysql intl

RUN apt-get update \
	&& a2enmod headers \
    && a2enmod ssl \
    && a2ensite default-ssl \
    && a2enmod rewrite

RUN apt-get install apache2 libapache2-mod-php7.1 -y

# Enable apache mods.
RUN a2enmod ssl
RUN a2enmod rewrite
RUN a2enmod headers

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.1/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.1/apache2/php.ini

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80
EXPOSE 443

RUN systemctl restart apache2
RUN /usr/sbin/apache2ctl -D FOREGROUND
