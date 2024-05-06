# Dockerfile to run MIPT2023 robot controlling framework
FROM ros:humble-perception-jammy

# Update package index
RUN apt update

# Install python
RUN apt install -qqy python3 python3-pip

# Install pybullet
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir pybullet 

# Install libs to correctly run pybullet OpenGL GUI inside docker
RUN apt install -qqy libglu1-mesa-dev    

# Install other python dependencies
#RUN pip install --no-cache-dir numpy matplotlib scipy pyqt5
RUN pip install --no-cache-dir numpy matplotlib scipy

# Install PyQt
RUN apt install -qqy python3-pyqt5

# Install robotpkg
RUN apt install -qqy lsb-release curl
RUN mkdir -p /etc/apt/keyrings
RUN curl http://robotpkg.openrobots.org/packages/debian/robotpkg.asc \
 | tee /etc/apt/keyrings/robotpkg.asc
RUN echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/robotpkg.asc] http://robotpkg.openrobots.org/packages/debian/pub $(lsb_release -cs) robotpkg" \
 | tee /etc/apt/sources.list.d/robotpkg.list
RUN apt update

# Configure env for robotpkg
ENV PATH /opt/openrobots/bin:$PATH
ENV PKG_CONFIG_PATH /opt/openrobots/lib/pkgconfig:$PKG_CONFIG_PATH
ENV LD_LIBRARY_PATH /opt/openrobots/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH /opt/openrobots/lib/python3.10/site-packages:$PYTHONPATH
ENV CMAKE_PREFIX_PATH /opt/openrobots:$CMAKE_PREFIX_PATH

# Install required robotpkg packages
RUN apt install -qqy robotpkg-py310-pinocchio
RUN apt install -qqy robotpkg-py310-ndcurves
#RUN apt install -qqy robotpkg-py310-tsid # Do not install vanilla tsid - build it from source instead

# Install TSID prerequisites
RUN apt install -qqy robotpkg-eiquadprog coinor-libipopt-dev git cmake

RUN apt install -y ros-humble-test-msgs ros-humble-moveit ros-humble-vision-msgs ros-humble-xacro \
    ros-humble-ament-cmake-nose ros-humble-nav2-costmap-2d ros-humble-rviz2 ros-humble-gazebo-msgs ros-humble-control-msgs
RUN apt install -y ros-humble-controller-interface ros-humble-dwb-critics ros-humble-control-toolbox \
    ros-humble-controller-manager libsuitesparse-dev ros-humble-libg2o ros-humble-transmission-interface 
RUN apt install -y libceres-dev ros-humble-tf-transformations ros-humble-demo-nodes-cpp ros-humble-soccer-vision-2d-msgs \
    ros-humble-soccer-vision-3d-msgs
RUN pip install transforms3d opencv-contrib-python
# Configure env for ROS_PACKAGE_PATH from copied repos to be able to correctly load URDF
WORKDIR /root
ENV ROS_PACKAGE_PATH "$ROS_PACKAGE_PATH:/root/workspace/src"
ENV LOG_PATH "/root/user_logs"




