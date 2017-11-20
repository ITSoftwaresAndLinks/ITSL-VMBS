#!/bin/bash
#
# ITSL-VMBS - Virtual Machine Backups Scripts
# Purpose:           
#
# Authors:           jurij.acalinovic@itsl.lu
#                    boris.acalinovic@gmail.com
#

# Define script path and include config and includes files
SCRIPT_PATH=$(dirname $(readlink -f $0))

source ${SCRIPT_PATH}/conf/main.conf
source ${SCRIPT_PATH}/includes/functions.inc

#
# OPTIONS PROCESSING
# ==================================================================================================================== #
if [ $# == 0 ] ; then
    echo ${USAGE}
    exit 1;
fi

while getopts ":l:vh" optname
  do
    case "$optname" in
      "v")
        echo "ITSL-VMBS - Virtual Machine Backups Scripts"
        echo "Version ${VERSION}"
        exit 0;
        ;;
      "l")
        echo "ITSL-VMBS - Virtual Machine Backups Scripts"
        echo "-l argument: ${OPTARG}"
        ;;
      "h")
        echo "ITSL-VMBS - Virtual Machine Backups Scripts"
        echo ${USAGE}
        echo "    -v:    Show version"
        echo "    -i:    List of VMs"
        echo "    -f:    Run in fake mode"
        echo "    -d:    Run in debug mode"
        exit 0;
        ;;
      "?")
        echo "ITSL-VMBS - Virtual Machine Backups Scripts"
        echo "Unknown option ${OPTARG}"
        exit 0;
        ;;
      ":")
        echo "ITSL-VMBS - Virtual Machine Backups Scripts"
        echo "No argument value for option ${OPTARG}"
        exit 0;
        ;;
      *)
        echo "ITSL-VMBS - Virtual Machine Backups Scripts"
        echo "Unknown error while processing options"
        exit 0;
        ;;
    esac
  done

shift $((${OPTIND} - 1))

param1=$1
param2=$2

#
# LOCKS
# ==================================================================================================================== #
LOCK_FILE=/tmp/$SUBJECT.lock
if [ -f "{$LOCK_FILE}" ]; then
   echo "Script is already running"
   exit
fi

trap "rm -f ${LOCK_FILE}" EXIT
touch ${LOCK_FILE}

#
# SCRIPT LOGIC
# ==================================================================================================================== #

exit 0