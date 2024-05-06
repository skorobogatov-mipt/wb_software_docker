# robot_software_docker

1. __Build docker container:__

    `./build_docker.sh`

2. __Add mount to workspace dir on your laptop in `run_container.sh`:__

    `--mount type=bind,source="PATH_TO_WORKSPACE_DIR",target=/root/workspace \`

    __Example__
    
    ```
    cat run_container.sh
    ```
    >... \
    >docker run -it --rm \
    >--name $container_name \
    >-e DISPLAY=${DISPLAY} \
    >-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    >--mount type=bind,source="$(pwd)",targset=/root/user_logs \
    >__PASTE MOUNTING HERE__ \
    >--network host starkit/robot_software /bin/bash \
    >...

3. __Run Container:__

    `sudo ./run_container.sh`

4. __Start publisher of ik_walk:__

    `root@your_laptop:~/# cd workspace` \
    `root@your_laptop:~/workspace/# colcon build` \
    `root@your_laptop:~/workspace/# source install/setup.bash` \
    `root@your_laptop:~/workspace/# ros2 run controller publisher`

5. __Start listener to robot's cameras:__

    `root@your_laptop:~/# cd workspace` \
    `root@your_laptop:~/workspace/# colcon build` \
    `root@your_laptop:~/workspace/# source install/setup.bash` \
    `root@your_laptop:~/workspace/# ros2 run controller listener`
    
