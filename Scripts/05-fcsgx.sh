#!/bin/bash

     module load fcs/0.5.0

     GXDB_LOC="/datasets/unzipped/fcs/gxdb"
     FCSPY="/apps/x86-64/apps/fcs_0.5.0/fcs.py"
     FASTA="/scratch/aubbxs/yeast/FCSGX/contigs.fasta.gz"

     python3 "$FCSPY" screen genome --fasta "$FASTA" --out-dir ./taxa_out/ --gx-db "$GXDB_LOC/" --tax-id 147541
     zcat contigs.fasta.gz | python3 /apps/x86-64/apps/fcs_0.5.0/fcs.py clean genome --action-report ./taxa_out/*.txt --output EMM_F3_clean.fasta --contam-fasta-out F3_contam.fasta
