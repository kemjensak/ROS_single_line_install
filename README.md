
# ROS_single_line_install



    wget https://raw.githubusercontent.com/kemjensak/ROS_single_line_install/main/install_ros_melodic.sh && sed -i -e 's/\r$//' install_ros_melodic.sh && chmod 755 ./install_ros_melodic.sh && bash ./install_ros_melodic.sh


**This command is modified for installing ROS melodic on Ubuntu 18.04.**

### This command will....
- install ros melodic.
- install terminator.
- install packages to use ros on python3.
- set permission to use serial devices.
- set stored time as local time. (resolve time sync problem with windows)
- change default package download server from US to KR.
