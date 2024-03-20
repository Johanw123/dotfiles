lsb_release -a

sudo apt update
sudo apt upgrade -y

sudo apt install -y build-essential ninja-build valgrind lcov mono-complete devscripts debhelper
sudo apt install -y g++-10
sudo apt install -y clang lld lldb clang-tools

# ccache
sudo apt install -y ccache
ccache -M 10G
ccache -o compression_level=5
#ccache -s
sudo apt autoremove -y

# misc
sudo apt install -y libglew-dev libsdl2-dev libopenal-dev libtinyxml-dev libtbb-dev imagemagick cifs-utils libopenblas-dev liblapacke-dev

# glbinding
sudo apt install -y libglbinding2 libglbinding-dev

# cmake
sudo apt install -y cmake

# conan
sudo apt install -y pip
pip install conan

./install_cuda_12.2.sh

sudo apt update
sudo apt upgrade -y
