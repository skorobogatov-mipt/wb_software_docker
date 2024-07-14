wget $WORKSPACE_DOWNLOAD_LINK -O robot_software.zip
unzip -q robot_software.zip -d /root/workspace
rm -r robot_software.zip
mkdir /root/workspace/log
source /root/workspace/install/setup.bash
export ROS_LOG_DIR=/root/workspace/log
ros2 launch controller motion_task.launch
