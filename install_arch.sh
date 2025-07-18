
#pamac install base-devel --no-confirm

sudo pacman -Syu yay --noconfirm

#mkdir ~/src
#cd ~/src
#git clone https://aur.archlinux.org/unityhub.git
#cd unityhub
#makepkg -is
#cd ..

#git clone https://aur.archlinux.org/snapd.git
#cd snapd
#makepkg -si
#cd ..

#git clone https://aur.archlinux.org/sourcegit.git
#cd sourcegit
#makepkg -si
#cd ..

yay -S unityhub --noconfirm
yay -S snapd --noconfirm
yay -S sourcegit --noconfirm

#dotnet
yay -S dotnet-sdk --noconfirm
yay -S dotnet-sdk-7.0 --noconfirm
yay -S dotnet-sdk-8.0 --noconfirm
yay -S dotnet-runtime --noconfirm
yay -S dotnet-runtime-7.0 --noconfirm
yay -S dotnet-runtime-8.0 --noconfirm
yay -S dotnet-host --noconfirm

# works stuff
yay -S slack-desktop --noconfirm
yay -S git-credential-manager --noconfirm
yay -S dotnet-sdk --noconfirm
yay -S powershell-bin --noconfirm
yay -S hyprland-git --noconfirm
yay -S ags-hyprpanel-git --noconfirm
yay -S gpu-screen-recorder-gtk --noconfirm
#yay -S gcc13 --noconfirm #takes ages

sudo bash install_arch_admin.sh

#pwsh
#Install-Module CompletionPredictor

#cuda (susrepo1 wants gcc at /usr/bin/gcc)
#sudo ln /bin/gcc++ /usr/bin/gcc-15
#sudo ln /bin/g++ /usr/bin/g++-15

#cuda (susrepo1 wants cuda at /usr/local/cuda/bin)
#sudo ln -sf /opt/cuda /usr/local

#nvidia stuff
#systemctl enable nvidia-suspend.service
#systemctl enable nvidia-hibernate.service
#systemctl enable nvidia-hibernate.service
#sudo systemctl enable --now nvidia-powerd.service

# /etc/modprobe.d/nvidia.conf
#options nvidia NVreg_UsePageAttributeTable=1 NVreg_InitializeSystemMemoryAllocations=0 NVreg_EnableStreamMemOPs=1 NVreg_DynamicPowerManagement=0x02 NVreg_RegistryDwords=RMIntrLockingMode=1
#options nvidia_drm modeset=1 fbdev=1
#blacklist nouveau
#options nvidia NVreg_RegistryDwords="PerfLevelSrc=0x2222"
#options nvidia NVreg_RegistryDwords="OverrideMaxPerf=0x1"
#options nvidia NVreg_UsePageAttributeTable=1
#options nvidia NVreg_PreserveVideoMemoryAllocations=1

# /etc/udev/rules.d/60-nvidia.rules
# Device nodes are created by nvidia-modprobe, which is called by the nvidia DDX.
# In case the DDX is not started, the device nodes are never created, so call
# nvidia-modprobe in the udev rules to cover the Wayland/EGLStream and compute
# case without a started display. In the case where vfio-pci is used
# nvidia-modprobe should not be invoked.
#ACTION=="add|bind", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", \
#    DRIVER=="nvidia", TEST!="/dev/nvidia-uvm", \
#    RUN+="/usr/bin/nvidia-modprobe", \
#    RUN+="/usr/bin/nvidia-modprobe -c0 -u"

# Enable runtime PM for NVIDIA VGA/3D controller devices on driver bind
#ACTION=="add|bind", SUBSYSTEM=="pci", DRIVERS=="nvidia", ATTR{vendor}=="0x10de", \
#    ATTR{class}=="0x03[0-9]*", TEST=="power/control", ATTR{power/control}="auto"

# Disable runtime PM for NVIDIA VGA/3D controller devices on driver unbind
#ACTION=="remove|unbind", SUBSYSTEM=="pci", DRIVERS=="nvidia", ATTR{vendor}=="0x10de", \
#    ATTR{class}=="0x03[0-9]*", TEST=="power/control", ATTR{power/control}="on"




#VirtualBox
#https://www.youtube.com/watch?v=N4C5CeYfntE -> shared folders, shared clipboard, guest drivers

#sudo pacman -S virtualbox virtualbox-host-dkms virtualbox-guest-iso
#sudo gpasswd -a $USER vboxusers
#sudo modprobe vboxdrv
#sudo modprobe -r kvm_intel
#sudo systemctl enable vboxweb.service
#sudo systemctl start vboxweb.service
