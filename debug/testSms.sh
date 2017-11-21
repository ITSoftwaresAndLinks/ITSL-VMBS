#!/bin/bash
#
# ITSL-VMBS Virtual Machine Backups Scripts
# Purpose:           debug and tests
#
# Authors:           jurij.acalinovic@itsl.lu
#                    boris.acalinovic@gmail.com
#
# Version:           0.0.1 
#

# Define script path and include config and includes files
SCRIPT_PATH=$(dirname $(readlink -f $0))

source ${SCRIPT_PATH}/../conf/main.conf
source ${SCRIPT_PATH}/../conf/local.conf
source ${SCRIPT_PATH}/../includes/functions.inc

#
# Test SMS send
# ==================================================================================================================== #


echo "Testing SMS_ON_ERROR 0 errorLevel 0"
SMS_ON_ERROR=0
errorLevel=0

sendSms "KO SMS_ON_ERROR=0 errorLevel=0"

sleep 2
echo "Testing SMS_ON_ERROR 0 errorLevel 1"
SMS_ON_ERROR=0
errorLevel=1

sendSms "KO SMS_ON_ERROR=0 errorLevel=1"

sleep 2
echo "Testing SMS_ON_ERROR 0 errorLevel 2"

SMS_ON_ERROR=0
errorLevel=2

sendSms "KO SMS_ON_ERROR=0 errorLevel=2"

sleep 2
echo "Testing SMS_ON_ERROR 1 errorLevel 0"

SMS_ON_ERROR=1
errorLevel=0

sendSms "KO SMS_ON_ERROR=1 errorLevel=0"

sleep 2
echo "Testing SMS_ON_ERROR 1 errorLevel 1"

SMS_ON_ERROR=1
errorLevel=1

sendSms "OK SMS_ON_ERROR=1 errorLevel=1"

sleep 2
echo "Testing SMS_ON_ERROR 1 errorLevel 2"

SMS_ON_ERROR=1
errorLevel=2

sendSms "OK SMS_ON_ERROR=1 errorLevel=2"

sleep 2
echo "Testing SMS_ON_ERROR 2 errorLevel 0"

SMS_ON_ERROR=2
errorLevel=0

sendSms "KO SMS_ON_ERROR=2 errorLevel=0"

sleep 2
echo "Testing SMS_ON_ERROR 2 errorLevel 1"

SMS_ON_ERROR=2
errorLevel=1

sendSms "KO SMS_ON_ERROR=2 errorLevel=1"

sleep 2
echo "Testing SMS_ON_ERROR 2 errorLevel 2"

SMS_ON_ERROR=2
errorLevel=2

sendSms "OK SMS_ON_ERROR=2 errorLevel=2"

echo "Test finished"

exit 0