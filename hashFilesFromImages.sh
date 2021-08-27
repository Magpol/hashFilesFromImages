#!/bin/bash
# https://github.com/Magpol/


#HASHTYPE
HASHTYPE="256"

if [[ $# < 2 ]] ; then
    echo 'hashFilesFromImages.sh w||c <PATH TO IMAGES> <HASHFILE>'
    echo 'hashFilesFromImages.sh w testImages/   <--   hashes all images in testImages and writes output to testImages/<IMAGENAME>.txt'
    echo 'hashFilesFromImages.sh r testImages/ hashes.txt   <--   check if hash(es) specified in hashes.txt matches in testImages/'
    exit 0
fi


if [[ $1 == 'w' ]];then

	FILES="$(echo $2 | sed 's/\/$//')/*"

	for f in $FILES
	do
		COUNTER=0
		if [[ $f == *.txt ]];then
			continue
		fi
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
elif [[ $1 == 'r' ]];then

	FILES="$(echo $2 | sed 's/\/$//')/*"

	for f in $FILES
	do
		COUNTER=0
		if [[ $f == *.txt ]];then
			continue
		fi		
		echo "Processing $f"
		#LINUX
		OFFSET=$(mmls -aM $f|grep -m 1 -P "\d{10}"|awk '{print $3}')

		while IFS= read -r result
		do

			if [ ! -z "$result" ]; then
		   		NAME=$(ffind -o $OFFSET $f $result) 
	    		HASH=$(echo $(icat -o $OFFSET $f $result | shasum -a $HASHTYPE | cut -d' ' -f1))
	    		if grep -q $HASH $3; then
  					printf "[*] MATCH -- %s;%s\n" $NAME $HASH
				fi
		    	let COUNTER++

		    fi
		done < <(fls -o $OFFSET -F -r $f| awk '{sub(/:|\*/, "", $2);print $2}')
		printf "%s is done! Total files processed: %d\n" $f $COUNTER
	done
fi
