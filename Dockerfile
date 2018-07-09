FROM php:7.1-fpm

WORKDIR /app

EXPOSE 80
EXPOSE 443

RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
  && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
  && apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get -s dist-upgrade | grep "^Inst" | \
       grep -i securi | awk -F " " '{print $2}' | \
       xargs apt-get -qq -y --no-install-recommends install \
  \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq -y --no-install-recommends install \
     apt-transport-https \
     ca-certificates \
     libfreetype6-dev \
     libjpeg-dev \
     libpng-dev \
     libmcrypt-dev \
     libxslt1-dev \
     supervisor \
     nginx \
  \
  # confd \
  && curl -sSL -o /usr/local/bin/confd \
     https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 \
  && chmod +x /usr/local/bin/confd \
  \
  # php \
  && docker-php-ext-install mcrypt \
  && docker-php-ext-install xsl \
  && docker-php-ext-install intl \
  && docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/include/ \
    --with-freetype-dir=/usr/include/ \
    && docker-php-ext-install gd \
  && docker-php-ext-install pdo_mysql \
  && docker-php-ext-install soap \
  && docker-php-ext-install zip \
  && docker-php-ext-install bcmath \
  \
  # clean \
  && apt-get auto-remove -qq -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY root /
  
ENTRYPOINT ["/entrypoint.sh"]
