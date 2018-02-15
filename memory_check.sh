#!/bin/bash
#############Memory_check.sh##################
#                                            #
#  Created by: Patricia Bianca B. Radovan    #
#  Date Created: Feb 15, 2018                #
#  Description: Bash script for checking     #
#  memory usage                              #
##############################################


#Variables
OPTIND=1
wFLAG=false;
cFLAG=false;
eFLAG=false;
wVALUE=0;
cVALUE=0;
TOTALMEM=0;
USEDMEM=0;
PERCENT=0;
#########FUNCTIONS




#GET STATUS IF CRITICAL, WARNING, NORMAL
get_status(){

	TOTALMEM=`free -m| grep Mem: | awk '{ print $2 }'`
	USEDMEM=`free -m| grep Mem: | awk '{ print $3 }'`
	PERCENT=$(bc <<< "scale=2;($USEDMEM * 100)/$TOTALMEM")
	PERCENT=`printf "%.0f" $PERCENT`
	echo $PERCENT

	if [ $PERCENT -ge $cVALUE ];
	then
		echo "Used memory is greater than or equal to given critical"
		exit 2;
	elif [ $PERCENT -ge $wVALUE ];
	then
		echo "Memory is greater than warning but less than critical"
		exit 1;
	else
		echo "Memory less than warning"
		exit 0;
	fi
}



#get Arguments
while getopts 'w:c:e:' INPUT; do
		case "$INPUT" in
		w)
			wVALUE=$OPTARG
			wFLAG=true
			;;
		c)
			cVALUE=$OPTARG
			cFLAG=true
			;;
		e)
			#echo $OPTARG
			eFLAG=true
			;;
		?/)
			echo "Invalid Parameter"
			exit 1
			;;

		*)
			echo "Script syntax: $(basename $0) requires -w -c and -e arguments"
			exit 1
			;;
		esac
done
shift "$((OPTIND-1))"


##
#check if required arguments are there
if [ "$wFLAG" = false -a "$cFLAG" = false -a "$eFLAG" = false ];
then
	echo "Script syntax: $(basename $0) -w WARNINGTHRESHOLD  -c CRITICALTHRESHOLD -e EMAILADDRESS"
elif [ "$wFLAG" = false -a "$cFLAG" = false ];
then
	echo "-w (warning threshold) and -c (critical threshold) required"
	exit 1
elif [ "$wFLAG" = false -a "$eFLAG" = false ];
then
	echo "-w (warning threshold) and -e (email address) required"
	exit 1
elif [ "$eFLAG" = false -a "$cFLAG" = false ];
then
	echo "-e (email address) and -c (critical threshold) are required"
	exit 1
elif [ "$eFLAG" = false ];
then
	echo "-e (email address) is required"
	exit 1
elif [ "$cFLAG" = false ];
then
	echo "-c (critical threshold) is required"
	exit 1
elif [ "$wFLAG" = false ];
then
	echo "-w (warning threshold) is required"
	exit 1
else
	if [ $wVALUE -ge $cVALUE ];
	then
		echo "Warning Threshold must be lower than Critical Threshold"
		exit 1

	else
		get_status
	fi

fi
