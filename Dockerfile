FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
        curl \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libonig-dev \
        libzip-dev \
        libmcrypt-dev

RUN pecl install mcrypt-1.0.3 \
        && docker-php-ext-enable mcrypt \
        && docker-php-ext-install -j$(nproc) iconv mbstring mysqli pdo_mysql zip \
        && docker-php-ext-configure gd --with-freetype --with-jpeg \
        && docker-php-ext-install -j$(nproc) gd

# RUN pecl install swoole \
#         && docker-php-ext-enable swoole

# RUN cd /tmp && git clone https://github.com/swoole/swoole-src.git && \
#     cd swoole-src && \
#     git checkout v4.6.4 && \
#     phpize  && \
#     ./configure --enable-openssl && \
#     make && make install

# RUN touch /usr/local/etc/php/conf.d/swoole.ini && \
#     echo 'extension=swoole.so' > /usr/local/etc/php/conf.d/swoole.ini

# RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64
# RUN chmod +x /usr/local/bin/dumb-init

# RUN apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install vim -y && \
    apt-get install openssl -y && \
    apt-get install libssl-dev -y && \
    apt-get install wget -y && \
    apt-get install git -y && \
    apt-get install procps -y && \
    apt-get install htop -y

RUN cd /tmp && git clone https://github.com/swoole/swoole-src.git && \
    cd swoole-src && \
    git checkout v4.6.4 && \
    phpize  && \
    ./configure --enable-openssl && \
    make && make install

RUN touch /usr/local/etc/php/conf.d/swoole.ini && \
    echo 'extension=swoole.so' > /usr/local/etc/php/conf.d/swoole.ini

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64
RUN chmod +x /usr/local/bin/dumb-init

RUN apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y libpq-dev
RUN cd /tmp && git clone https://github.com/swoole/ext-postgresql.git \
    && cd ext-postgresql && \
    phpize && \
    ./configure && \
    make && make install

RUN touch /usr/local/etc/php/conf.d/swoole_postgresql.ini && \
    echo 'extension=swoole_postgresql.so' > /usr/local/etc/php/conf.d/swoole_postgresql.ini

RUN docker-php-ext-install pdo pdo_pgsql pgsql
