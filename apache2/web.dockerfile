FROM ubuntu:latest
ADD ./apache2.conf /etc/apache2/apache2.conf:ro
ADD ./sites-enabled/cakephp.conf /etc/apache2/sites-enabled/cakephp.conf
