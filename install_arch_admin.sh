sudo pamac install base-devel --no-confirm


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

sudo pacman -S slurp --noconfirm

sudo pacman -S archlinux-xdg-menu


sudo curl -sS https://starship.rs/install.sh | sh

sudo systemctl enable --now snapd.socket

#hyprland
sudo pacman -S hyprland --noconfirm
sudo pacman -S hyprshot --noconfirm
sudo pacman -S hyprlock --noconfirm
sudo pacman -S hyprpicker --noconfirm

sudo pacman -S uwsm --noconfirm

#Work/Dev

sudo pacman -S cmake --noconfirm
sudo pacman -S ninja --noconfirm
sudo pacman -S lld --noconfirm
sudo pacman -S cuda --noconfirm
sudo pacman -S tinyxml --noconfirm
sudo pacman -S xml2 --noconfirm
sudo pacman -S lapacke --noconfirm
sudo pacman -S openal --noconfirm
sudo pacman -S gdb --noconfirm
sudo pacman -S lldb --noconfirm
sudo pacman -S krdc --noconfirm # remote desktop client
#sudo yay -S gcc13 --noconfirm

sudo pacman -S kitty --noconfirm
sudo pacman -S fish --noconfirm
sudo pacman -S ccache --noconfirm
sudo pacman -S libsecret --noconfirm
sudo pacman -S ollama --noconfirm

sudo pacman -S vlc
sudo pacman -S ffmpeg
sudo pacman -S vlc-plugin-ffmpeg
sudo pacman -S vlc-plugin-gstreamer

sudo pacman -S wine
sudo pacman -S winetricks

#sudo pacman -S power-profiles-daemon
#sudo systemctl enable power-profiles-daemon.service --now

ccache -M 100G
ccache -o compression_level=5

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


# Virtual machine

sudo pacman -S libvirt virt-manager qemu-full dnsmasq dmidecode
sudo systemctl enable --now libvirtd.service virtlogd.service
sudo usermod -aG libvirt $USER
sudo virsh net-autostart default
sudo virsh net-start default

sudo pacman -S docker
sudo pacman -S docker-compose

sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl start docker

# For empty list in dolphin apps
sudo ln -s /etc/xdg/menus/plasma-applications.menu /etc/xdg/menus/applications.menu

#sudo pacman -S conan --noconfirm


#sudo apt install -y pip
#sudo pip install conan

#sudo apt install -y build-essential ninja-build valgrind lcov mono-complete devscripts debhelper
#sudo apt install -y g++-10

# misc
#sudo apt install -y libglew-dev libsdl2-dev libopenal-dev libtinyxml-dev libtbb-dev imagemagick cifs-utils libopenblas-dev liblapacke-dev

# glbinding
#sudo apt install -y libglbinding2 libglbinding-dev

#sudo apt install -y ccache




