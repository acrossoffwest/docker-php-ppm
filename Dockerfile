FROM acrossoffwest/docker-php-fpm:master

MAINTAINER Yurij Karpov <acrossoffwest@gmail.com>

RUN apk update

RUN apk --no-cache add php8-cgi

RUN install-php-extensions pcntl

ARG version=^2.2.2
ARG http_version=^2.0.6
RUN mkdir /ppm && cd /ppm && composer require php-pm/php-pm:${version} && composer require --with-all-dependencies php-pm/httpkernel-adapter:${http_version}



COPY ./supervisor /etc/supervisor
COPY config.json /ppm/config.json
COPY ppm /usr/local/sbin/php-ppm
RUN chmod +x /usr/local/sbin/php-ppm
