# Utiliser l'image officielle PHP avec Apache
FROM php:8.2-apache

# Installer les extensions PHP nécessaires
RUN docker-php-ext-install pdo pdo_mysql

# Activer le module mod_rewrite pour Laravel
RUN a2enmod rewrite

# Copier tous les fichiers du projet dans /var/www/html
COPY . /var/www/html

# Définir les permissions correctes
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Modifier le VirtualHost d'Apache pour que la racine soit /public
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
