# Download bpftool 7.2.0
wget https://github.com/libbpf/bpftool/releases/download/v7.2.0/bpftool-v7.2.0-amd64.tar.gz

# Remove older version of bpftool
sudo rm /usr/sbin/bpftool

# Replace with new version
sudo tar -xzvf ~/bpftool-v7.2.0-amd64.tar.gz -C /usr/sbin/

# Creates a link between the two includes (solve asm/types.h error)
sudo ln -s /usr/include/x86_64-linux-gnu/asm /usr/include/asm

./configure

make