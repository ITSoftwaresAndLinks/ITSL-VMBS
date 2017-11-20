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
source ${SCRIPT_PATH}/conf/local.conf
source ${SCRIPT_PATH}/includes/functions.inc

#
# OPTIONS PROCESSING
# ==================================================================================================================== #
if [ $# == 0 ] ; then
    echo ""
    echo "${SCRIPT_NAME}"
    echo "        ${USAGE}"
    exit 1;
fi

while getopts ":l:vh" optname
  do
    case "$optname" in
      "v")
        echo ""
        echo "${SCRIPT_NAME}"
        echo "        Version ${VERSION}"
        exit 0;
        ;;
      "l")
        echo ""
        echo "${SCRIPT_NAME}"
        echo "        -l argument: ${OPTARG}"
        ;;
      "h")
        echo ""
        echo "${SCRIPT_NAME}"
        echo "        ${USAGE}"
        echo "        -v:    Show version"
        echo "        -i:    List of VMs"
        echo "        -f:    Run in fake mode"
        echo "        -d:    Run in debug mode"
        exit 0;
        ;;
      "?")
        echo ""
        echo "${SCRIPT_NAME}"
        echo -e "${RED}        Unknown option ${OPTARG}${STD}"
        exit 0;
        ;;
      ":")
        echo ""
        echo "${SCRIPT_NAME}"
        echo -e "${RED}        No argument value for option ${OPTARG}${STD}"
        exit 0;
        ;;
      *)
        echo ""
        echo "${SCRIPT_NAME}"
        echo -e "${RED}        Unknown error while processing options${STD}"
        exit 0;
        ;;
    esac
  done

shift $((${OPTIND} - 1))

param1=$1
param2=$2

#
# LOCK
# ==================================================================================================================== #
LOCK_FILE=/tmp/${SUBJECT}.lock
if [ -f "{$LOCK_FILE}" ]; then
   echo -e "${RED}        Script is already running${STD}"
   exit
fi



#
# SCRIPT LOGIC
# ==================================================================================================================== #




#
# UNLOCK
# ==================================================================================================================== #
trap "rm -f ${LOCK_FILE}" EXIT
touch ${LOCK_FILE}

exit 0