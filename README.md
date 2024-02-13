# SARA SHIELD ROS

## Local INSTALLATION
### Requirements
This repo requires `ros-noetic`. We recommend `catkin-tools`:
```
sudo apt-get install python3-catkin-tools
```

Additionally, install `libfranka` and `franka-ros`:
```
sudo apt install ros-noetic-libfranka ros-noetic-franka-ros
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

## Alternative: Installation using DOCKER
```
./build-docker.bash
./run-docker.bash
```

##  Usage
- With Simulation
    ```
    roslaunch franka_sara_shield_controller panda.launch x:=-0.5 world:=/opt/ros/noetic/share/franka_gazebo/world/stone.sdf headless:=true
    ```

- On Real Robots:
    ```
    roslaunch franka_sara_shield_controller panda.launch x:=-0.5 world:=/opt/ros/noetic/share/franka_gazebo/world/stone.sdf gazebo:=false
    ```

- To run only sara-shield (without any controller), run 
    ```
    roscore
    ```
    and in a seperate window
    ```
    rosrun franka_sara_shield_controller sara_shield_node
    ```