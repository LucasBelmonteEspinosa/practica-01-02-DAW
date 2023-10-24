#!/bin/bash

#Para mostrar los comandos que se van ejecutando
set -x

# Esto es un comentario

echo "Esto es un texto"

# Actualizamos la lista de repositorios
apt update

# Actualizamos los paquetes del sistema

apt upgrade -y

# Instalamos el servidor web Apache

apt install apache2 -y


# Instalamos mysql Server

apt install mysql-server -y


apt install php libapache2-mod-php php-mysql -y

#Copiamos el archivo de configuración de apache

cp ../conf/000-default.conf /etc/apache2/sites-available

# Reiniciamos el servicio de Apache
systemctl restart apache2

# Cambiamos el usuario y el propietario del directorio /var/www/html

chown -R www-data:www-data /var/www/html