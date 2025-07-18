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


sudo curl -sS https://starship.rs/install.sh | sh

sudo systemctl enable --now snapd.socket


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

sudo pacman -S power-profiles-daemon
sudo systemctl enable power-profiles-daemon.service --now

ccache -M 100G
ccache -o compression_level=5

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




