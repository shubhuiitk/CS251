#!/bin/bash

int_count(){
			count=$(cat $1 | sed -E 's/([0-9]+\.[0-9]+)+//g' | grep -Eo '\-?[0-9]+' | wc -l)
}

int_sencount(){
	sencount=$(cat $1 | sed -E 's/([0-9]+\.[0-9]+)+//g' |grep -o -P '[\.\?\!]?[\w\d\s\,\-]+[\.\?\!]+' | wc -l)
}

recur(){
	gcount1=$((0))
	gcount2=$((0))
	local gc1=$((0))
	local gc2=$((0))
	((ind++))
	local file
	for file in $(ls "$1"); do
		if [ -d "$1/$file" ]; then
			recur "$1/$file"
			i=$((0))
			while [ $i -lt $ind ] ;do
				echo -n "	"
				((i++))
			done
			echo "(D) $file-$gcount1-$gcount2"
##			((ind--))
			gc1=$(($gc1+$gcount1))
			gc2=$(($gc2+$gcount2))
		else
			sencount=$((0))
			count=$((0))
			i=$((0))
			while [ $i -lt $ind ] ;do
				echo -n "	"
				((i++))
			done
			int_count "$1/$file"
			int_sencount "$1/$file"
			gc2=$(($gc2+$count))
			gc1=$(($gc1+$sencount))
			echo "(F) $file-$sencount-$count"
##			((ind--))
		fi
		done
		gcount1=$gc1
		gcount2=$gc2
		((ind--))
}

sencount=$((0))
count=$((0))
ind=$((0))
recur $1 0 0
echo "exercise-1B-$gcount1-$gcount2"
