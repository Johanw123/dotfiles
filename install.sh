#!/bin/bash

if fc-list | grep -q -i "FiraCode"; then
    echo "FiraCode font found!"
else
    echo "FiraCode font not found"
    echo "[-] Download fonts [-]"
    echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
    unzip FiraCode.zip -d ~/.fonts
    fc-cache -fv
    echo "done!"
fi

#https://github.com/wslutilities/wslu?tab=readme-ov-file
# sudo apt install wslu

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/h2s/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install eza
brew install fzf
brew install bat
brew install bat-extras
brew install git-delta
brew install gh
brew postinstall gcc

ln -sf ~/dotfiles/.omnisharp ~/.omnisharp
ln -s ~/dotfiles/kickstart.nvim ~/.config/nvim
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig


#check for root
UID=$(id -u)
if [ x$UID != x0 ] 
then
    #Beware of how you compose the command
    printf -v cmd_str '%q ' "$0" "$@"
    exec sudo su -c "$cmd_str"
fi

./install_admin.sh