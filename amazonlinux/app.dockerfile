FROM amazonlinux

#bash-completion
RUN yum update -y \
    && yum install epel-release -y \
    && yum-config-manager --enable epel \
    && yum --enablerepo=epel install redis -y \
    && yum install net-tools htop vim httpd24 wget lsof mod24_ssl mysql-server \
        php70 php70-mysqlnd php70-redis php70-intl php70-opcache php70-fpm php70-xdebug php70-mbstring -y

EXPOSE 80
EXPOSE 443

ADD ./conf/httpd.conf /etc/httpd/conf/httpd.conf:ro
ADD ./ssl/* /etc/httpd/ssl/*:ro
ADD ./conf.d/*.conf /etc/httpd/conf.d/*.conf:ro

RUN service redis start

COPY start_script.sh start_script.sh

RUN ["chmod", "+x", "start_script.sh"]
CMD ./start_script.sh