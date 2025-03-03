FROM php:8.2-apache
RUN apt-get update && apt-get install -y \
    libzip-dev unzip \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libc-client-dev \
    libkrb5-dev \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install pdo_mysql zip mysqli imap \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && a2enmod rewrite \
    && echo "ServerName crm.grintic.com" >> /etc/apache2/apache2.conf
COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html
EXPOSE 80