# from https://backdropcms.org/requirements
FROM php:8.3-apache

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y --no-install-recommends libzip-dev libonig-dev libpng-dev libjpeg-dev libpq-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-jpeg=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql zip

WORKDIR /var/www/html

# https://github.com/backdrop/backdrop/releases
ENV BACKDROP_VERSION=1.31.0
ENV BACKDROP_MD5=0204d479a71ac692039a9f7b1e50409f

RUN curl -fSL "https://github.com/backdrop/backdrop/archive/refs/tags/${BACKDROP_VERSION}.tar.gz" -o backdrop.tar.gz \
  && echo "${BACKDROP_MD5} *backdrop.tar.gz" | md5sum -c - \
  && tar -xz --strip-components=1 -f backdrop.tar.gz \
  && rm backdrop.tar.gz \
  && chown -R www-data:www-data sites files

# Add custom entrypoint to set BACKDROP_SETTINGS correctly
COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
