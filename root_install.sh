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
echo "Install basic packages..."
pacman -S acpi ifplugd neovim openssh pass rsync sudo wpa_actiond wpa_supplicant zsh tmux make pkgconf gcc libxft
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

echo "Everything is ready, you can now unhook ethernet and finish your config as your new user ($USER)."
