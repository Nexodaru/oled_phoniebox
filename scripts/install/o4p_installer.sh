#!/bin/bash
# Colors: \e[36m=Cyan M ; \e[92m=Light green ; \e[91m=Light red ; \e[93m=Light yellow ; \e[31m=green ; \e[0m=Default ; \e[33m=Yellow ; \e[31m=Red

repo="https://github.com/Nexodaru/phoniebox_oled_and_utility"
branch="master"

nocolor='\e[0m'
red="\e[1;91m"
cyan="\e[1;36m"
yellow="\e[1;93m"
green="\e[1;92m"
installPath="/home/pi/oled_phoniebox"

function install_python_package {
    package_name=$1
  	i=0
  	let lLen="$lineLen"-"${#package_name}"
  	echo -n -e "   --> $package_name:"
  	while [ "$i" -lt "$lLen" ]
  	do
  		let i+=1
  		echo -n -e " "
  	done
  	pipInstalled=`sudo pip3 show ${package_name}`
  	if [ "$pipInstalled" = "" ]
  	then
  		sudo pip3 install ${package_name}  > /dev/null 2>&1
  		pipInstalled=`sudo pip3 show ${package_name}`
  		if [ "$pipInstalled" = "" ]
  		then
  			echo -e "${red}failed${nocolor}"
  		else
  			echo -e "${green}done${nocolor}"
  		fi
  	else
  		echo -e "${green}already installed${nocolor}"
  	fi
}

clear
echo -e "////////////////////////////////////////////////////////////////////////////////////////////////////////////////"
echo -e "///${cyan}                                                                                                          ${nocolor}///";
echo -e "///${cyan}        ██████╗ ██╗     ███████╗██████╗     ██████╗ ██╗███████╗██████╗ ██╗      █████╗ ██╗   ██╗          ${nocolor}///";
echo -e "///${cyan}       ██╔═══██╗██║     ██╔════╝██╔══██╗    ██╔══██╗██║██╔════╝██╔══██╗██║     ██╔══██╗╚██╗ ██╔╝          ${nocolor}///";
echo -e "///${cyan}       ██║   ██║██║     █████╗  ██║  ██║    ██║  ██║██║███████╗██████╔╝██║     ███████║ ╚████╔╝           ${nocolor}///";
echo -e "///${cyan}       ██║   ██║██║     ██╔══╝  ██║  ██║    ██║  ██║██║╚════██║██╔═══╝ ██║     ██╔══██║  ╚██╔╝            ${nocolor}///";
echo -e "///${cyan}       ╚██████╔╝███████╗███████╗██████╔╝    ██████╔╝██║███████║██║     ███████╗██║  ██║   ██║             ${nocolor}///";
echo -e "///${cyan}        ╚═════╝ ╚══════╝╚══════╝╚═════╝     ╚═════╝ ╚═╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝             ${nocolor}///";
echo -e "///${cyan}                                                                                                          ${nocolor}///";
echo -e "///${cyan}   ███████╗ ██████╗ ██████╗     ██████╗ ██╗  ██╗ ██████╗ ███╗   ██╗██╗███████╗██████╗  ██████╗ ██╗  ██╗   ${nocolor}///";
echo -e "///${cyan}   ██╔════╝██╔═══██╗██╔══██╗    ██╔══██╗██║  ██║██╔═══██╗████╗  ██║██║██╔════╝██╔══██╗██╔═══██╗╚██╗██╔╝   ${nocolor}///";
echo -e "///${cyan}   █████╗  ██║   ██║██████╔╝    ██████╔╝███████║██║   ██║██╔██╗ ██║██║█████╗  ██████╔╝██║   ██║ ╚███╔╝    ${nocolor}///";
echo -e "///${cyan}   ██╔══╝  ██║   ██║██╔══██╗    ██╔═══╝ ██╔══██║██║   ██║██║╚██╗██║██║██╔══╝  ██╔══██╗██║   ██║ ██╔██╗    ${nocolor}///";
echo -e "///${cyan}   ██║     ╚██████╔╝██║  ██║    ██║     ██║  ██║╚██████╔╝██║ ╚████║██║███████╗██████╔╝╚██████╔╝██╔╝ ██╗   ${nocolor}///";
echo -e "///${cyan}   ╚═╝      ╚═════╝ ╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝   ${nocolor}///";
echo -e "///${cyan}                                                                                                          ${nocolor}///";
echo -e "////////////////////////////////////////////////////////////////////////////////////////////////////////////////"
echo -e "///                                                                                                          ///"
echo -e "///${cyan}                               https://github.com/splitti/oled_phoniebox                                  ${nocolor}///"
echo -e "///                                                                                                          ///"
echo -e "////////////////////////////////////////////////////////////////////////////////////////////////////////////////"
echo -e ""
echo -e "${red}Please notice:${nocolor} This script will install all needed components for the OLED-Display (Format 128 X 64px) with"
echo -e "SH1106- or SSD1306-Controller. A preinstallation of the jukebox4kids or similiar (MPC) will be needed."
echo -e " "
if [ -d "/home/pi/RPi-Jukebox-RFID" ]; then
	echo -e "${green}RPi-Jukebox-RFID seems to be installed${nocolor}"
	echo -e " "
