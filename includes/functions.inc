#
# ITSL-VMBS - Virtual Machine Backups Scripts
# Purpose:           store functions
#
# Authors:           jurij.acalinovic@itsl.lu
#                    boris.acalinovic@gmail.com
#


#
# DATE AND TIME HANDLING
# ==================================================================================================================== #

# Print actual date and time in human readable format
# -------------------------------------------------------------------------------------------------------------------- #
# Parameters :       N/A
#
# Usage:             echoNowTime
#
# Return:            Now in human readable format
#
echoNowTime(){
    echo "$(date +%Y-%m-%d) $(date +%H:%M:%S)"
}

# Print duration in human readable format
# -------------------------------------------------------------------------------------------------------------------- #
# Parameters:       $STARTTIME
#                   $ENDTIME
#
# Usage:            echoDeltaTime $STARTTIME $ENDTIME
#
# Return:           Duration in human readable format
#
echoDeltaTime(){
    deltaTime=$(( ${2} - ${1} ))
    secondes=$(( ${deltaTime} % 60 ))
    deltaTime=$(( ${deltaTime} / 60 ))
    minutes=$(( ${deltaTime} % 60 ))
    deltaTime=$(( (${deltaTime} - ${minutes}) / 60 ))
    hours=$(( ${deltaTime} % 24 ))
    days=$(( (${deltaTime} - ${hours}) / 24 ))

    if [[ ${days} -gt 0 ]] ; then
        daysText="${days} days, "
    fi
    if [[ ${hours} -gt 0 ]] ; then
        hoursText="${hours} hours, "
    fi
    if [[ ${minutes} -gt 0 ]] ; then
        minutesText="${minutes} minutes and "
    fi
    echo "${daysText}${hoursText}${minutesText}${secondes} secondes"
}

#
# ERROR HANDLING
# ==================================================================================================================== #

# Verify if parameter is filled
# -------------------------------------------------------------------------------------------------------------------- #
# Parameters:       $PARAMETER
#
# Usage:            ...
#
# Return:           ...
#


#
# EMAIL HANDLING
# ==================================================================================================================== #

#
# SMS HANDLING
# ==================================================================================================================== #

# Send SMS via OVH
# -------------------------------------------------------------------------------------------------------------------- #

# Parameters:       $MESSAGE
#
# Usage:            $(urlencode "${SMS_MESSAGE}")
#
# Return:           raw url encoded text
#
urlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"
}

# Parameters:       $SMS_MESSAGE
#
# Usage:            sendSms $SMS_MESSAGE
#
# Return:           ????
#
sendSms(){
    local request="${OVH_SMS_BASE_URL}?account=${OVH_SMS_ACCOUNT}&login=${OVH_SMS_LOGIN}&password=${OVH_SMS_PASSWORD}&from=${OVH_SMS_FROM}&to=${OVH_SMS_TO}&message=$(urlencode "${1}")&noStop=1"

    if [[ ( ${SMS_ON_ERROR} == 2 && ${errorLevel} == 2 ) || ( ${SMS_ON_ERROR} == 1 && ${errorLevel} == 1 ) || ( ${SMS_ON_ERROR} == 1 && ${errorLevel} == 2 ) ]] ; then {
        result=$(wget ${request} -q -O -)
        echo $result
    }
    fi
}






# What function wil do
# -------------------------------------------------------------------------------------------------------------------- #
# Parameters:       N/A
#
# Usage:            ...
#
# Return:           ...
#
