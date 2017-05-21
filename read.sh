while read line; do line1=$line; done < packages_advanced.txt; pacman -Syu $line1
