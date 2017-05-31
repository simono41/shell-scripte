read -p "Wie ist die URL? : " url
read -p "Soll ein Video heruntergeladen werden oder Audio? [audio/video/opus] : " format
read -p "Wo sollen die Dateien heruntergeladen werden? : " pfad

if [ "$format" == "opus" ]
then
    format=251
elif [ "$format" == "audio" ]
then
    format=140
else
#video
    format=43
fi

mkdir -p $pfad
cd $pfad
/data/data/com.termux/files/usr/bin/python /storage/emulated/0/youtube-dl -i -f $format $url

# ROOT_SHELL="$PREFIX/bin/bash"

# ROOT_HOME=$HOME/.suroot

# mkdir -p .suroot

# su --preserve-environment -c "LD_LIBRARY_PATH=$PREFIX/lib HOME=$ROOT_HOME $ROOT_SHELL"

# cd /storage/emulated/0/

# /system/xbin/bash ./youtube-dl-android.sh
