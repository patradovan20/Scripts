#!/bin/bash
#############Memory_check.sh##################
#                                            #
#  Created by: Patricia Bianca B. Radovan    #
#  Date Created: Feb 15, 2018                #
#  Description: Bash script for checking     #
#  memory usage                              #
##############################################



#Get inputs
while getopts ':w:' INPUT; do
	case "$INPUT" in
	w)
		echo $2
		;;
	*)
		echo "Script syntax: $(basename $0) [-w]"
		exit 1
		;;
	esac
done

shift "$(($OPTIND -1))"

