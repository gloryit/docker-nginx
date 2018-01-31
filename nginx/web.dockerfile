FROM nginx:latest
ADD ./nginx.conf /etc/nginx/nginx.conf:ro
ADD ./conf.d/ /etc/nginx/conf.d/
