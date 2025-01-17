# JWT Exploitation Lab

Este laboratorio está diseñado para practicar y aprender sobre la explotación de vulnerabilidades en JSON Web Tokens (JWT). El entorno incluye una aplicación web vulnerable desplegada en un contenedor Docker.

## Requisitos previos

Docker: Asegúrate de que Docker esté instalado y configurado correctamente en tu sistema.

Sistema operativo: Cualquier sistema compatible con Docker (Windows, Linux, macOS).

## Configuración

1. Construir y desplegar el laboratorio

Para iniciar el laboratorio, utiliza el siguiente comando en la terminal:
```
chmod +x startupScript.sh
./startupScript.sh start
```
Este comando realizará lo siguiente:

Construirá la imagen Docker desde el Dockerfile.

Desplegará el contenedor y te proporcionará la dirección IP asignada.

2. Detener y limpiar el laboratorio

Para detener y eliminar el laboratorio, ejecuta:
```
./startupScript.sh stop
```
Esto detendrá el contenedor y eliminará la imagen Docker creada.

## Acceso al laboratorio

Una vez desplegado, se mostrará la IP del contenedor en la consola. Accede al laboratorio desde tu navegador web:

URL: http://<IP_DEL_CONTENEDOR>:5000

¡Empieza a explorar y atacar la aplicación para encontrar la flag!

## Objetivo

El objetivo es explotar las vulnerabilidades en el manejo de JWT para obtener acceso a recursos restringidos dentro de la aplicación web.

## Uso de herramientas recomendadas

Para facilitar la explotación, puedes utilizar herramientas como:

jwt.io: Para decodificar y analizar tokens JWT.

Burp Suite: Para interceptar y modificar peticiones.

CyberChef: Para firmar o manipular tokens JWT.

Hashcat: Para intentar crackear claves débiles.


### Autor

Creado por dpmcyber.

Más información: dpmcyber.com
