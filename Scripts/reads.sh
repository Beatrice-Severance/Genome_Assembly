#!/bin/sh
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load bbmap

bbduk.sh -Xmx1g in1=F3_S480_R1.clean1.fq in2=F3_S480_R2.clean2.fq out1=F3_S480_R1.clean_trim1.fq out2=F3_S480_R2.clean_trim2.fq qtrim=rl trimq=10
