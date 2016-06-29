#!/bin/bash
# Author: Michael Hagen Thut
# Year: 2016
# Name of this script: mp4-convert.sh
# Description: Convert Full HD MP4's to a specific resolution [in this case 1080x608] using HandBrakeCL

SRC=/home/user/Videos/Input/
DEST=/home/user/Videos/Output
DEST_EXT=mp4
HANDBRAKE_CLI=/usr/bin/HandBrakeCLI

for line in $(find $SRC -name "*.$DEST_EXT")
do
	filename=$(basename "$line")
	extension=${filename##*.}
	filename=${filename%.*}
	#echo $line
	FOLDER=$(echo $line | cut -d "/" -f6)
	#echo $FOLDER
	mkdir $DEST/$FOLDER/

	$HANDBRAKE_CLI -i $line -o $DEST/$FOLDER/$filename.$DEST_EXT -O -e x264 --x264-preset veryslow --x264-tune film --x264-profile baseline --encoder-level 3.1 -q 18 --cfr -a none -w 1080 -l 608 --crop 0:0:0:0 -Y 608 -X 1080 --loose-anamorphic --modulus 2

	rm $line
done
