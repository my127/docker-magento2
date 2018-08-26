FROM php:7.1-fpm-alpine

WORKDIR /app

RUN apk --update add \
    bash shadow iproute2 supervisor freetype libjpeg-turbo libpng libxml2 libmcrypt libxslt icu \
    autoconf g++ make freetype-dev libjpeg-turbo-dev libpng-dev openssl-dev libxml2-dev libmcrypt-dev libxslt-dev icu-dev \
  && docker-php-ext-install mcrypt xsl intl pdo_mysql soap zip bcmath \
  && docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install gd \
  && apk del \
    autoconf g++ make freetype-dev libjpeg-turbo-dev libpng-dev openssl-dev libxml2-dev libmcrypt-dev libxslt-dev icu-dev \
  && rm -rf /var/cache/apk/*
