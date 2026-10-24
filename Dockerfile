FROM php:8.4-apache

RUN a2enmod rewrite

# Le code appartient à root : Apache (www-data) le lit sans pouvoir le modifier.
COPY . /var/www/html/
