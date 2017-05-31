read -p "Wie ist die URL? : " url
read -p "Soll ein Video heruntergeladen werden oder Audio? [audio/video/opus] : " format
read -p "Wo sollen die Dateien heruntergeladen werden? : " pfad

if [ "$format" == "opus" ]
then
    format=251
elif [ "$format" == "audio" ]
then
    format=171
else
#video
    format=43
fi

mkdir -p $pfad
cd $pfad
/data/data/com.termux/files/usr/bin/python /storage/emulated/0/Music/youtube-dl -i -f $format $url
