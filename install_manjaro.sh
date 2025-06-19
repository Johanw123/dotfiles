

pamac install base-devel

sudo pacman -Syu yay

cd ~/src
git clone https://aur.archlinux.org/unityhub.git
cd unityhub
makepkg -is


sudo pacman -Syu code
sudo pacman -S github-cli
sudo pacman -S neovim

sudo pacman -S eza
sudo pacman -S fzf
sudo pacman -S bat
sudo pacman -S bat-extras
sudo pacman -S git-delta

sudo pacman -S git-lfs


sudo pacman -S fuse libfuse2
sudo pacman -S ripgrep

sudo pacman -S fontconfig
sudo pacman -S unzip


mkdir ~/.config
mkdir ~/.config/fish

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

ln -sf ~/dotfiles/.omnisharp ~/.omnisharp
ln -s ~/dotfiles/kickstart.nvim ~/.config/nvim
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/.gitconfig-linux ~/.gitconfig-linux




# works stuff
yay -S slack-desktop