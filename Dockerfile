FROM php:7.4-fpm
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt-get install --no-install-recommends --yes \
	git \
	libzip-dev
RUN docker-php-ext-install zip mysqli pdo pdo_mysql
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
WORKDIR /var/www/api/
CMD composer install && php-fpm
