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

sudo apt install -y fontconfig
sudo apt install unzip

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

sudo apt install -y fzf
#sudo apt install -y eza
brew install eza
sudo apt install -y bat
sudo apt-get install -y ripgrep
sudo apt-get install -y fuse libfuse2

# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
# chmod u+x nvim.appimage
# ./nvim.appimage

sudo apt install -y fish
sudo apt install -y zoxide

sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

sudo apt install -y nodejs
sudo apt-get install npm -y
sudo apt install python3 -y
sudo apt install python3.10-venv -y

sudo rm -r ~/.config/nvim
git clone https://github.com/NvChad/NvChad --branch v2.0 ~/.config/nvim --depth 1

curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo sh -s -- -y

. "$HOME/.cargo/env"
#source "$HOME/.cargo/env.fish"

sudo rm -r ~/.config/nvim/lua/custom
sudo rm ~/.config/fish/config.fish
sudo rm ~/.config/starship.toml
sudo rm -r ~/.omnisharp

ln -sf ~/dotfiles/.omnisharp ~/.omnisharp
ln -s ~/dotfiles/.config/nvim/lua/custom ~/.config/nvim/lua/custom
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua

#fish
chsh -s $(which fish)

#zsh
#zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
