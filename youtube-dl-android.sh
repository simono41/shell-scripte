read -p "Wie ist die URL? : " url
read -p "Wo sollen die Dateien heruntergeladen werden? : " pfad
read -p "Soll ein Video heruntergeladen werden oder Audio? [opus/audio/video/BEST] : " format

if [ "$format" == "opus" ]
then
    format="-f 251"
elif [ "$format" == "audio" ]
then
    format="-f 140"
elif [ "$format" == "video" ]
then
    format="-f 43"
fi

mkdir -p $pfad

cd $pfad
/data/data/com.termux/files/usr/bin/python /storage/emulated/0/youtube-dl --ffmpeg-location /data/data/com.termux/files/usr/bin/ffmpeg -i $format $url

# ROOT_SHELL="$PREFIX/bin/bash"

# ROOT_HOME=$HOME/.suroot

# mkdir -p .suroot

# su --preserve-environment -c "LD_LIBRARY_PATH=$PREFIX/lib HOME=$ROOT_HOME $ROOT_SHELL"

# cd /storage/emulated/0/

# /system/xbin/bash ./youtube-dl-android.sh
