FROM nginx:1.10
ADD ./nginx.conf /etc/nginx/nginx.conf:ro
ADD ./conf.d/cakephp.conf /etc/nginx/conf.d/cakephp.conf
