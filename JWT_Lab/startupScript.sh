#!/bin/bash
CONTAINER_NAME="jwt-lab"
IMAGE_NAME="jwt-lab"
NETWORK_NAME="bridge"

start_container() {
    echo "Iniciando el contenedor Docker \"$CONTAINER_NAME\"..."

    echo "Construyendo la imagen Docker \"$IMAGE_NAME\"..."
    if ! docker build -t $IMAGE_NAME . >/dev/null 2>&1; then
        echo "Error: No se pudo construir la imagen Docker \"$IMAGE_NAME\"." >&2
        exit 1
    fi

    echo "Iniciando el contenedor..."
    if ! docker run -d --rm --name $CONTAINER_NAME --network $NETWORK_NAME $IMAGE_NAME >/dev/null 2>&1; then
        echo "Error: No se pudo iniciar el contenedor \"$CONTAINER_NAME\"." >&2
        exit 1
    fi

    CONTAINER_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_NAME 2>/dev/null)
    if [ -z "$CONTAINER_IP" ]; then
        echo "Error: No se pudo obtener la IP del contenedor \"$CONTAINER_NAME\"." >&2
        stop_container
        exit 1
    fi
    echo ""
    echo "-------------------------------------------------- "
    echo ""
    echo "Desplegado 1 host en $CONTAINER_IP"
    echo "Ataca la aplicación web y consigue la flag "
    echo "Buena suerte!"
    echo ""
    echo "-------------------------------------------------- "
    echo ""
    echo "Machine made by dpmcyber :) "
    echo "More about me: https://dpmcyber.com "

}

stop_container() {
    echo "Deteniendo el contenedor Docker \"$CONTAINER_NAME\"..."

    if ! docker ps --filter "name=$CONTAINER_NAME" --format "{{.Names}}" | grep -w $CONTAINER_NAME >/dev/null; then
        echo "El contenedor \"$CONTAINER_NAME\" no está en ejecución."
    else
        if ! docker stop $CONTAINER_NAME >/dev/null 2>&1; then
            echo "Error: No se pudo detener el contenedor \"$CONTAINER_NAME\"." >&2
            exit 1
        fi
        echo "El contenedor \"$CONTAINER_NAME\" se ha detenido correctamente."
    fi

    echo "Eliminando la imagen Docker \"$IMAGE_NAME\"..."
    if docker image inspect $IMAGE_NAME >/dev/null 2>&1; then
        if ! docker rmi $IMAGE_NAME >/dev/null 2>&1; then
            echo "Error: No se pudo eliminar la imagen Docker \"$IMAGE_NAME\"." >&2
            exit 1
        fi
        echo "La imagen Docker \"$IMAGE_NAME\" se ha eliminado correctamente."
    else
        echo "La imagen Docker \"$IMAGE_NAME\" no existe."
    fi
}

case $1 in
    start)
        start_container
        ;;
    stop)
        stop_container
        ;;
    *)
        echo "Uso: $0 {start|stop}"
        exit 1
        ;;
esac
