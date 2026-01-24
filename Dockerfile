# Dockerfile to run MIPT2023 robot controlling framework
FROM ros:humble-ros-core-jammy

# Install packages that lead ik_walk lib to correct execution
RUN apt update && apt install -qqy software-properties-common && add-apt-repository ppa:ubuntu-toolchain-r/test && \
    rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt && rm -rf /var/cache/debconf

RUN apt update && apt install -qqy --only-upgrade libstdc++6 && \
    rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt && rm -rf /var/cache/debconf

RUN apt update && apt install -qqy \
python3 \
python3-pip \
unzip \
wget \
git \
cmake \
python3-setuptools \
python3.10-tk \
libgl1-mesa-glx \
libosmesa6 \
python3-bloom \
python3-colcon-common-extensions \
python3-colcon-mixin \
python3-rosdep \
python3-vcstool \
&& \
    rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt && rm -rf /var/cache/debconf

RUN pip install --no-cache-dir --upgrade pip

# install essential ros packages
RUN apt update && apt install -qqy ros-humble-vision-opencv ros-humble-image-transport && \
rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt && rm -rf /var/cache/debconf

# Install python packages for simulation process 
RUN pip install --no-cache-dir \
        transforms3d \
        opencv-contrib-python \
        websockets \
        scipy \
        pin \
        pin-pink \
        qpsolvers[open_source_solvers] \
        meshcat \
        meshcat_shapes

# fix installation numpy>=2.0.0
# RUN pip install --no-cache-dir numpy==1.26.4

ENV MUJOCO_GL "osmesa"
RUN pip install --no-cache-dir mujoco

# install qt5 for imshow
RUN apt update && apt install -qqy python3-pyqt5 && \
rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt && rm -rf /var/cache/debconf

ADD entrypoint.sh /root/entrypoint.sh

# Configure env for ROS_PACKAGE_PATH from copied repos to be able to correctly load URDF
WORKDIR /root/workspace

# ENTRYPOINT [ "bash", "/root/entrypoint.sh" ]



