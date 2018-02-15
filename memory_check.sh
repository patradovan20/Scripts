#!/bin/bash
#############Memory_check.sh##################
#                                            #
#  Created by: Patricia Bianca B. Radovan    #
#  Date Created: Feb 15, 2018                #
#  Description: Bash script for checking     #
#  memory usage                              #
##############################################



OPTIND=1
wFLAG=false;
cFLAG=false;
eFLAG=false;

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
			;;
		*)
			echo "Script syntax: $(basename $0) requires -w -c and -e arguments"
			exit 1
			;;
		esac
done
shift "$((OPTIND-1))"

#check if All arguments are there

if [ !wFLAG -a !cFLAG ]
then
	echo "-w and -c is required"
	exit 0
fi








