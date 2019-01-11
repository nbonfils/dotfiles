# Script to deploy a fresh install easily


# Get dir from where the script is located
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# Submodules initialization
git submodule update --init --recursive


# Executable scripts/binaries
ln -fs $BASEDIR/bin/* ~/bin/


# GIT
ln -fs $BASEDIR/git/gitconfig ~/.gitconfig


# ZSH
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install spaceship zsh theme
ln -fs $BASEDIR/spaceship-prompt/spaceship.zsh-theme $ZSH/custom/themes/spaceship.zsh-theme

# Link config files
ln -fs $BASEDIR/zsh/zshrc ~/.zshrc
ln -fs $BASEDIR/zsh/zshenv ~/.zshenv
#ln -fs $BASEDIR/zsh/zprofile ~/.zprofile

# Refresh
source ~/.zshrc


# TMUX
ln -fs $BASEDIR/tmux/tmux.conf ~/.tmux.conf


# ST
# Build and install
ln -fs $BASEDIR/st/config.h $BASEDIR/st-git/config.h
cd $BASEDIR/st-git
sudo make clean install
cd -


# XORG
ln -fs $BASEDIR/xorg/xinitrc $HOME/.xinitrc
ln -fs $BASEDIR/xorg/Xresource $HOME/.Xresource
ln -fs $BASEDIR/xorg/Xmodmap $HOME/.Xmodmap
