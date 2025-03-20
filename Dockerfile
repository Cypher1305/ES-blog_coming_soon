# Utiliser une image PHP avec Apache et PHP-FPM
FROM php:8.2-apache

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libpq-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_mysql pdo_sqlite zip

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Activer mod_rewrite et mod_fcgid pour PHP-FPM
RUN a2enmod rewrite \
    && a2enmod proxy_fcgi \
    && a2enconf php8.2-fpm

# Copier les fichiers de l'application dans le conteneur
COPY . /var/www/html

# Définir le répertoire de travail
WORKDIR /var/www/html

# Installer les dépendances de Laravel
RUN composer install --no-dev --optimize-autoloader

# Générer la clé d'application Laravel
RUN cp .env.example .env && php artisan key:generate

# Donner les bonnes permissions aux répertoires
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Configurer Apache pour pointer vers /public
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Exposer le port 80
EXPOSE 80

# Lancer Apache en mode foreground (en tant que processus principal)
CMD ["apache2-foreground"]
