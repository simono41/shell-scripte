#! /bin/sh
# Name: replaceSpace
# Ersetzt Leerzeichen in Datei- bzw. Verzeichnisnamen durch '_'
space=' '
replace='_' # Ersetzungszeichen
# Ersetzt alle Datei- und Verzeichnisnamen im
# aktuellen Verzeichnis
for source in *
do
   case "$source" in
   # Ist ein Leerzeichen im Namen vorhanden ...
      *"$space"*)
         # Erst mal den Namen in dest speichern ...
         dest=`echo "$source" | sed "s/$space/$replace/g"`
         # ... überprüfen, ob bereits eine Datei bzw.
         # ein Verzeichnis mit gleichem Namen existiert
         if test -f "$dest"
         then
            echo "Achtung: "$dest" existiert bereits ... \
                  (Überspringen)" 1>&2
            continue
         fi
         # Vorgang auf der Standardausgabe mitschreiben
         echo mv "$source" "$dest"
         # Jetzt ersetzen ...
         mv "$source" "$dest"
         ;;
   esac
done
