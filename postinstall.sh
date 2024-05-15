#!/bin/bash

## Set color values
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
PURPLE='\033[0;35m'
ENDCOLOR="\e[0m"

echo -e "${PURPLE}

• ▌ ▄ ·. ▄▄▄     ▄▄▄ .▄▄▄  ▄▄▄        ▄▄▄  
·██ ▐███▪▀▄ █·   ▀▄.▀·▀▄ █·▀▄ █·▪     ▀▄ █·
▐█ ▌▐▌▐█·▐▀▀▄    ▐▀▀▪▄▐▀▀▄ ▐▀▀▄  ▄█▀▄ ▐▀▀▄ 
██ ██▌▐█▌▐█•█▌   ▐█▄▄▌▐█•█▌▐█•█▌▐█▌.▐▌▐█•█▌
▀▀  █▪▀▀▀.▀  ▀ ▀  ▀▀▀ .▀  ▀.▀  ▀ ▀█▄▀▪.▀  ▀
${ENDCOLOR}"

echo -e "${RED}Ensure your system is already operational before starting. ${ENDCOLOR}"

echo -e "${BLUE}Running Arch basic setup..${ENDCOLOR}"

## This directory is going to store everything during the setup. 
echo -e "Making directory to store files.."
if [ ! -d ~/Script_install ]; then
    mkdir ~/Script_install
fi
cd ~/Script_install

## Installing yay-bin 
echo -e "${BLUE}:: Installing Yay (AUR Helper)${ENDCOLOR}"

## Cloning and building the AUR
echo "Downloading yay-bin from AUR.."
sudo pacman -S --nonconfirm git
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin

echo "Building package.."
makepkg -si

## Returning to the original directory
cd ~/Script_install

echo -e "${BLUE}:: Installing Feral Gamemode${ENDCOLOR}"
git clone https://github.com/FeralInteractive/gamemode.git
cd gamemode
git checkout 1.8 # omit to build the master branch
./bootstrap.sh

## Returning to the original directory
cd ~/Script_install



# Installing Nvidia Drivers and utils
# Run the command and capture the output to check if nvidia setup is needed or not
output=$(pacman -Q | grep nvidia)

# Check if there is some output
if [ -n "$output" ]; then
  echo "Nvidia Setup is Already Done!"
else
  echo -e "${BLUE}:: Installing NVIDIA Packages and dependancies ...${ENDCOLOR}"
  sudo pacman -S --nonconfirm acpi_call-dkms mesa-demos xorg-xrandr xf86-video-intel nvidia nvidia-utils lib32-nvidia-utils nvidia-settings nvidia-prime qbittorrent smplayer smplayer-themes smplayer-skins base-devel linux-headers bluez bluez-utils nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader meson systemd dbus libinih lib32-vkd3d vkd3d mono wine-mono --needed
  
  yay -S --noconfirm update-grub
  
  ## Blacklisting open source nvidia driver 
  echo -e "${BLUE}::Blacklisting nouveau drivers ...${ENDCOLOR}"
  sudo echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
  
  echo -e "${BLUE}::Adding Nvidia-Pacman Hook...${ENDCOLOR}"
  wget https://raw.githubusercontent.com/korvahannu/arch-nvidia-drivers-installation-guide/main/nvidia.hook
  sudo mkdir /etc/pacman.d/hooks
  sudo mv ./nvidia.hook /etc/pacman.d/hooks/
  
  echo -e "${RED}>>> PLEASE UPDATE GRUB FILE : ${ENDCOLOR}"
  echo -e "${GREEN}
  sudo nano /etc/default/grub 
  ${ENDCOLOR}"
  echo -e "${PURPLE}###############################################${ENDCOLOR}"
	## echo some commands here
	echo -e "
GRUB_DEFAULT='0'
GRUB_TIMEOUT='3'
GRUB_DISTRIBUTOR='EndeavourOS'
GRUB_CMDLINE_LINUX_DEFAULT='nowatchdog nvme_load=YES resume=UUID=dd10800d-bdbe-4d88-b67a-b939f0b49722 loglevel=3 rd.driver.blacklist=nouveau nvidia-drm.modeset=1'
"
  echo -e "${PURPLE}###############################################${ENDCOLOR}"
  echo -e "${RED}>>> AFTER THIS UPDATE GRUB USING : ${ENDCOLOR}"
  echo -e "${PURPLE}###############################################${ENDCOLOR}"
  	## echo some commands here
  	echo -e "sudo update-grub"
  echo -e "${PURPLE}###############################################${ENDCOLOR}"
fi

echo -e "${BLUE}::Adding USer to GROUPS ...${ENDCOLOR}"
sudo usermod -aG input $USER
sudo usermod -a -G users $USER


yay -S extension-manager-git touchegg supergfxctl touche protonup-qt qt5-styleplugins google-chrome
sudo systemctl enable touchegg.service
sudo systemctl start touchegg
sudo systemctl enable supergfxd.service --now

echo -e "${BLUE}::Setting GTK2 Enviromental Variables ...${ENDCOLOR}"
sudo echo "QT_QPA_PLATFORMTHEME=gtk2" >> /etc/environment 



## Basic tools that I think should be installed by default on any machine. 
echo -e "${BLUE}:: Installing Packages..${ENDCOLOR}"
sudo pacman -S --noconfirm curl wget fish tar unzip unrar p7zip

## ## Flatpak support
## echo -e "${BLUE}Installing and adding flatpak support..${ENDCOLOR}"
## sudo pacman -S --noconfirm flatpak 


## Installing fonts

echo -e "${GREEN}:: Installing fonts...${ENDCOLOR}"

sudo pacman --noconfirm -S noto-fonts-cjk noto-fonts-extra noto-fonts-emoji ttf-dejavu


echo -e "${GREEN}

·▄▄▄▄         ▐ ▄ ▄▄▄ .
██▪ ██ ▪     •█▌▐█▀▄.▀·
▐█· ▐█▌ ▄█▀▄ ▐█▐▐▌▐▀▀▪▄
██. ██ ▐█▌.▐▌██▐█▌▐█▄▄▌
▀▀▀▀▀•  ▀█▄▀▪▀▀ █▪ ▀▀▀ 
${ENDCOLOR}"

# For Mounting NTFS hard disk
# sudo mount -t ntfs /dev/sda2 /mnt/ntfs1

