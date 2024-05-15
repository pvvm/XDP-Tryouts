How to compile:

Give permission for script
chmod +x update_bpftool.sh

Script that updates the bpftool version
./update_bpftool.sh

Set permission:
sudo chmod +x /usr/sbin/bpftool

Fix error of asm/types.h link:
sudo ln -s /usr/include/x86_64-linux-gnu/asm /usr/include/asm

Optional - If your clang version is < 11.0:
sudo apt install clang-11
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-11 100
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-11 100

./configure
make