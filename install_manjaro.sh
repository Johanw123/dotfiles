
pamac install base-devel --no-confirm

sudo pacman -Syu yay --noconfirm

mkdir ~/src
cd ~/src
git clone https://aur.archlinux.org/unityhub.git
cd unityhub
makepkg -is
cd ..

git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si
cd ..

git https://aur.archlinux.org/sourcegit.git
cd sourcegit
makepkg -si
cd ..




# works stuff
yay -S slack-desktop --noconfirm
yay -S git-credential-manager --noconfirm
yay -S dotnet-sdk --noconfirm

sudo /bin/bash install_admin.sh
