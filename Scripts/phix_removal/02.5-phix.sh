#!/bin/sh
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load bbmap

bbduk.sh -Xmx1g in1=F3_S480_R1.clean_trim1.fq in2=F3_S480_R2.clean_trim2.fq out1=EMMF3unmatched1.fq out2=EMMF3unmatched2.fq outm1=EMMF3matched1.fq outm2=EMMF3matched2.fq ref=genome.fa k=31 hdist=1 stats=EMMF3stats.txt
