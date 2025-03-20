# Utiliser l'image PHP avec Apache
FROM php:8.2-apache

# Installer Composer et les extensions nécessaires
RUN apt-get update && apt-get install -y unzip git curl libpq-dev libzip-dev \
    && docker-php-ext-install pdo pdo_mysql \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Activer mod_rewrite pour Laravel
RUN a2enmod rewrite

# Copier tous les fichiers dans /var/www/html
COPY . /var/www/html

# Définir /var/www/html comme répertoire de travail
WORKDIR /var/www/html

# Installer les dépendances de Laravel
RUN composer install --no-dev --optimize-autoloader

# Définir les permissions correctes
RUN chown -R www-data:www-data storage bootstrap/cache

# Modifier Apache pour pointer vers /public
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Exposer le port 80
EXPOSE 80

# Lancer Apache
CMD ["apache2-foreground"]
