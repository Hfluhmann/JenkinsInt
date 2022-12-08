# README

## Despliegue directo:

Se debe instalar ruby y rails anteriormente para ejecutar el proyecto.
Las versiones utilizadas corresponden a Ruby 3.1.2 y Rails 7.0.4.
Para ejecutar la aplicación se debe realizar lo siguiente, dentro del directorio raiz del proyecto:
* Realizar las migraciones con el comando $rails db:migrate 

* Ejecutar la semilla con el comando $rails db:seed

* Correr el servidor con el comando $rails s

## Despliegue con Docker

Se necesita tener instalado [Docker](docker.com/products/docker-desktop/) y [Docker Compose](https://docs.docker.com/compose/install/)

Para hacer funcionar el contenedor con la app dentro se debe ejecutar el comando en la carpeta root del proyecto:

    docker-compose -f ./deploy/docker-compose.yml up --build

ese comando construirá el contenedor descargando la imagen, cargando todos los archivos, y finalmente correrá el servidor. Si no ocurren errores se debería ver en la consola que el servidor está corriendo.

Ahora, para que no quede ocupando la consola, lo detendremos y se ejecutará en modo *detach*. Para detenerlo basta con un `CTRL+C`. En caso que no funcione, en otra terminal en la carpeta del proyecto:

    docker-compose -f ./deploy/docker-compose.yml down

Para correrlo en modo detach, se usa el comando:

    docker-compose -f ./deploy/docker-compose.yml up -d

Mientras no se realicen cambios en el proyecto, basta con ese último comando para ejecutar el contenedor si ya está construído.

## Ingresar a la aplicación

Abrir navegador en localhost:3000 para acceder a la aplicación

## Pruebas

Realizar pruebas:
* How to run the test suite