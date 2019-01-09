# Script to deploy a fresh install easily

# Get dir from where the script is located
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Submodules initialization
git submodule update --init --recursive

# Executable scripts/binaries
ln -fs $BASEDIR/bin/* ~/bin/

# Git
ln -fs $BASEDIR/git/gitconfig ~/.gitconfig

# Zsh
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install spaceship zsh theme
ln -fs $BASEDIR/spaceship-prompt/spaceship.zsh-theme $ZSH/custom/themes/spaceship.zsh-theme

ln -fs $BASEDIR/zsh/zshrc ~/.zshrc
ln -fs $BASEDIR/zsh/zshenv ~/.zshenv
#ln -fs $BASEDIR/zsh/zprofile ~/.zprofile

# Tmux
ln -fs $BASEDIR/tmux/tmux.conf ~/.tmux.conf
