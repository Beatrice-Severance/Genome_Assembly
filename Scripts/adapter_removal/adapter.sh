#!/bin/bash
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load bbmap

bbduk.sh -Xmx1g in1=F3_S480_R1_001.fastq.gz in2=F3_S480_R2_001.fastq.gz out1=F3_S480_R1.clean1.fq out2=F3_S480_R2.clean2.fq ref=adapter.fa ktrim=r  k=23  mink=11  hdist=1 tpe tbo
