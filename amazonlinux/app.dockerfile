FROM amazonlinux

RUN yum update -y \
    && yum install epel-release -y \
    && yum-config-manager --enable epel \
    && yum --enablerepo=epel install redis bash-completion -y \
    && yum install curl net-tools htop vim httpd24 wget lsof mod24_ssl mod24_fcgid \
        php70 php70-cli php70-mysqlnd php70-redis php70-intl php70-opcache php70-fpm php70-xdebug php70-mbstring -y

EXPOSE 80
EXPOSE 443

ADD ./conf/httpd.conf /etc/httpd/conf/httpd.conf:ro
ADD ./ssl-certificates/ /etc/httpd/ssl-certificates/
ADD ./conf.d/ /etc/httpd/conf.d/

COPY start_script.sh start_script.sh

RUN ["chmod", "+x", "start_script.sh"]
CMD ./start_script.sh