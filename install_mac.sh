#!/bin/bash

#ln -sf ~/.dot_files/linux/gemrc ~/.gemrc
#ln -sf ~/.dot_files/linux/gtkrc-2.0.mine ~/.gtkrc-2.0.mine
#ln -sf ~/.dot_files/linux/i3 ~/.i3
#ln -sf ~/.dot_files/linux/irbrc ~/.irbrc
#ln -sf ~/.dot_files/linux/p10k.zsh ~/.p10k.zsh
#ln -sf ~/.dot_files/linux/screenlayout ~/.screenlayout
#ln -sf ~/.dot_files/linux/tmux/tmux.conf ~/.tmux.conf
#ln -sf ~/.dot_files/linux/Xmodmap ~/.Xmodmap
#ln -sf ~/.dot_files/linux/zinit/zshrc ~/.zshrc
#ln -sf ~/.dot_files/linux/gh-packer ~/.gh-packer
#ln -sf ~/.dot_files/extras/cava ~/.config/cava
#ln -sf ~/.dot_files/linux/compton ~/.config/compton
#ln -sf ~/.dot_files/linux/kitty ~/.config/kitty
#ln -sf ~/.dot_files/linux/lazygit ~/.config/jesseduffield/
#ln -sf ~/.nv-ide ~/.config/nvim
#ln -sf ~/.dot_files/linux/polybar ~/.config/polybar
#ln -sf ~/.dot_files/linux/ranger ~/.config/ranger
#ln -sf ~/.dot_files/linux/rofi ~/.config/rofi
#ln -sf ~/.dot_files/linux/wezterm.lua ~/.wezterm.lua
#ln -sf ~/.dot_files/linux/tool-versions ~/.tool-versions
#ln -sf ~/.dot_files/linux/rvm_default.gems ~/.default-gems
#ln -sf ~/.dot_files/linux/nvm_default_packages ~/.default-npm-packages
#ln -sf ~/.dot_files/linux/asdfrc ~/.asdfrc
#ln -sf ~/.v-ide ~/.vim
#ln -sf ~/.v-ide/vimrc ~/.vimrc
#ln -sf ~/.dot_files/linux/nvm_default_packages ~/.nvm/default-packages
#mkdir ~/.tmux
#git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


#https://github.com/wslutilities/wslu?tab=readme-ov-file
# sudo apt install wslu

if ! command -v zap &> /dev/null
then
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
fi

if ! command -v brew &> /dev/null
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew install --cask wezterm
brew install fzf
brew install eza
brew install bat
brew install ripgrep
brew install fuse libfuse2
brew install wget
brew install node



#dev 
brew install --cask tiled

# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
# chmod u+x nvim.appimage
# ./nvim.appimage

brew install fish
brew install zoxide
brew install starship

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo sh -s -- -y

brew tap austinliuigi/brew-neovim-nightly https://github.com/austinliuigi/brew-neovim-nightly.git
brew install neovim-nightly

# git clone https://github.com/NvChad/NvChad --branch v2.0 ~/.config/nvim --depth 1

sudo rm -r ~/.config/nvim/lua/custom
sudo rm ~/.config/fish/config.fish
sudo rm ~/.config/starship.toml
sudo rm -r ~/.omnisharp
sudo rm ~/.zshrc
sudo rm ~/.wezterm.lua

ln -sf ~/dotfiles/.omnisharp ~/.omnisharp
# ln -s ~/dotfiles/.config/nvim/lua/custom ~/.config/nvim/lua/custom
ln -s ~/dotfiles/kickstart.nvim/ ~/.config/nvim
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/.gitconfig-macos ~/.gitconfig-macos

if ! command -v dscl . -read ~/ UserShell | grep "fish" &> /dev/null
then
  #fish
  sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
  chsh -s $(which fish)
fi

#zsh
#zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

if atsutil fonts -list | grep -q -i "FiraCode"; then
    echo "FiraCode font found!"
else
    echo "FiraCode font not found"
    echo "[-] Download fonts [-]"
    echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
    unzip FiraCode.zip -d /Library/Fonts/
    fc-cache -fv
    echo "done!"
fi

