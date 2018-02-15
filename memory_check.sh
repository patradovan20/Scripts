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


#get Arguments
while getopts ':w:c:e:' INPUT; do
		case "$INPUT" in
		w)
			echo $OPTARG
			wFLAG=true
			;;
		c)
			echo $OPTARG
			cFLAG=true
			;;
		e)
			echo $OPTARG
			eFLAG=true
			;;
		?/)
			echo "Invalid Parameter"
			exit 1
			;;

		:)
			echo "Argument Required"
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
if [ !wFLAG -a !cFLAG -a !eFLAG ]
then
	echo "Script syntax: $(basename $0) -w WARNINGTHRESHOLD  -c CRITICALTHRESHOLD -e EMAILADDRESS"
elif [ !wFLAG -a !cFLAG ]
then
	echo "-w (warning threshold) and -c (critical threshold) required"
	exit 1
elif [ !wFLAG -a !eFLAG]
then
	echo "-w (warning threshold) and -e (email address) required"
elif [ !eFLAG -a !cFLAG ]
then
	echo "-e (email address) and -c (critical threshold) are required"
elif [ !eFLAG ]
then
	echo "-e (email address) is required"
elif [ !cFLAG ]
then
	echo "-c (critical threshold) is required"
elif [ !wFLAG ]
then
	echo "-w (warning threshold) is required"
fi








