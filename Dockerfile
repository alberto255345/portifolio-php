# Use a imagem oficial do PHP como base
FROM php:7.4-apache
# Instale as extensões PHP necessárias
RUN docker-php-ext-install pdo pdo_mysql
# Copie os arquivos da sua aplicação para o diretório de trabalho no contêiner
COPY . /var/www/html/
# Install Composer
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install project dependencies
RUN composer install

# Configure o VirtualHost do Apache para a aplicação CakePHP
RUN echo "<VirtualHost *:80>\n\ DocumentRoot /var/www/html/webroot\n\ <Directory 
    /var/www/html/webroot>\n\
        AllowOverride All\n\ Require all granted\n\ </Directory>\n\ 
</VirtualHost>" > /etc/apache2/sites-available/000-default.conf
# Habilite o módulo rewrite do Apache
RUN a2enmod rewrite
# Use a imagem oficial do MySQL como serviço de banco de dados Certifique-se de 
# configurar adequadamente as variáveis de ambiente, como MYSQL_ROOT_PASSWORD, 
# etc. Exemplo: https://hub.docker.com/_/mysql Exponha a porta 80 para acesso à 
# aplicação
EXPOSE 80
# Comando para iniciar o Apache (pode variar dependendo da imagem do PHP que você 
# está usando)
CMD ["apache2-foreground"]
