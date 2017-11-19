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
# Duration in human readable format

echoDeltaTime(){
	deltaTime=$(( $2-$1 ))
	secondes=$(($deltaTime % 60))
	deltaTime=$(($deltaTime / 60))
	minutes=$(($deltaTime % 60))
	deltaTime=$(( ($deltaTime - $minutes) / 60 ))
	hours=$(($deltaTime % 24))
	days=$(( ($deltaTime - $hours) / 24 ))

  if [[ "$days" -gt 0 ]] ; then
    daysText= $days " days, "
  fi
  if [[ "$hours" -gt 0 ]] ; then
    hoursText= $hours " hours, "
  fi
  if [[ "$minutes" -gt 0 ]] ; then
    minutesText= $minutes " minutes and "
  fi
  echo "$daysText$hoursText$minutesText$secondes secondes"
}

exit 0