#!/bin/bash
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load spades/3.15.0

spades.py  -k  21,33,55,77,99,127  -1  F3_S480_R1.clean_trim1.fq  -2  F3_S480_R2.clean_trim2.fq  -o F3_spades --careful
