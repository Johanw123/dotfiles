#!/bin/sh

user=johan

sudo rm /home/$user/.omnisharp
sudo rm -rf /home/$user/.omnisharp
sudo rm -rf /home/$user/.config/nvim
sudo rm /home/$user/.config/fish/config.fish
sudo rm /home/$user/.config/starship.toml
sudo rm -rf /home/$user/.zshrc
sudo rm /home/$user/.wezterm.lua
sudo rm /home/$user/.gitconfig
sudo rm -rf /home/$user/.config/hypr

sudo rm -rf /home/$user/.config/nvim
sudo rm -rf /home/$user/.cache/nvim
sudo rm -rf /home/$user/.local/share/nvim

sudo rm -rf "/home/$user/.config/kitty"
sudo rm -rf "/home/$user/.config/hypr"
sudo rm -rf "/home/$user/.config/hyprpanel"

#sudo mkdir ~/.config
#sudo mkdir ~/.config/fish

sudo ln -sf /home/$user/dotfiles/.omnisharp /home/$user/.omnisharp
sudo ln -s /home/$user/dotfiles/kickstart.nvim /home/$user/.config/nvim
sudo ln -s /home/$user/dotfiles/fish/config.fish /home/$user/.config/fish/config.fish
sudo ln -s /home/$user/dotfiles/starship/starship.toml /home/$user/.config/starship.toml
sudo ln -s /home/$user/dotfiles/zsh/.zshrc /home/$user/.zshrc
sudo ln -s /home/$user/dotfiles/wezterm/.wezterm.lua /home/$user/.wezterm.lua
sudo ln -s /home/$user/dotfiles/git/.gitconfig /home/$user/.gitconfig
sudo ln -s /home/$user/dotfiles/git/.gitconfig-linux /home/$user/.gitconfig-linux


sudo ln -snf /home/$user/dotfiles/kitty /home/$user/.config/kitty
sudo ln -snf /home/$user/dotfiles/hypr /home/$user/.config/hypr
sudo ln -snf /home/$user/dotfiles/hyprpanel/ /home/$user/.config/hyprpanel

sudo ln /home/$user/dotfiles/Powershell/Microsoft.PowerShell_profile.ps1 /home/$user/.config/powershell/Microsoft.PowerShell_profile.ps1
