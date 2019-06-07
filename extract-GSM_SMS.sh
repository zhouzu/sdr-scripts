#!/bin/bash
# ------------------------------------------------------------------
# [t17lab.com] Extract Plain GSM SMS - Simple Script
#          User can extract cleartext gsm sms from pcap file
#
# Dependency:
#     tshark
# USAGE: chmod u+x extract-GSM_SMS.sh
#	extract-GSM_SMS.sh pcap_file
# ------------------------------------------------------------------

VERSION=0.1.0
USAGE="Usage: $0 pcap_file"


# --- Options processing -------------------------------------------
if [ $# == 0 ] ; then
    echo $USAGE
    exit 1;
fi

if [ "$(which tshark)" = "" ] ;then
echo "TSHARK not found. Please install tshark by using command: sudo apt install tshark"
exit 1
fi
echo -e "\nExtracting SMS from PCAP file\n--------------\n"
	tshark -r $1 -Y gsm_sms -T fields -e gsm_sms.tp-oa -e gsm_sms.scts.hour -e gsm_sms.scts.minutes -e gsm_sms.scts.seconds -e gsm_sms.scts.timezone -e gsm_sms.scts.day -e gsm_sms.scts.month -e gsm_sms.scts.year -e gsm_sms.sms_text -E header=y -E separator=, -E quote=d -E occurrence=f | tee $1.csv
echo -e "\n--------------\nRecords logged to $1.csv"
