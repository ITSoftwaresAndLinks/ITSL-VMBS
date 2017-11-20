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

# Define script path and include config and includes files
SCRIPT_PATH=$(dirname $(readlink -f $0))

source ${SCRIPT_PATH}/../conf/main.conf
source ${SCRIPT_PATH}/../conf/local.conf
source ${SCRIPT_PATH}/../includes/functions.inc

# Set start time
STARTTIME=`date +%s`
sleep 1


# Print variables values

echo "========================================================="
echo "     DEBUG MODE FOR $HOSTNAME - NOTHING WILL BE DONE"
echo "========================================================="
echo "Started at             =>" $(echoNowTime)
echo "SCRIPT_PATH            =>" ${SCRIPT_PATH}
echo ""
echo -e "${RED}Red ${YEL}Yellow ${GRE}Green ${BLU}Blue ${STD}Standard"
echo ""
echo "LOGS_FILE_PATH         =>" ${LOGS_FILE_PATH}
echo "TEMP_FILE_PATH         =>" ${TEMP_FILE_PATH}
echo "PPK_KEY_PATH           =>" ${PPK_KEY_PATH}
echo "EMAIL_TO_ADDRESS       =>" ${EMAIL_TO_ADDRESS}
echo ""
echo "SOURCE_ADDRESS         =>" ${SOURCE_ADDRESS}
echo "SOURCE_USERNAME        =>" ${SOURCE_USERNAME}
echo "SOURCE_DATASTORE1_PATH =>" ${SOURCE_DATASTORE1_PATH}
echo "SOURCE_DATASTORE2_PATH =>" ${SOURCE_DATASTORE2_PATH}
echo "SOURCE_GHETTOVCB_DIR   =>" ${SOURCE_GHETTOVCB_DIR}
echo "SOURCE_VM_LIST         =>" ${SOURCE_VM_LIST}
echo ""
echo "TARGET_ADDRESS         =>" ${TARGET_ADDRESS}
echo "TARGET_USERNAME        =>" ${TARGET_USERNAME}
echo "TARGET_DATASTORE1_PATH =>" ${TARGET_DATASTORE1_PATH}
echo "TARGET_DATASTORE2_PATH =>" ${TARGET_DATASTORE2_PATH}
echo ""


# Parameters control


# Test to do

# Intermediate temporary file ?
TEMP_FILE="/tmp/rc.tmp"

#
# ESXi SOURCE PARAMETERS
# ==================================================================================================================== #
if [[ -n "${SOURCE_USERNAME}" || -n "${SOURCE_ADDRESS}" ]] ; then {
    ssh ${SOURCE_USERNAME}@${SOURCE_ADDRESS} exit >>${TEMP_FILE} 2>&1
    if [[ $? -ne 0 ]] ; then {
        echo -e "${RED}KO => CAN NOT LOGIN on ESXi server ${SOURCE_ADDRESS}.${STD}"
        cat ${TEMP_FILE}
    }
    else {
        SOURCE_SSH="OK"
        echo "OK => SSH login successful on ESXi server ${SOURCE_ADDRESS}."
    }
    fi
}
else {
    echo -e "${RED}KO => SOURCE_USERNAME and SOURCE_ADDRESS must be filled !${STD}"
}
fi

if [[ -n "${PPK_KEY_PATH}" ]] ; then {
    if [[ -f "${PPK_KEY_PATH}" ]] ; then {
    plink ${SOURCE_USERNAME}@${SOURCE_ADDRESS} -ssh -i ${PPK_KEY_PATH} ls . >>${TEMP_FILE} 2>&1
        if [[ $? -ne 0 ]] ; then {
            echo -e "${RED}KO => CAN NOT LOGIN on ESXi server ${SOURCE_ADDRESS}.${STD}"
            cat ${TEMP_FILE}
        }
        else {
            echo "OK => PLINK login successful on ESXi server ${SOURCE_ADDRESS}."
    	      SOURCE_PLINK="OK"
        }
        fi
    }
    else {
        echo -e "${RED}KO => ppk key file ${PPK_KEY_PATH} NOT found !${STD}"
    }
    fi
}
else {
    echo -e "${RED}KO => PPK_KEY_PATH must be filled !${STD}"
}
fi

