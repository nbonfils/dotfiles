# Script to deploy a fresh install easily

# Get dir from where the script is located
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Submodules initialization
git submodule update --init --recursive

# Executable scripts/binaries
ln -s $BASEDIR/bin/* ~/bin/

# Git
ln -s $BASEDIR/git/gitconfig ~/.gitconfig

# Zsh
ln -s $BASEDIR/zsh/zshrc ~/.zshrc
ln -s $BASEDIR/zsh/zshenv ~/.zshenv
#ln -s $BASEDIR/zsh/zprofile ~/.zprofile
ln -s $BASEDIR/zsh/liquidprompt ~/.liquidpromptrc

# Tmux
ln -s $BASEDIR/tmux/tmux.conf ~/.tmux.conf
