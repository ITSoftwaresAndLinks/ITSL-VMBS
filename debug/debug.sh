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
STARTTIME==`date +%s`

# Define script path and include config and includes files
SCRIPT_PATH=$(dirname $(readlink -f $0))

source $SCRIPT_PATH/../conf/main.conf
source $SCRIPT_PATH/../includes/functions.inc


# Print variables values

echo "========================================================="
echo "     DEBUG MODE FOR $HOSTNAME - NOTHING WILL BE DONE"
echo "========================================================="
echo "date and time =>" echoNowTime
echo "SCRIPT_PATH =>" $SCRIPT_PATH
echo "=========================================================="

exit 0