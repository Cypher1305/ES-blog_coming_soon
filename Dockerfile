# Utiliser l'image officielle PHP avec Apache
FROM php:8.2-apache

# Installer les extensions et outils nécessaires
RUN apt-get update && apt-get install -y unzip git curl libpq-dev libzip-dev \
    && docker-php-ext-install pdo pdo_mysql \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Activer mod_rewrite pour Laravel
RUN a2enmod rewrite

# Copier les fichiers de l'application
COPY . /var/www/html

# Définir /var/www/html comme répertoire de travail
WORKDIR /var/www/html

# Définir les permissions correctes pour Laravel
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Installer les dépendances de Laravel
RUN composer install --no-dev --optimize-autoloader

# Générer le fichier .env et la clé Laravel
RUN cp .env.example .env && php artisan key:generate

# Modifier la config Apache pour pointer vers /public
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Nettoyer le cache Laravel
RUN php artisan config:clear && php artisan cache:clear

# Exposer le port 80
EXPOSE 80

# Lancer Apache et PHP-FPM
CMD service apache2 start && php-fpm -D && apache2-foreground
