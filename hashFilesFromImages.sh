#!/bin/bash
# https://github.com/Magpol/


#HASHTYPE
HASHTYPE="256"

if [[ $# -eq 0 ]] ; then
    echo 'hashFilesFromImages.sh <PATH TO IMAGES>'
    exit 0
fi

FILES="$(echo $1 | sed 's/\/$//')/*"

for f in $FILES
do
	COUNTER=0
	echo "Processing $f"
	#LINUX
	OFFSET=$(mmls -aM $f|grep -m 1 -P "\d{10}"|awk '{print $3}')

	if [ -f "$f.txt" ]; then
	    echo "$f.txt already exist."
	    continue
	fi

	while IFS= read -r result
	do

		if [ ! -z "$result" ]; then
	   		NAME=$(ffind -o $OFFSET $f $result) 
    		HASH=$(echo $(icat -o $OFFSET $f $result | shasum -a $HASHTYPE | cut -d' ' -f1))
    		printf "%s;%s\n" $NAME $HASH >> $f.txt 
	    	let COUNTER++
	    fi
	done < <(fls -o $OFFSET -F -r $f| awk '{sub(/:|\*/, "", $2);print $2}')
	printf "%s is done! Total files processed: %d\n" $f $COUNTER
done
