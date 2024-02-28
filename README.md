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
Define the path to the configuration files:
```
cd ..
echo "export SARA_SHIELD_CONFIG_PATH=$(pwd)/src/franka_sara_shield_controller/config" >> ~/.bashrc
```

## DOCKER
./build-docker.bash
./run-docker.bash

##  Usage gazebo
```
roslaunch franka_sara_shield_controller panda.launch x:=-0.5 world:=/opt/ros/noetic/share/franka_gazebo/world/stone.sdf headless:=true
```

##  Usage real robot
Launch the real robot setup with:
```
roslaunch franka_sara_shield_controller sara_shield_impedance_controller.launch robot_ip:=172.16.0.2 load_gripper:=true robot:=fr3 server:=192.168.1.2
```
```
roslaunch franka_sara_shield_controller motion.launch
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
### Grip objects
rostopic pub /franka_gripper/grasp/goal franka_gripper/GraspActionGoal "header:
  seq: 0
  stamp:
    secs: 0
    nsecs: 0
  frame_id: ''
goal_id:
  stamp:
    secs: 0
    nsecs: 0
  id: ''
goal:
  width: 0.0
  epsilon:
    inner: 0.0001
    outer: 0.0001
  speed: 0.02
  force: 10.0"

Parameters:
  - width: doesn't make a difference really. Set `width: 0.0` for close and `width: 1.0` for open.
  - speed: `0.02` is quite slow, `0.1` is quite fast. 
  - force: `0.01` is soft. `0.1` is medium. 


### Set the SaRA shield mode
```
rostopic pub /sara_shield/shield_mode std_msgs/String "data: 'SSM'"
```
Choose between:
  - `SSM`: Robot stops for human. (Speed and separation monitoring)
  - `PFL`: Robot slows down for human. (Power and force limiting)
  - `OFF`: Robot is in Cartesian impedance control mode (and is slowed down significantly).

### Tune Cartesian impedance controller
```
rosrun rqt_reconfigure rqt_reconfigure
```

### Communication with main workstation
On this machine, define the rosmaster uri
```
export ROS_MASTER_URI=http://10.42.0.69:11311
```
Do exactly the same on the other machine. Make sure your ip setup is correct, so that the IP is pingable.