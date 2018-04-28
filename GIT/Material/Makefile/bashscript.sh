#!/bin/bash
while read LINE1
do
	for arg1 in $LINE1
	do
		while read LINE2
		do
			for arg2 in $LINE2
			do
				for i in {1..100}
				do
					out=`./executable.exe $arg1 $arg2 | grep -P -o '[0-9]+'`
					echo "$out" >> runtest
				done
			done
		done <./threads.txt
	done
done <./params.txt
