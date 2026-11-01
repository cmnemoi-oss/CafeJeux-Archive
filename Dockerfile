FROM php:8.4-apache

# Apache tourne entièrement sous www-data, d'où le port 8080.
RUN a2enmod rewrite \
    && sed -i 's/^Listen 80$/Listen 8080/' /etc/apache2/ports.conf \
    && sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8080>/' /etc/apache2/sites-available/000-default.conf \
    && chown www-data:www-data /var/run/apache2 /var/lock/apache2

# Le code appartient à root : Apache (www-data) le lit sans pouvoir le modifier ni rien y ajouter,
# alors que l'image de base ouvre /var/www/html en écriture à tous (1777).
COPY . /var/www/html/
RUN chown root:root /var/www/html && chmod 755 /var/www/html

USER www-data
