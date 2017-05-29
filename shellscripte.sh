if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

set -x

apt update
apt upgrade
apt install hedgewars minetest minetest-server teeworlds teeworlds-server mumble mumble-server freeciv gnome-chess gnuchess inkscape gimp ffmpeg flac vorbis-tools vorbisgain git htop android-tools-adb android-tools-fastboot qemu-system btrfs-tools nvidia-375 nvidia-settings -y
nvidia-xconfig

add-apt-repository ppa:wfg/0ad
apt-get update
apt-get install 0ad -y

# 1. Add the Spotify repository signing key to be able to verify downloaded packages
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list

# 3. Update list of available packages
apt-get update

# 4. Install Spotify
apt-get install spotify-client -y

# dd bs=4M if=2017-03-02-raspbian-jessie.img of=/dev/sdd status=progress && sync

mkdir -p /media/hdd
mkdir -p /home/simono41/Musik
mkdir -p /home/simono41/Bilder
mkdir -p /home/simono41/Dokumente
mkdir -p /home/simono41/Videos 
mkdir -p /home/simono41/Downloads
echo "/dev/sda1   /media/hdd   ext4   defaults   0   2" >> /etc/fstab
echo "/media/hdd/mnt/Musik  /home/simono41/Musik  none  bind  0  0" >> /etc/fstab
echo "/media/hdd/mnt/Bilder  /home/simono41/Bilder  none  bind  0  0" >> /etc/fstab
echo "/media/hdd/mnt/Dokumente  /home/simono41/Dokumente  none  bind  0  0" >> /etc/fstab
echo "/media/hdd/mnt/Videos  /home/simono41/Videos  none  bind  0  0" >> /etc/fstab
echo "/media/hdd/mnt/Downloads  /home/simono41/Downloads  none  bind  0  0" >> /etc/fstab

# netbeans + jdk
# atom
# google-chrome
# steam
# minecraft
# discord

# gpg --recv-keys --keyserver hkp://pgp.mit.edu D9C4D26D0E604491
# gpg --recv-keys --keyserver hkp://pgp.mit.edu 5CC908FDB71E12C2
