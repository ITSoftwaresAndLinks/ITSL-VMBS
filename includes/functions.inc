#
#
# ITSL-VMBS - Virtual Machine Backups Scripts
# Purpose:           store functions
#
# Authors:           jurij.acalinovic@itsl.lu
#                    boris.acalinovic@gmail.com
#
# Version:           0.0.1 - 
#

#                                                 #
# DATE AND TIME FUNCTIONS
# =============================================== #

echoNowTime(){
	echo $(date +%Y-%m-%d) $(date +%H:%M:%S)
}

# Parameters :
# 
# Usage echoDeltaTime $STARTTIME $ENDTIME
#
# Return :
# delta in human readable format

echoDeltaTime(){
	deltaTime=$(( $2-$1 ))
	seconds=$(($deltaTime % 60))
	deltaTime=$(($deltaTime / 60))
	minutes=$(($deltaTime % 60))
	deltaTime=$(( ($deltaTime - $minutes) / 60 ))
	hours=$(($deltaTime % 24))
	days=$(( ($deltaTime - $hours) / 24 ))

	if [[ "$days" !eq 0 ]] ; then
		result= "$days days, $result"
	fi
	if [[ "$hours" !eq 0 ]] ; then
		result= "$hours hours, $result"
	fi
	if [[ "$minutes" !eq 0 ]] ; then
		result= "$minutes minutes and $result"
	fi
	result= "$result $seconds seconds"

	echo "$result"
}