else
	echo -e "${red}RPi-Jukebox-RFID is missing! Please install necessarily.${nocolor}"
	echo -e " "
fi

echo -e "Do you want to install this OLED-Display-Service?"
echo -e " "
options=("Install" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Install")
            break
            ;;

        "Quit")
            exit
            ;;
        *) echo -e "invalid option $REPLY";;
    esac
done

clear
echo -e "////////////////////////////////////////////////////////////////////"
echo -e "///${cyan}   Please choose your display controller type:                ${nocolor}///"
echo -e "////////////////////////////////////////////////////////////////////"
echo -e ""
echo -e "Which type of OLED-Controller should be installed (needed for the "
echo -e "Service-Startup):?"
echo -e " "
options=("ssd1306" "sh1106" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "ssd1306")
            controller="ssd1306"
            break
            ;;
        "sh1106")
            controller="sh1106"
            break
            ;;
        "Quit")
            exit
            ;;
        *) echo -e "Invalid option $REPLY";;
    esac
done

clear
echo -e "////////////////////////////////////////////////////////////////////"
echo -e "///${cyan}   Please choose your display brightness:                     ${nocolor}///"
echo -e "////////////////////////////////////////////////////////////////////"
echo -e ""
echo -e "Choose your initial setting for brightness, you can change it later:"
echo -e " "
options=("1 dark" "2 normal" "3 bright" "4 very bright" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "1 dark")
			echo -e ""
            contrast="0"
			echo -e " "
            break
            ;;
        "2 normal")
            echo -e ""
			contrast="85"
			echo -e " "
            break
            ;;
        "3 bright")
            echo -e ""
			contrast="170"
			echo -e " "
            break
            ;;
        "4 very bright")
            echo -e ""
			contrast="255"
			echo -e " "
            break
            ;;
        "Quit")
            exit
            ;;
        *) echo -e "Invalid option $REPLY";;
    esac
done

clear

cd
echo -e "////////////////////////////////////////////////////////////////////"
echo -e "///${cyan}   Check/Install Prerequirements:                             ${nocolor}///"
echo -e "////////////////////////////////////////////////////////////////////"
echo -e " "
echo -e "Do you want to start the installation of needed packages?"
echo -e " "
options=("Install" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Install")
            break
            ;;

        "Quit")
            exit
            ;;
        *) echo -e "invalid option $REPLY";;
    esac
done
echo -e ""
echo -e "Starting installation-process, please wait, some steps taking"
echo -e "minutes, especially the luma-Packages..."
echo -e ""
echo -e -n "   --> Update Sources:          "
sudo apt -qq update > /dev/null 2>&1
echo -e "${green}done${nocolor}"
echo -e ""
echo -e "Install packages..."

lineLen=24
packages=(git python3 build-essential python3-dev python3-pip libjpeg-dev i2c-tools) # python3-smbus i2c-tools  libfreetype6-dev   python3-pygame libtiff5)
for p in "${packages[@]}"; do
	i=0
	echo -n -e "   --> $p:"
    let lLen="$lineLen"-"${#p}"
    while [ "$i" -lt "$lLen" ]
    do
		let i+=1
		echo -n -e " "
	done
    installer=`sudo dpkg -s ${p}  2>&1 | grep Status | grep installed`
    if [ "$installer" = "" ]
    then
		installer=`sudo apt -qq -y install ${p} > /dev/null 2>&1`
		installer=`sudo dpkg -s ${p} 2>&1 | grep Status | grep installed`
		if [ "$installer" = "" ]
		then
			echo -e "${red}failed${nocolor}"
		else
			echo -e "${green}done${nocolor}"
		fi
	else
		echo -e "${green}already installed${nocolor}"
	fi
