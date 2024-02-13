# SARA SHIELD ROS

## Local INSTALLATION
### Requirements
This repo requires `ros-noetic`. We recommend `catkin-tools`:
```
sudo apt-get install python3-catkin-tools
```

### Clone and build `sara-shield`
*Important* Do not put `sara-shield` in `sara_shield_ros/src/`! Put it anywhere else.
```
git clone --recurse-submodules -b build-imporvement-for-ros git@gitlab.lrz.de:cps-robotics/sara-shield.git
cd sara-shield/safety_shield
mkdir build && cd build && cmake .. && sudo make install -j8
```
Define the path to the configuration files:
```
cd ..
echo "export SARA_SHIELD_CONFIG_PATH=$(pwd)/config" >> ~/.bashrc
```
### Build ROS workspace
Clone this repo and build the workspace
```
git clone --recurse-submodules git@github.com:manuelvogel12/sara_shield_ros.git
cd sara_shield_ros
rosdep update
catkin init
catkin build
```
Add `source devel/setup.bash` to your `~/.bashrc`:
```
echo "source $(pwd)/devel/setup.bash" >> ~/.bashrc
```

## DOCKER
./build-docker.bash
./run-docker.bash

##  Usage gazebo
```
roslaunch franka_sara_shield_controller panda.launch x:=-0.5 world:=/opt/ros/noetic/share/franka_gazebo/world/stone.sdf headless:=true
```

##  Usage real robot
Each command should be executed in its own terminal:
```
roslaunch franka_sara_shield_controller sara_shield_impedance_controller.launch robot_ip:=172.16.0.2 load_gripper:=true robot:=fr3
```


### Send out desired joint pos
```
rostopic pub /sara_shield/goal_joint_pos std_msgs/Float32MultiArray "layout:
  dim:
  - label: ''
    size: 0
    stride: 0
  data_offset: 0
data:
- 0.0
- -0.78539
- 0.0
- -2.35619
- 0.0
- 1.5707
- 0.78539"
```
Two different configurations to test:
```
rostopic pub /sara_shield/goal_joint_pos std_msgs/Float32MultiArray "layout:
  dim:
  - label: ''
    size: 0
    stride: 0
  data_offset: 0
data:
- 1.0
- -1.0
- 0.5
- -1.35619
- 0.0
- 1.5707
- 0.78539"
```
```
rostopic pub /sara_shield/goal_joint_pos std_msgs/Float32MultiArray "layout:
  dim:
  - label: ''
    size: 0
    stride: 0
  data_offset: 0
data:
- -1.0
- -0.4 
- -0.5
- -2.0 
- 0.0
- 1.5707
- 0.78539"
```
