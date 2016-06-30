#!/bin/bash
# Author: Michael Hagen Thut
# Year: 2016
# Name of this script: mp4-convert.sh
# Description: Convert Full HD MP4's to a specific resolution [in this case 1080x608] using HandBrakeCL
# This script depends on the following command line tool: HandBrakeCLI    http://handbrake.fr/

echo "*********************************************************"
echo "*                                                       *"
echo "*                  HandbrakeCLI Script                  *"
echo "*                                                       *"
echo "* Full-HD [1920x1080] to Terminal resolution [1080x608] *"
echo "*                                                       *"
echo "*********************************************************"

SRC="/home/user/Videos/Input/"
DEST="/home/user/Videos/Output"
DEST_EXT=mp4
DATE=$(date +"%Y-%m-%d:%H:%M:%S")

# HandBrakeCLI Guide: https://trac.handbrake.fr/wiki/CLIGuide
HANDBRAKE_CLI="/usr/bin/HandBrakeCLI"
HANDBRAKE_SETTINGS="--optimize --encoder x264 --x264-preset veryslow --x264-tune film --x264-profile baseline --encoder-level 3.1 --quality 18 --cfr --audio none --width 1080 --height 608 --crop 0:0:0:0 --maxHeight 608 --maxWidth 1080 --loose-anamorphic --modulus 2"

for line in $(find $SRC -name "*.$DEST_EXT")
do
	filename=$(basename "$line")
	extension=${filename##*.}
	filename=${filename%.*}
	# echo $line
	FOLDER=$(echo $line | cut -d "/" -f6)
	# echo $FOLDER
	mkdir $DEST/$FOLDER/

	$HANDBRAKE_CLI --input $line --output $DEST/$FOLDER/$filename.$DEST_EXT $HANDBRAKE_SETTINGS 2> "$DATE-mp4-convert.log"

	# remove Input File
	rm $line

	echo "Job finished. Excellent ;-)"
done
