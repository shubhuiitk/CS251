#!/bin/bash

int_count(){
	count=$(cat $1 | sed -E 's/([0-9]+\.[0-9]+)+//g' | grep -Eo '\-?[0-9]+' | wc -l)
}

int_sencount(){
	sencount=$(cat $1 | sed -E 's/([0-9]+\.[0-9]+)+//g' |grep -o -P '[\.\?\!]?[\w\d\s\,\-]+[\.\?\!]+' | wc -l)
}

recur(){
	gcount=$((0))
	for file in $(ls "$1")
		do
			if [ -d "$1/$file" ]
				then
				((ind++))
				filecopy=$file
				recur "$1/$file"
##				echo $filecopy-$gcount



				i=$((0))
				while [ $i -lt $ind ] ;do
					echo -n "	"
					((i++))
				done
				echo $filecopy-$gcount
##				((ind++))
##				filecopy=$file
##				echo $file-$gcount
##				recur "$1/$file"
##				echo $filecopy-$gcount
##				((ind--))
			else
				count=$((0))
				i=$((0))
				while [ $i -lt $ind ] ;do
					echo -n "	"
					((i++))
				done
				((ind++))
				int_count "$1/$file"
				echo "$file-$count"
				gcount=$((gcount+count))
				((ind--))
			fi
		done
}

ind=$((0))
recur $1
