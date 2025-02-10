#!/bin/bash

#check for root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

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

test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc


sudo -u johanw brew install eza
sudo -u johanw brew install fzf
sudo -u johanw brew install bat
sudo -u johanw brew install bat-extras
sudo -u johanw brew install git-delta
sudo -u johanw brew install gh
sudo -u johanw brew postinstall gcc


ln -sf ~/dotfiles/.omnisharp ~/.omnisharp
ln -s ~/dotfiles/kickstart.nvim ~/.config/nvim
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig

sudo apt install -y fontconfig
sudo apt install unzip

#https://github.com/wslutilities/wslu?tab=readme-ov-file
# sudo apt install wslu

sudo apt-get install -y ripgrep
sudo apt-get install -y fuse libfuse2

#firefox
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla 
sudo apt-get update && sudo apt-get install firefox

#unity hub
wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'
sudo apt update
sudo apt-get install unityhub

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

curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo sh -s -- -y

. "$HOME/.cargo/env"
#source "$HOME/.cargo/env.fish"

sudo rm ~/.config/fish/config.fish
sudo rm ~/.config/starship.toml
sudo rm -r ~/.omnisharp
sudo rm ~/.gitconfig

sudo rm -r ~/.config/nvim
sudo rm -r ~/.cache/nvim
sudo rm -r ~/.local/share/nvim

# Get nodejs 20
sudo apt purge libnode-dev

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install nodejs -y
# ------------------------------

#fish
chsh -s $(which fish)

#zsh
#zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1