if [[ "${SOURCE_PLINK}" == "OK" ]] ; then {
    if [[ -n "${SOURCE_DATASTORE1_PATH}" ]] ; then {
        plink ${SOURCE_USERNAME}@${SOURCE_ADDRESS} -ssh -i ${PPK_KEY_PATH} ls ${SOURCE_DATASTORE1_PATH} >>${TEMP_FILE} 2>&1
        if [[ $? -ne 0 ]] ; then {
            echo -e "${RED}KO => CAN NOT FIND datastore1 ${SOURCE_DATASTORE1_PATH} on ESXi server ${SOURCE_ADDRESS}.${STD}"
            cat ${TEMP_FILE}
        }
        else {
            echo "OK => Datastore1 ${SOURCE_DATASTORE1_PATH} found on ESXi server ${SOURCE_ADDRESS}."
        }
        fi
    }
    else {
        echo -e "${RED}KO => SOURCE_DATASTORE1_PATH must be filled !${STD}"
    }
    fi

    if [[ -n "${SOURCE_DATASTORE2_PATH}" ]] ; then {
        plink ${SOURCE_USERNAME}@${SOURCE_ADDRESS} -ssh -i ${PPK_KEY_PATH} ls ${SOURCE_DATASTORE2_PATH} >>${TEMP_FILE} 2>&1
        if [[ $? -ne 0 ]] ; then {
            echo -e "${RED}KO => CAN NOT FIND datastore2 ${SOURCE_DATASTORE2_PATH} on ESXi server ${SOURCE_ADDRESS}.${STD}"
            cat ${TEMP_FILE}
        }
        else {
            echo "OK => Datastore2 ${SOURCE_DATASTORE2_PATH} found on ESXi server ${SOURCE_ADDRESS}."
        }
        fi
    }
    else {
        echo -e "${RED}KO => SOURCE_DATASTORE2_PATH must be filled !${STD}"
    }
    fi
}
fi
echo ""

#
# ESXi TARGET PARAMETERS
# ==================================================================================================================== #
if [[ -n "${TARGET_USERNAME}" || -n "${TARGET_ADDRESS}" ]] ; then {

    ssh ${TARGET_USERNAME}@${TARGET_ADDRESS} exit >>${TEMP_FILE} 2>&1
    if [[ $? -ne 0 ]] ; then {
        echo -e "${RED}KO => CAN NOT LOGIN on ESXi server ${TARGET_ADDRESS}.${STD}"
        cat ${TEMP_FILE}
    }
    else {
        echo "OK => SSH login successful on ESXi server ${TARGET_ADDRESS}."
    }
    fi
}
else {
    echo -e "${RED}KO => TARGET_USERNAME and TARGET_ADDRESS must be filled !${STD}"
}
fi

if [[ -n "${PPK_KEY_PATH}" ]] ; then {
    if [[ -f "${PPK_KEY_PATH}" ]] ; then {
    plink ${TARGET_USERNAME}@${TARGET_ADDRESS} -ssh -i ${PPK_KEY_PATH} ls . >>${TEMP_FILE} 2>&1
        if [[ $? -ne 0 ]] ; then {
            echo -e "${RED}KO => CAN NOT LOGIN on ESXi server ${TARGET_ADDRESS}.${STD}"
            cat ${TEMP_FILE}
        }
        else {
            echo "OK => PLINK login successful on ESXi server ${TARGET_ADDRESS}."
    	      TARGET_PLINK="OK"
        }
        fi
    }
    else {
        echo -e "${RED}KO => ppk key file ${PPK_KEY_PATH} NOT found !${STD}"
    }
    fi
}
else {
    echo -e "${RED}KO => PPK_KEY_PATH must be filled !${STD}"
}
fi

if [[ "${TARGET_PLINK}" == "OK" ]] ; then {
    if [[ -n "${TARGET_DATASTORE1_PATH}" ]] ; then {
        plink ${TARGET_USERNAME}@${TARGET_ADDRESS} -ssh -i ${PPK_KEY_PATH} ls ${TARGET_DATASTORE1_PATH} >>${TEMP_FILE} 2>&1
        if [[ $? -ne 0 ]] ; then {
            echo -e "${RED}KO => CAN NOT FIND datastore1 ${TARGET_DATASTORE1_PATH} on ESXi server ${TARGET_ADDRESS}.${STD}"
            cat ${TEMP_FILE}
        }
        else {
            echo "OK => Datastore1 ${TARGET_DATASTORE1_PATH} found on ESXi server ${TARGET_ADDRESS}."
        }
        fi
    }
    else {
        echo -e "${RED}KO => TARGET_DATASTORE1_PATH must be filled !${STD}"
    }
    fi

    if [[ -n "${TARGET_DATASTORE2_PATH}" ]] ; then {
        plink ${TARGET_USERNAME}@${TARGET_ADDRESS} -ssh -i ${PPK_KEY_PATH} ls ${TARGET_DATASTORE2_PATH} >>${TEMP_FILE} 2>&1
        if [[ $? -ne 0 ]] ; then {
            echo -e "${RED}KO => CAN NOT FIND datastore2 ${TARGET_DATASTORE2_PATH} on ESXi server ${TARGET_ADDRESS}.${STD}"
            cat ${TEMP_FILE}
        }
        else {
            echo "OK => Datastore2 ${TARGET_DATASTORE2_PATH} found on ESXi server ${TARGET_ADDRESS}."
        }
        fi
    }
    else {
        echo -e "${RED}KO => TARGET_DATASTORE2_PATH must be filled !${STD}"
    }
    fi
}
fi
echo ""


ENDTIME=`date +%s`
echo "Duration: $(echoDeltaTime $STARTTIME $ENDTIME)"
echo "========================================================="

exit 0