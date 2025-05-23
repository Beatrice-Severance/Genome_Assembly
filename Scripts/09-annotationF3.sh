#!/bin/bash

source /apps/profiles/modules_asax.sh.dyn
module load funannotate/1.8.13

### InterProScan ###
module load interproscan/5.66

# needs to be xml to use annotation later
interproscan.sh -i /scratch/aubbxs/yeast/scripts/EMM_F3_out/predict_results/EMM_F3.proteins.fa -cpu 16 -f xml

### EggNOG-mapper ###
# May take up to 45gb to load database
module load eggnog/2.1.7

# Make a directory to send eggnog results to
mkdir /scratch/aubbxs/yeast/scripts/EMM_F3_out/predict_results/eggnog

# Database is located in noel_shared. Reads protein sequence by default
emapper.py -i /scratch/aubbxs/yeast/scripts/EMM_F3_out/predict_results/EMM_F3.proteins.fa --output_dir /scratch/aubbxs/yeast/scripts/EMM_F3_out/predict_results/eggnog -o eggnog_out --data_dir ~/noel_shared/Genomes/db/eggnog_db-5.0.2/

# annotate predicted genes
module load funannotate/1.8.13
funannotate annotate -i /scratch/aubbxs/yeast/scripts/EMM_F3_out/ -o EMMF3_annotated --eggnog /scratch/aubbxs/yeast/scripts/EMM_F3_out/predict_results/eggnog/eggnog_out.emapper.annotations --iprscan /scratch/aubbxs/yeast/scripts/EMM_F3.proteins.fa.xml

