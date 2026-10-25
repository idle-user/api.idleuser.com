FROM php:8.4.27-fpm

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update \
    && apt-get install --no-install-recommends --fix-missing --yes \
        git \
        libzip-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install zip mysqli pdo pdo_mysql

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/api/

COPY docker-entrypoint.sh /docker-entrypoint.d/

RUN chmod +x /docker-entrypoint.d/docker-entrypoint.sh
