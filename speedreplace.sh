#!/bin/bash

OLDIFS=$'IFS'


  IFS=$'\n'
  for each in $(find $1 -mindepth 2 -and ! -type d); do speedpath=$(echo "$each" | awk -F "/" '{ filename=$NF; print "/"$2"/"$3"/"$4"/"$5"/""2XSPEED-"filename}'); ffmpeg -y -i "$each" -filter_complex '[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]' -map '[v]' -map '[a]' "$speedpath" || ffmpeg -y -i "$each" -filter:a 'atempo=2.0' -vn "$speedpath"; rm -f $each; done
  IFS=$'$OLDIFS'

