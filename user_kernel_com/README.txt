How to compile:

Script that updates the bpftool version
./update_bpftool.sh

Set permission:
sudo chmod +x /usr/sbin/bpftool

Fix error of asm/types.h link:
sudo ln -s /usr/include/x86_64-linux-gnu/asm /usr/include/asm

./configure
make