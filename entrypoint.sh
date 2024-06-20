wget $WORKSPACE_DOWNLOAD_LINK -O robot_software.zip
unzip -q robot_software.zip -d /root/workspace
rm -r robot_software.zip
source /root/workspace/install/setup.bash
ros2 launch controller motion_task.launch
