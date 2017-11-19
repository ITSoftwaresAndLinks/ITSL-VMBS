#!/bin/bash
#
# ITSL-VMBS - Virtual Machine Backups Scripts
# Purpose:           debug and tests
#
# Authors:           jurij.acalinovic@itsl.lu
#                    boris.acalinovic@gmail.com
#
# Version:           0.0.1 - 
#

# Set start time
STARTTIME=`date +%s`

# Define script path and include config and includes files
SCRIPT_PATH=$(dirname $(readlink -f $0))

source $SCRIPT_PATH/../conf/main.conf
source $SCRIPT_PATH/../includes/functions.inc


# Print variables values

echo "========================================================="
echo "     DEBUG MODE FOR $HOSTNAME - NOTHING WILL BE DONE"
echo "========================================================="
echo "date and time =>" $(echoNowTime)
echo "SCRIPT_PATH =>" $SCRIPT_PATH
echo ""
echo "LOGS_FILE_PATH =>" $LOGS_FILE_PATH
echo "TEMP_FILE_PATH =>" $TEMP_FILE_PATH
echo "PPK_KEY_PATH =>" $PPK_KEY_PATH
echo "EMAIL_TO_ADDRESS =>" $EMAIL_TO_ADDRESS
echo ""
echo "SOURCE_ADDRESS =>" $SOURCE_ADDRESS
echo "SOURCE_USERNAME =>" $SOURCE_USERNAME
echo "SOURCE_DATASTORE1_PATH =>" $SOURCE_DATASTORE1_PATH
echo "SOURCE_DATASTORE2_PATH =>" $SOURCE_DATASTORE2_PATH
echo "SOURCE_GHETTOVCB_DIR =>" $SOURCE_GHETTOVCB_DIR
echo "SOURCE_VM_LIST =>" $SOURCE_VM_LIST
echo ""
echo "DESTINATION_ADDRESS =>" $DESTINATION_ADDRESS
echo "DESTINATION_USERNAME =>" $DESTINATION_USERNAME
echo "DESTINATION_DATASTORE1_PATH =>" $DESTINATION_DATASTORE1_PATH
echo "DESTINATION_DATASTORE2_PATH =>" $DESTINATION_DATASTORE2_PATH
echo ""

sleep 3
ENDTIME=`date +%s`
echo "Duration "echoDeltaTime $STARTTIME $ENDTIME
echo "========================================================="

exit 0