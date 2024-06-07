# Allow client connections to x server from any host
xhost +

container_name=robot_workspace

if [ "$( docker container inspect -f '{{.State.Status}}' $container_name )" == "running" ] 
then 
echo "Connected to existed $container_name container"
docker exec -it $container_name /bin/bash
fi


# Run container
docker run -it --rm \
--name $container_name \
-e DISPLAY=${DISPLAY} \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
--mount type=bind,source="$(pwd)",target=/root/user_logs \
--network my-net starkit/robot_software /bin/bash


