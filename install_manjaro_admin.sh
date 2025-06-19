

sudo pamac install base-devel --no-confirm

sudo pacman -Syu yay --noconfirm

sudo pacman -S code --noconfirm
sudo pacman -S github-cli --noconfirm
sudo pacman -S neovim --noconfirm

sudo pacman -S eza --noconfirm
sudo pacman -S fzf --noconfirm
sudo pacman -S bat --noconfirm
sudo pacman -S bat-extras --noconfirm
sudo pacman -S git-delta --noconfirm

sudo pacman -S zoxide --noconfirm

sudo pacman -S git-lfs --noconfirm


sudo pacman -S fuse libfuse2 --noconfirm
sudo pacman -S ripgrep --noconfirm

sudo pacman -S fontconfig --noconfirm
sudo pacman -S unzip --noconfirm

sudo pacman -S wezterm --noconfirm

sudo mkdir ~/.config
sudo mkdir ~/.config/fish

sudo rm ~/.omnisharp
sudo rm -r ~/.omnisharp
sudo rm -rf ~/.config/nvim
sudo rm ~/.config/fish/config.fish
sudo rm ~/.config/starship.toml
sudo rm -rf ~/.zshrc
sudo rm ~/.wezterm.lua
sudo rm ~/.gitconfig

sudo rm -r ~/.config/nvim
sudo rm -r ~/.cache/nvim
sudo rm -r ~/.local/share/nvim

sudo ln -sf ~/dotfiles/.omnisharp ~/.omnisharp
sudo ln -s ~/dotfiles/kickstart.nvim ~/.config/nvim
sudo ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
sudo ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml
sudo ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
sudo ln -s ~/dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
sudo ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
sudo ln -s ~/dotfiles/git/.gitconfig-linux ~/.gitconfig-linux


sudo curl -sS https://starship.rs/install.sh | sh

sudo systemctl enable --now snapd.socket
