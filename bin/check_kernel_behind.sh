#/bin/sh

# Exit if we don't have pacman
# TODO make this script more portable, but for now it doesn't matter
[ -z "$(which pacman)" ] && exit

# If the version of the linux kernel installed via pacman is newer than the one
# you're using according to `uname -r`, then this script will exit
# successfully. In this case, you should reboot your computer, because you
# won't be able to use kernel modules correctly while it's not finished
# updating.

UNAME=$(uname -r)
KERNEL=$(pacman -Q linux | tr _ - | awk -F ' ' '{ print $2 }' -)

# Exit with an error if they are the same
# This way, the script fails "if" checks if your running kernel is fine
if [ "$UNAME" == "$KERNEL" ]; then
	exit 1
fi
