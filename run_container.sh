# Allow client connections to x server from any host
xhost +

container_name=robot_workspace

if [ "$( docker container inspect -f '{{.State.Status}}' $container_name )" == "running" ];
then 
    echo "Connected to existed $container_name container"
    docker exec -it $container_name /bin/bash
else
    # Run container
    docker run -it --rm \
    --name $container_name \
    -e DISPLAY=${DISPLAY} \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -e WORKSPACE_DOWNLOAD_LINK=https://storage.yandexcloud.net/platform-test-s3/robot_software.zip \
    --mount type=bind,source="$(pwd)/../wb-software-workspace",target=/root/workspace \
    --ipc="host" --network host starkit/robot_software /bin/bash #/root/entrypoint.sh
    # --mount type=bind,source="$(pwd)/../robot_software_workspace",target=/root/workspace \
fi


