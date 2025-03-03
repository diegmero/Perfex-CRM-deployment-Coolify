FROM ubuntu:22.04  

# Instalar dependencias necesarias
RUN apt update && apt install -y apache2 php libapache2-mod-php php-mysql curl unzip && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Configurar Apache
RUN echo "ServerName crm.grintic.com" >> /etc/apache2/apache2.conf
COPY crm.conf /etc/apache2/sites-available/crm.conf
RUN a2ensite crm.conf && a2enmod rewrite

# Copiar archivos de Perfex CRM
COPY . /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto HTTP
EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
