# from https://backdropcms.org/requirements
FROM php:8.3-fpm

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libzip-dev libonig-dev libpng-dev libjpeg-dev libpq-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-jpeg=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql zip

WORKDIR /var/www/html

# https://github.com/backdrop/backdrop/releases
ENV BACKDROP_VERSION=1.29.0
ENV BACKDROP_MD5=0c358d1961e3e8b3be56cf1c2dc197f5

RUN curl -fSL "https://github.com/backdrop/backdrop/archive/${BACKDROP_VERSION}.tar.gz" -o backdrop.tar.gz \
	&& echo "${BACKDROP_MD5} *backdrop.tar.gz" | md5sum -c - \
	&& tar -xz --strip-components=1 -f backdrop.tar.gz \
	&& rm backdrop.tar.gz \
	&& chown -R www-data:www-data sites files

# Add custom entrypoint to set BACKDROP_SETTINGS correctly
COPY docker-entrypoint.sh /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
