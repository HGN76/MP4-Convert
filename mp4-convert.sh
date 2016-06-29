#!/bin/bash
# Author: Michael Hagen Thut
# Year: 2016
# Name of this script: mp4-convert.sh
# Description: Convert Full HD MP4's to a specific resolution [in this case 1080x608] using HandBrakeCL
# This script depends on the following command line tool: HandBrakeCLI    http://handbrake.fr/

SRC=/home/user/Videos/Input/
DEST=/home/user/Videos/Output
DEST_EXT=mp4
HANDBRAKE_CLI=/usr/bin/HandBrakeCLI

for line in $(find $SRC -name "*.$DEST_EXT")
do
	filename=$(basename "$line")
	extension=${filename##*.}
	filename=${filename%.*}
	# echo $line
	FOLDER=$(echo $line | cut -d "/" -f6)
	# echo $FOLDER
	mkdir $DEST/$FOLDER/

	# HandBrakeCLI Guide: https://trac.handbrake.fr/wiki/CLIGuide
	$HANDBRAKE_CLI --input $line --output $DEST/$FOLDER/$filename.$DEST_EXT --optimize --encoder x264 --x264-preset veryslow --x264-tune film --x264-profile baseline --encoder-level 3.1 --quality 18 --cfr --audio none --width 1080 --height 608 --crop 0:0:0:0 --maxHeight 608 --maxWidth 1080 --loose-anamorphic --modulus 2

	# remove Input File
	rm $line
done
