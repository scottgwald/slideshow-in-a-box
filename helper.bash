#! /bin/bash

# get jpgs that are not thumbnails

tmpFile="inputFiles.txt"
tmpFile1=$tmpFile.1
thumbFolder="newThumb"
thumbGeom="128x128"
resizeGeom=$thumbGeom^
cropGeom=$thumbGeom+0+0
thumbExcludePattern="thumb"
jsonOut="js/img.json" # NOTE: script touches $jsonOut.tmp
thumbExtension=".thumb.jpg"

#
# cleaning/setup
#
echo "Beginning cleaning and setup."

rm $tmpFile
rm $tmpFile1
#rm -r $thumbFolder
#mkdir $thumbFolder
rm $jsonOut
touch $jsonOut

# find . -iname "*.thumb.jpg" > $tmpFile1
# cat $tmpFile1 | while read line
# do
#     rm -v "$line"
# done

#
# thumbnail generation
#
echo "Beginning thumbnail generation"

echo "finding jpegs that do not include the pattern $thumbExcludePattern"
find . -iname "*.jpg" > $tmpFile
cp $tmpFile $tmpFile.old
grep -v $thumbExcludePattern $tmpFile > $tmpFile.new
mv $tmpFile.new $tmpFile

totalFiles=`cat $tmpFile | wc -l | tr -d ' '`
echo "Total files `cat $tmpFile | wc -l | tr -d ' '`"

cnt=1
cat $tmpFile | while read line
do 
    if [ ! -e "$line.thumb.jpg" ]
    then
	echo "Did not find thumbnail $line.thumb.jpg"
	echo "$cnt of $totalFiles: Producing thumbnail."
	convert -resize $resizeGeom -crop $cropGeom "$line" "$line.thumb.jpg"
    else
	echo "$cnt of $totalFiles: Thumbnail exists $line.thumb.jpg"
    fi
    cnt=$((cnt+1))
done

echo "Finished thumbnail generation"

#
# generate json
#

echo "Generating json in $jsonOut"

# write first line
echo "[{" >> $jsonOut

cat $tmpFile | while read line
do
	# truncate initial "."
	newPath=`echo -e "${line:1}\c"`
	echo -e "\t\"title\":\"$newPath\"," >> $jsonOut
	echo -e "\t\"thumb\":\"$newPath$thumbExtension\"," >> $jsonOut
	echo -e "\t\"src\":\"$newPath\"" >> $jsonOut
	echo -e "},\n{" >> $jsonOut
done

# kill the last 2 lines
let allButLastTwo="`cat $jsonOut | wc -l`"-2
cat $jsonOut | head -n $allButLastTwo > $jsonOut.tmp
mv $jsonOut.tmp $jsonOut

# write last line
echo "}]" >> $jsonOut

echo "Finished generating json"
# #do cp "$line" $thumbFolder
echo "Cleaning up"
rm $tmpFile $tmpFile.old
