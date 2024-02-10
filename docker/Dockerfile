# TODO: base this on custom container 
FROM arturolaurenzi/xbot2_focal_base_nvidia:latest

USER root
SHELL ["/bin/bash", "-ic"]
RUN sudo apt-get update
RUN sudo apt install ros-noetic-libfranka ros-noetic-franka-ros python3-catkin-tools nano -y

USER user
SHELL ["/bin/bash", "-ic"]

WORKDIR /home/user

# installing eigen
RUN wget "https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.zip"
RUN unzip eigen-3.4.0.zip
RUN rm eigen-3.4.0.zip
RUN mkdir eigen-3.4.0/build 
WORKDIR eigen-3.4.0/build 
RUN cmake ..
USER root
RUN sudo make -j6 install
WORKDIR /home/user
USER user
RUN export EIGEN3_INCLUDE_DIR="/usr/local/include/eigen3/"
RUN rm eigen-3.4.0 -rf
RUN echo 'export EIGEN3_INCLUDE_DIR="/usr/local/include/eigen3/"' >> /home/user/.bashrc

# installing safety_shield
RUN git clone --recurse-submodules https://github.com/manuelvogel12/temporary_sara_shield_mirror.git sara-shield
RUN mkdir sara-shield/safety_shield/build
WORKDIR sara-shield/safety_shield/build
RUN cmake ..
USER root
RUN sudo make -j8 install
USER user

WORKDIR /home/user

# installing franka_sara_shield_controller
RUN mkdir catkin_ws
RUN mkdir catkin_ws/src

WORKDIR catkin_ws/src
RUN git clone https://github.com/manuelvogel12/franka_sara_shield_controller.git
RUN git clone https://github.com/manuelvogel12/rviz_plugin_sara_shield.git
WORKDIR ..
RUN catkin init
RUN catkin build
USER user
RUN source devel/setup.bash

RUN echo 'echo "USAGE:"' >> /home/user/.bashrc
RUN echo 'echo "run simulation....: roslaunch franka_sara_shield_controller panda.launch x:=-0.5 world:=/opt/ros/noetic/share/franka_gazebo/world/stone.sdf headless:=true"' >> /home/user/.bashrc

# set ownership to user for the whole home folder
RUN chown -R user /home/user/catkin_ws 

# change user, copy start script (launches gazebo and gzweb)
USER user
