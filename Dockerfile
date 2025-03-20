# Utiliser l'image PHP avec Apache
FROM php:8.2-apache

# Installer les extensions PHP et les outils nécessaires
RUN apt-get update && apt-get install -y unzip git curl libpq-dev libzip-dev \
    && docker-php-ext-install pdo pdo_mysql

# Installer PHP-FPM
RUN apt-get install -y php8.2-fpm

# Activer mod_rewrite pour Laravel
RUN a2enmod rewrite

# Copier tous les fichiers dans /var/www/html
COPY . /var/www/html

# Définir /var/www/html comme répertoire de travail
WORKDIR /var/www/html

# Définir les permissions correctes
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Installer les dépendances de Laravel
RUN composer install --no-dev --optimize-autoloader

# Générer le fichier .env et la clé Laravel
RUN cp .env.example .env && php artisan key:generate

# Modifier Apache pour pointer vers /public
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Configurer Apache pour utiliser PHP-FPM
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Exposer le port 80
EXPOSE 80

# Lancer Apache et PHP-FPM
CMD service apache2 start && php-fpm -D && apache2-foreground
