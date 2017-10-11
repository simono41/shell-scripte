#!/system/xbin/bash

finds=$(find $1*.apk)

set -x

i=0
for wort in $finds
do

	echo "Installiere $wort"

	pm install $wort

	shift
done

sync

echo "Fertig!!!"

