# practica-01-02-DAW

# Empezamos con la base instalando lamp

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

# Creamos un archivo deploy

#!/bin/bash

#Para mostrar los comandos que se van ejecutando
set -x

# Esto es un comentario

echo "Esto es un texto"

# Actualizamos la lista de repositorios
apt update

# Actualizamos los paquetes del sistema

apt upgrade -y


# Además necesitamos un archivo .env con las variables de configuración

# Variables de configuración

>DB_NAME=aplicacion

>DB_USER=lamp_user

>DB_PASS=lamp_pass

# Importamos el archivo .env

>source .env

# Eliminamos instalaciones previas

>rm -rf /tmp/iaw-practica-lamp

# Clonamos el repositorio de la aplicación

>git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /tmp/iaw-practica-lamp

# Movemos el codigo fuente de la aplicación a /var/www/html

>mv /tmp/iaw-practica-lamp/src/* /var/www/html

# Configuramos el archivo config.php

>sed -i "s/database_name_here/$DB_NAME/" /var/www/html/config.php

>sed -i "s/username_here/$DB_USER/" /var/www/html/config.php

>sed -i "s/password_here/$DB_PASS/" /var/www/html/config.php

# Modificamos el nombre de la base de datos en el scrpit

>sed -i "s/lamp_db/$DB_NAME/" /tmp/iaw-practica-lamp/db/database.sql

# Importamos el script SQL de base de datos

>mysql -u root < /tmp/iaw-practica-lamp/db/database.sql

# Creamos el usuario de la base de datos y le asignamos privilegios
>mysql -u root <<< "DROP USER IF EXISTS $DB_USER@'%'";

>mysql -u root <<< "CREATE USER $DB_USER@'%' IDENTIFIED BY '$DB_PASS'";

>mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%'";

# Este sería el resultado final

![Resultado final interactivo](/imagen/resultado.png)