done
lumaPackages=(luma.core luma.oled netifaces)
for p in "${lumaPackages[@]}"; do
  install_python_package "$p"
done

additionalPythonPackages=(pillow python-mpd2 RPi.GPIO)
for p in "${additionalPythonPackages[@]}"; do
  install_python_package "$p"
done

echo -e ""
echo -e "Enable I2C..."
if grep -q 'i2c-bcm2708' /etc/modules; then
  echo -e "   --> i2c-bcm2708 module:      ${green}already exists${nocolor}"
else
  echo 'i2c-bcm2708' | sudo tee -a /etc/modules > /dev/null 2>&1
  echo -e "   --> i2c-bcm2708 module:      ${green}activated${nocolor}"
fi
if grep -q 'i2c-dev' /etc/modules; then
  echo -e "   --> i2c-dev module:          ${green}already exists${nocolor}"
else
  echo 'i2c-dev' | sudo tee -a /etc/modules > /dev/null 2>&1
  echo -e "   --> i2c-dev module:          ${green}activated${nocolor}"
fi
if grep -q '^dtparam=i2c1=on' /boot/config.txt; then
  echo -e "   --> i2c1 boot-parameter:     ${green}already set${nocolor}"
else
  echo '' | sudo tee -a /boot/config.txt > /dev/null 2>&1
  echo 'dtparam=i2c1=on' | sudo tee -a /boot/config.txt > /dev/null 2>&1
  echo -e "   --> i2c1 boot-parameter:     ${green}set${nocolor}"
fi
if grep -q '^dtparam=i2c_arm=on' /boot/config.txt; then
  echo -e "   --> i2c_arm boot-parameter:  ${green}already set${nocolor}"
else
  echo 'dtparam=i2c_arm=on' | sudo tee -a /boot/config.txt > /dev/null 2>&1
  echo -e "   --> i2c_arm boot-parameter:  ${green}set${nocolor}"
fi
if [ -f /etc/udev/rules.d/99-i2c.rules ]; then
  if grep -q '^SUBSYSTEM=="i2c-dev", TAG+="systemd"' /etc/udev/rules.d/99-i2c.rules; then
    echo -e "   --> i2c dev dependency:      ${green}already set${nocolor}"
  else
    echo 'SUBSYSTEM=="i2c-dev", TAG+="systemd"' | sudo tee  /etc/udev/rules.d/99-i2c.rules > /dev/null 2>&1
    echo -e "   --> i2c dev dependency:      ${green}set${nocolor}"
  fi
else
  echo 'SUBSYSTEM=="i2c-dev", TAG+="systemd"' | sudo tee  /etc/udev/rules.d/99-i2c.rules > /dev/null 2>&1
  echo -e "   --> i2c dev dependency:      ${green}set${nocolor}"
fi
if grep -q '^dtparam=i2c_arm_baudrate=400000' /boot/config.txt; then
  echo -e "   --> i2c arm_baudrate:        ${green}already set${nocolor}"
else
  echo 'dtparam=i2c_arm_baudrate=400000' | sudo tee -a /boot/config.txt > /dev/null 2>&1
  echo -e "   --> i2c arm_baudrate:        ${green}set${nocolor}"
fi


if [ -f /etc/modprobe.d/raspi-blacklist.conf ]; then
  sudo sed -i 's/^blacklist spi-bcm2708/#blacklist spi-bcm2708/' /etc/modprobe.d/raspi-blacklist.conf
  sudo sed -i 's/^blacklist i2c-bcm2708/#blacklist i2c-bcm2708/' /etc/modprobe.d/raspi-blacklist.conf
fi

echo -e ""
read -n 1 -s -r -p "Press any key to continue"

