# Script to deploy a fresh install easily
# Run this as root, before running install.sh script

# Get dir from where the script is located
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#TODO update mirrors

# Pacman hook to update systemd-boot
echo "Setting up pacman hooks..."
mkdir -p /etc/pacman.d/hooks
ln -s $BASEDIR/etc/systemd-boot.hook /etc/pacman.d/hooks/
echo "Done!"

# Update the system and install the basic packages
echo "Get the latest update..."
pacman -Syu
echo "Done!"

PACKAGES=`cat $BASEDIR/packages.txt`
echo "Install basic packages..."
echo "Choose 1 and 1 when asked."
pacman -S $PACKAGES
echo "Done!"

# Create the user
USER=nature
echo "Creating the user..."
useradd -m -G wheel -s /usr/bin/zsh $USER 
echo "Done!"
echo "Set up password for $USER..."
passwd $USER
echo "Done!"

# Allow wheel group to use sudo
echo "Editing sudoers file..."
sed -i '/wheel ALL=(ALL) NOPASSWD: ALL/s/^#//g' /etc/sudoers
echo "Done!"

# Configure networking
echo "Enable automatic wifi switch and ethernet hotplug..."
systemctl enable netctl-ifplugd@enp0s31f6.service
systemctl enable netctl-auto@wlp4s0.service
echo "Done!"

# Configuring keyboard for Xorg system-wide
echo "Creating /etc/X11/xorg.conf.d/00-keyboard.conf to persist keybopard conf..."
localectl --no-convert set-x11-keymap ch thinkpad fr
echo "Done!"

# Better looking fonts
echo "Improving fonts rendering..."
ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
sed -i '/export FREETYPE_PROPERTIES/s/^#//g' /etc/profile.d/freetype2.sh
ln -s $BASEDIR/etc/local.conf /etc/fonts/local.conf
echo "Done!"

echo "Everything is ready, you can now unhook ethernet and finish your config as your new user ($USER)."
