#!/bin/bash
print_digit(){
	case $1 in
		1)echo -n "one " ;;
	    2)echo -n "two " ;;
		3)echo -n "three " ;;
		4)echo -n "four " ;;
		5)echo -n "five ";;
		6)echo -n "six ";;
		7)echo -n "seven ";;
		8)echo -n "eight ";;
		9)echo -n "nine " ;;
		0) ;;
	esac
}

two_dig(){
	case $1 in
		0)flag2=$((1)) ;;
		2)echo -n "twenty ";;
		3)echo -n "thirty ";;
		4)echo -n "forty ";;
		5)echo -n "fifty ";;
		6)echo -n "sixty ";;
		7)echo -n "seventy ";;
		8)echo -n "eighty ";;
		9)echo -n "ninety ";;
	esac
}

lt_twenty(){
	case $1 in
		0) echo -n "ten ";;
        1) echo -n "eleven ";;
        2) echo -n "twelve ";;
		3) echo -n "thirteen ";;
		4) echo -n "fourteen ";;
		5) echo -n "fifteen ";;
		6) echo -n "sixteen ";;
        7) echo -n "seventeen ";;
        8) echo -n "eighteen ";;
        9) echo -n "nineteen " ;;
 	esac
}

print_place(){
	case $1 in
		11)echo -n "thousand ";;
		 8)echo -n "crore ";;
		 6)echo -n "lakh ";;
		 4)echo -n "thousand ";;
	esac
}

a=$(echo $1 | sed 's\^0*\\')
b=${#a}
if [ $b -le 11 ]
then
i=$((0))
flag=$((0))
flag2=$((0))
while [ $i -lt $b ]
do
	d=${a:i:1}
	p=$(($b-$i))

	if [ $flag -eq 1 ]
	then
		lt_twenty $d
		flag=$((0))
		if [ $p -eq 4 ] || [ $p -eq 6 ] || [ $p -eq 8 ] || [ $p -eq 11 ]
		     then
	         print_place $p
	    fi
		((i++))
		continue
	fi

	if [ $p -eq 2 ] || [ $p -eq 5 ] || [ $p -eq 7 ] || [ $p -eq 9 ]
	then
		if [ $d -eq 1 ]
		then
			flag=$((1))
			if [ $p -eq 4 ] || [ $p -eq 6 ] || [ $p -eq 8 ] || [ $p -eq 11 ]
			     then
		         print_place $p
		    fi
			((i++))
			continue
		fi
		two_dig $d
	fi

	if [ $p -eq 1 ] || [ $p -eq 4 ] || [ $p -eq 6 ] || [ $p -eq 8 ] || [ $p -eq 11 ]
	then
		print_digit $d
	fi

	if [ $p -eq 3 ] || [ $p -eq 10 ]
	then
		print_digit $d
		if [ $d -ne 0 ]
		then
			echo -n "hundred "
		fi
	fi

	if [ $p -eq 4 ] || [ $p -eq 6 ] || [ $p -eq 8 ] || [ $p -eq 11 ]
	then
		if [ $flag2 -eq 0 ]
		then
			print_place $p
		elif [ $p -eq 8 ]
		then
			print_place $p
		else
			flag2=$((0))
		fi
	fi
	((i++))
done
else
	echo "Invalid Input"
fi

