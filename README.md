# ROS_single_line_install

**이 명령어는 Ubuntu 18.04에 ROS melodic을 설치하는 것을 기준으로 수정되었습니다.**

**실행 시 terminator가 설치됩니다.**
**실행 시 Ubuntu 기본 패키지 다운로드 서버를 US에서 KR로 변경합니다.**


    wget https://raw.githubusercontent.com/kemjensak/ROS_single_line_install/main/install_ros_melodic.sh && sed -i -e 's/\r$//' install_ros_melodic.sh && chmod 755 ./install_ros_melodic.sh && bash ./install_ros_melodic.sh

