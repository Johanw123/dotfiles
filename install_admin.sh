
sudo apt-get install -y fuse libfuse2
sudo apt-get install -y ripgrep

sudo apt install -y fontconfig
sudo apt install unzip

#https://github.com/wslutilities/wslu?tab=readme-ov-file
# sudo apt install wslu

#firefox
# sudo install -d -m 0755 /etc/apt/keyrings
# wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
# gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
# echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
# echo '
# Package: *
# Pin: origin packages.mozilla.org
# Pin-Priority: 1000
# ' | sudo tee /etc/apt/preferences.d/mozilla 
# sudo apt-get update && sudo apt-get install firefox -y
#
# #unity hub
# wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null
# sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'
# sudo apt update
# sudo apt-get install unityhub -y

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
sudo apt install python3-pip -y
sudo apt-get install git-lfs -y

sudo apt install fd-find -y
sudo apt install zsh -y

sudo apt-get install snap snapd -y
sudo snap install powershell --classic
sudo snap install snap-store

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

# (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
# 	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
#         && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
#         && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
# 	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
# 	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
# 	&& sudo apt update \
# 	&& sudo apt install gh -y
