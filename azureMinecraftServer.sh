#!/bin/bash -i
#Creator: kxisxr
#Version: 1.0.1
greenColour="\x1B[0;32m\033[1m"
endColour="\033[0m\x1B[0m"
redColour="\x1B[0;31m\033[1m"
blueColour="\x1B[0;34m\033[1m"
yellowColour="\x1B[0;33m\033[1m"
purpleColour="\x1B[0;35m\033[1m"
turquoiseColour="\x1B[0;36m\033[1m"
grayColour="\x1B[0;37m\033[1m"

echo -e "${greenColour}""

▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
▒▒████▒▒▒▒████▒▒
▒▒████▒▒▒▒████▒▒
▒▒▒▒▒▒████▒▒▒▒▒▒
▒▒▒▒████████▒▒▒▒
▒▒▒▒████████▒▒▒▒
▒▒▒▒██▒▒▒▒██▒▒▒▒
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
                               _______ __                               ___ __   _______
.---.-.-----.--.--.----.-----.|   |   |__|.-----.-----.----.----.---.-.'  _|  |_|     __|.-----.----.--.--.-----.----.
|  _  |-- __|  |  |   _|  -__||       |  ||     |  -__|  __|   _|  _  |   _|   _|__     ||  -__|   _|  |  |  -__|   _|
|___._|_____|_____|__| |_____||__|_|__|__||__|__|_____|____|__| |___._|__| |____|_______||_____|__|  \___/|_____|__|

by kxisxr
@pixelbit131
""${endColour}"

echo -e "${blueColour}"'-----------------------------------------------------------------------------------------'"${endColour}"
echo -e ' '

 if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo -e "${redColour}"'Not running as root, Exiting...'"${endColour}\n"
    echo -e "${greenColour}"'Example:'"\n${endColour}""${grayColour}"'sudo su'"${endColour}"
    echo -e "${grayColour}"'root@MinecraftServer'"${endColour}" "${grayColour}"'./azureMinecraftServer.sh'"${endColour}\n"
    exit
fi

echo -e "${turquoiseColour}"'[1] 1.17'"${endColour}"
echo -e "${purpleColour}"'[2] 1.18 (experimental)'"${endColour}"
echo -e "${yellowColour}"'[3] 1.18.1'"${endColour}\n"
echo -e -n "${yellowColour}"'Version to install: '"${endColour}"
read -e version
echo -e ' '

usr=$(cat /etc/passwd | grep 1000 | tr ':' ' ' | awk '{print $1}')

echo -e "${greenColour}"'Adding the aliases... '"${endColour}"
echo "alias startServer='cd /home/$usr/azureMinecraftServer/server; java -Xmx6000M -Xms4000M -jar server.jar nogui'" >> ~/.bashrc
echo "alias kprocess='killall -s SIGKILL java'" >> ~/.bashrc
sleep 1

echo -e "${greenColour}"'Installing the jre... '"${endColour}"
apt-get install default-jre-headless -y >/dev/null 2>&1
sleep 1

echo -e "${greenColour}"'Adding java repository... '"${endColour}"
add-apt-repository ppa:linuxuprising/java -y >/dev/null 2>&1
sleep 1

echo -e "${greenColour}"'Installing openjdk 16... '"${endColour}"
apt-get install openjdk-16-jdk -y
sleep 1

clear

echo -e "${greenColour}"'Installing misc... '"${endColour}"
apt-get install unzip wget screen -y >/dev/null 2>&1
sleep 1

jversion=$(javac --version)
echo -e "${greenColour}"'Javac version:' $jversion"${endColour}"
sleep 1

mkdir server; cd server
echo -e "${greenColour}"'Downloading the minecraft launcher... '"${endColour}"

if [ $version -eq 1 ]
then
wget https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar >/dev/null 2>&1
elif [ $version -eq 3 ]
then
wget https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar > /dev/null 2>&1
else
wget https://launcher.mojang.com/v1/objects/3cf24a8694aca6267883b17d934efacc5e44440d/server.jar > /dev/null 2>&1
fi
sleep 1

echo -e "${greenColour}"'Initializing the server... '"${endColour}"
java -Xmx6000M -Xms4000M -jar server.jar nogui >/dev/null 2>&1
sleep 1

echo -e "${greenColour}"'Fixing the error... '"${endColour}"
sed -i 's/eula=false/eula=true/g' eula.txt
sleep 2

echo -e "\n${blueColour}"'--------------------------------------------------------------------------------------------------------'"${endColour}\n"
echo -e "${turquoiseColour}"'[!] IMPORTANT: Kill the Java process when you pause or quit the server with the command: '"${endColour}""${yellowColour}"'kprocess'"${endColour}"
echo -e "\n${blueColour}"'--------------------------------------------------------------------------------------------------------'"${endColour}\n"
echo -e "${greenColour}"'Re-initializing the server... '"${endColour}"

java -Xmx6000M -Xms4000M -jar server.jar nogui

source ~/.bashrc
exec bash
