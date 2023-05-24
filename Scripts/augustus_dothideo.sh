#!/bin/bash
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load busco/5.4.3

busco -i contigs.fasta -l dothideomycetes_odb10 -o BUSCO_dothideo_EMM_F3 -m genome