clear
echo -e "////////////////////////////////////////////////////////////////////"
echo -e "///${cyan}   Installing Service:                                        ${nocolor}///"
echo -e "////////////////////////////////////////////////////////////////////"
echo -e ""
echo -e "Repository:       ${green}${repo}${nocolor}"
echo -e "Branch:           ${green}${branch}${nocolor}"
echo -e "Install Path:     ${green}${installPath}${nocolor}"
echo -e "Controler Type:   ${green}${controller}${nocolor}"
echo -e "Contrast:         ${green}${contrast}${nocolor}"
echo -e ""
echo -e -n "   --> Delete old Service:                "
sudo service oled_phoniebox stop > /dev/null 2>&1
sudo systemctl disable /etc/systemd/oled_phoniebox.service > /dev/null 2>&1
sudo rm /etc/systemd/oled_phoniebox.service > /dev/null 2>&1
echo -e "${green}Done${nocolor}"
echo -e ""
echo -e -n "   --> Delete old Repository:             "
sudo rm -R ${installPath} > /dev/null 2>&1
echo -e "${green}Done${nocolor}"
echo -e ""
echo -e -n "   --> Clone oled_phoniebox Repository:   "

git clone ${repo} --branch ${branch} ${installPath} > /dev/null 2>&1
echo -e "${green}Done${nocolor}"
echo -e ""
echo -e -n "   --> Write Config-File:                 "
sudo cp ${installPath}/templates/conf.template ${installPath}/oled_phoniebox.conf > /dev/null
sudo sed -i -e "s:<contrastvalue>:${contrast}:g" ${installPath}/oled_phoniebox.conf> /dev/null
sudo sed -i -e "s:<controllervalue>:${controller}:g" ${installPath}/oled_phoniebox.conf> /dev/null
echo -e "${green}Done${nocolor}"
echo -e ""
echo -e -n "   --> Installing Service:                "
sudo chown -R pi:pi ${installPath} > /dev/null
sudo cp ${installPath}/templates/service.template /etc/systemd/oled_phoniebox.service > /dev/null
sudo chown root:root /etc/systemd/oled_phoniebox.service > /dev/null 2>&1
sudo chmod 644 /etc/systemd/oled_phoniebox.service > /dev/null 2>&1
sudo sed -i -e "s:<PATH>:${installPath}:g" /etc/systemd/oled_phoniebox.service > /dev/null
sudo systemctl daemon-reload > /dev/null 2>&1
sudo systemctl enable /etc/systemd/oled_phoniebox.service > /dev/null 2>&1
sudo service oled_phoniebox restart > /dev/null 2>&1
echo -e "${green}Done${nocolor}"
echo -e ""
echo -e -n "   --> Set Permissons:                    "
sudo chmod 755 /home/pi/oled_phoniebox/scripts/toggle_display/toggle_display.sh > /dev/null 2>&1
echo -e "${green}Done${nocolor}"
echo -e ""
read -n 1 -s -r -p "Press any key to continue"
clear

echo -e ""
echo -e "/////////////////////////////////////////////////////////////////////////////////////////////////////////"
echo -e "///                                                                                                   ///"
echo -e "///   ${green}██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗      █████╗ ████████╗██╗ ██████╗ ███╗   ██╗   ${nocolor}///";
echo -e "///   ${green}██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║   ${nocolor}///";
echo -e "///   ${green}██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║   ${nocolor}///";
echo -e "///   ${green}██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║   ${nocolor}///";
echo -e "///   ${green}██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║   ${nocolor}///";
echo -e "///   ${green}╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝   ${nocolor}///";
echo -e "///                                                                                                   ///";
echo -e "///   ${green} ██████╗ ██████╗ ███╗   ███╗██████╗ ██╗     ███████╗████████╗███████╗                           ${nocolor}///";
echo -e "///   ${green}██╔════╝██╔═══██╗████╗ ████║██╔══██╗██║     ██╔════╝╚══██╔══╝██╔════╝                           ${nocolor}///";
echo -e "///   ${green}██║     ██║   ██║██╔████╔██║██████╔╝██║     █████╗     ██║   █████╗                             ${nocolor}///";
echo -e "///   ${green}██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══╝     ██║   ██╔══╝                             ${nocolor}///";
echo -e "///   ${green}╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ███████╗███████╗   ██║   ███████╗                           ${nocolor}///";
echo -e "///   ${green} ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚══════╝╚══════╝   ╚═╝   ╚══════╝                           ${nocolor}///";
echo -e "///                                                                                                   ///"
echo -e "/////////////////////////////////////////////////////////////////////////////////////////////////////////"
echo -e ""
echo -e "If this is a fresh installation, a reboot is required..."
echo -e ""
echo -e "Do you want to reboot now?"
echo -e " "
options=("Reboot" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Reboot")
            sudo reboot
            ;;

        "Quit")
            exit
            ;;
        *) echo -e "invalid option $REPLY";;
    esac
done
