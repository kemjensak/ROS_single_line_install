#!/bin/bash

echo "This script will install ros jazzy on your PC"
echo ""
echo "PRESS [ENTER] TO CONTINUE THE INSTALLATION"
echo "IF YOU WANT TO CANCEL, PRESS [CTRL] + [C]"
echo ""
echo ""
read

sudo apt update -y
sudo apt install locales -y
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

sudo apt install software-properties-common -y
sudo add-apt-repository universe -y
sudo apt update -y
sudo apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" # If using Ubuntu derivates use $UBUNTU_CODENAME
sudo apt install /tmp/ros2-apt-source.deb

sudo apt update -y
sudo apt upgrade -y
sudo apt install ros-dev-tools -y
sudo apt install ros-jazzy-desktop-full -y
sudo apt install ros-dev-tools -y
sudo apt install ros-jazzy-rqt-* -y

sudo apt install python3-vcstool

# timezone setting for dual boot windows 
timedatectl set-local-rtc 1 --adjust-system-clock

echo "[Initialize rosdep]"
sudo rosdep init
rosdep update 

sudo usermod -a -G dialout $USER
sudo usermod -a -G tty $USER
sudo ip link set lo multicast on

mkdir -p $HOME/colcon_ws/src
cd $HOME/colcon_ws
colcon build

sh -c "echo \"source /opt/ros/jazzy/setup.bash\" >> ~/.bashrc"
sh -c "echo \"source ~/colcon_ws/install/local_setup.bash\" >> ~/.bashrc"

sh -c "echo \"source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash\" >> ~/.bashrc"
sh -c "echo \"source /usr/share/vcstool-completion/vcs.bash\" >> ~/.bashrc"
sh -c "echo \"source /usr/share/colcon_cd/function/colcon_cd.sh\" >> ~/.bashrc"

sh -c "echo \"export _colcon_cd_root=~/colcon_ws\" >> ~/.bashrc"
sh -c "echo \"export ROS_DOMAIN_ID=0\" >> ~/.bashrc"
# sh -c "echo \"export ROS_LOCALHOST_ONLY=1\" >> ~/.bashrc"

sh -c "echo \"export RCUTILS_CONSOLE_OUTPUT_FORMAT='[{severity} {time}] [{name}]: {message} ({function_name}() at {file_name}:{line_number})'\" >> ~/.bashrc"
sh -c "echo \"export RCUTILS_COLORIZED_OUTPUT=1\" >> ~/.bashrc"
sh -c "echo \"export RCUTILS_LOGGING_USE_STDOUT=0\" >> ~/.bashrc"
sh -c "echo \"export RCUTILS_LOGGING_BUFFERED_STREAM=1\" >> ~/.bashrc"

sh -c "echo \"alias eb='nano ~/.bashrc'\" >> ~/.bashrc"
sh -c "echo \"alias sb='source ~/.bashrc'\" >> ~/.bashrc"
sh -c "echo \"alias cb='cd ~/colcon_ws && colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release --symlink-install'\" >> ~/.bashrc"
sh -c "echo \"alias cbs='colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release --symlink-install'\" >> ~/.bashrc"
sh -c "echo \"alias cbp='colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release --symlink-install --packages-select'\" >> ~/.bashrc"
sh -c "echo \"alias cbu='colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release --symlink-install --packages-up-to'\" >> ~/.bashrc"
sh -c "echo \"alias rd='rosdep install --from-paths src --ignore-src -r -y'\" >> ~/.bashrc"
sh -c "echo \"alias cw='cd ~/colcon_ws'\" >> ~/.bashrc"
sh -c "echo \"alias cs='cd ~/colcon_ws/src'\" >> ~/.bashrc"

source $HOME/.bashrc

echo "[Complete!!!]"
echo "Please open new terminal or type "source ~/.bashrc" to do further"
exit 0
