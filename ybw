#!/bin/bash
#
OLDIFS="$IFS"

rippath="/root/media/udemy-rips/"
read -p "Enter a username if applicable:" uname
read -p "Enter a password if necessary:" pw
read -p "Enter the name of your batch file, or - to manually batch." binput
read -p "Rip audio? " audio
read -p "Speed up output? " speedq
case $audio in
  [yY] | [yY][Ee][Ss] )aflag="-x --audio-format mp3 --audio-quality 7"
  read -p "Keep video?" vidpass
;;
  [nN] | [nN][oO] )aflag=""
  vidpass="n"
;;
  *) echo "That's not a yes or no..."; exit 1
;;
esac
case $vidpass in
  [yY] | [yY][Ee][Ss] )vflag="-k"
;;
  [nN] | [nN][oO] )vflag=""
;;
  *) echo "That's not a yes or no..."; exit 1
;;
esac
case $speedq in
  [yY] | [yY][Ee][Ss] )speedpipe="1"
read -p "Keep original speed files?" origsq
;;
  [nN] | [nN][oO] )echo "Proceeding to download batch without speed post-processing"
;;
  *) echo "That's not a yes or no..."; exit 1
;;
esac
case $origsq in
  [yY] | [yY][Ee][Ss] )origspeed="1"
;;
  [nN] | [nN][oO] )origspeed="0"
;;
  *) echo "That's not a yes or no..."; exit 1
esac
#"ffmpeg -y -i {} -filter_complex '[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]' -map '[v]' -map '[a]' 2xspeed-{} || ffmpeg -y -i {} -filter:a 'atempo=2.0' -vn 2xspeed-{}"
echo "If manually batching, end list with CTRL+D"
youtube-dl $aflag $vflag -u $uname -p $pw -o "$rippath%(playlist)s/%(playlist_index)s=%(title)s=%(playlist)s.%(ext)s" --batch-file $binput 


if [ $speedpipe -eq 1 -a $origspeed -eq 1 ]; then
  IFS=$'\n'
  for each in $(find ~/media/ -mindepth 3 -and -cnewer ~/media/lastrun); do speedpath=$(echo "$each" | awk -F "/" '{ filename=$NF; print "/"$2"/"$3"/"$4"/"$5"/""2XSPEED-"filename}'); ffmpeg -y -i "$each" -filter_complex '[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]' -map '[v]' -map '[a]' "$speedpath" || ffmpeg -y -i "$each" -filter:a 'atempo=2.0' -vn "$speedpath"; done
  IFS=$'$OLDIFS'

elif [ $speedpipe -eq 1 -a $origspeed -eq 0 ]; then
  IFS=$'\n'
  for each in $(find ~/media/ -mindepth 3 -and -cnewer ~/media/lastrun); do speedpath=$(echo "$each" | awk -F "/" '{ filename=$NF; print "/"$2"/"$3"/"$4"/"$5"/""2XSPEED-"filename}'); ffmpeg -y -i "$each" -filter_complex '[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]' -map '[v]' -map '[a]' "$speedpath" || ffmpeg -y -i "$each" -filter:a 'atempo=2.0' -vn "$speedpath"; rm -f $each; done
  IFS=$'$OLDIFS'
fi
rm ${rippath}lastrun
touch ${rippath}lastrun
exit 0
