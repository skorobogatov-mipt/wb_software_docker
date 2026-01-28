# wget $WORKSPACE_DOWNLOAD_LINK -O robot_software.zip
# unzip -q robot_software.zip -d /root/workspace
# rm -r robot_software.zip
mkdir /root/workspace/log
source /opt/ros/humble/setup.bash
# rm -rf /root/workspace/install
colcon build
source /root/workspace/install/setup.bash
export ROS_LOG_DIR=/root/workspace/log
ros2 launch olympiad_env olympiad.launch.py &
ros2 run solution_python solution & # Закомментируй меня, если хочешь запустить решение вручную
wait

