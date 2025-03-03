FROM ubuntu:22.04  

# Instalar dependencias necesarias
RUN apt update && apt install -y apache2 php libapache2-mod-php php-mysql curl unzip && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Configurar Apache
RUN echo "ServerName crm.grintic.com" >> /etc/apache2/apache2.conf

# Configurar VirtualHost
RUN echo '<VirtualHost *:80>\n\
    ServerName crm.grintic.com\n\
    DocumentRoot /var/www/html\n\
    <Directory /var/www/html>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
    ErrorLog ${APACHE_LOG_DIR}/error.log\n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite

# Copiar archivos de Perfex CRM
COPY . /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto HTTP
EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
