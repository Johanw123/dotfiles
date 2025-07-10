#!/bash
sudo rm ~/.omnisharp
sudo rm -r ~/.omnisharp
sudo rm -rf ~/.config/nvim
sudo rm ~/.config/fish/config.fish
sudo rm ~/.config/starship.toml
sudo rm -rf ~/.zshrc
sudo rm ~/.wezterm.lua
sudo rm ~/.gitconfig
sudo rm -rf ~/.config/hypr

sudo rm -r ~/.config/nvim
sudo rm -r ~/.cache/nvim
sudo rm -r ~/.local/share/nvim

sudo mkdir ~/.config
sudo mkdir ~/.config/fish

sudo ln -sf ~/dotfiles/.omnisharp ~/.omnisharp
sudo ln -s ~/dotfiles/kickstart.nvim ~/.config/nvim
sudo ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
sudo ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml
sudo ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
sudo ln -s ~/dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
sudo ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
sudo ln -s ~/dotfiles/git/.gitconfig-linux ~/.gitconfig-linux


sudo ln -s ~/dotfiles/kitty ~/.config
sudo ln -s ~/dotfiles/hypr ~/.config
sudo ln -s ~/dotfiles/hyprpanel/ ~/.config

sudo ln ~/dotfiles/Powershell/Microsoft.PowerShell_profile.ps1 ~/.config/powershell/Microsoft.PowerShell_profile.ps1
