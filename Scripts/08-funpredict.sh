#!/bin/bash
# Take output from assembly to mask. JGI genomes are already unmasked so skip to the predict genes part for those.

source /apps/profiles/modules_asax.sh.dyn
module load funannotate/1.8.13

# clean
funannotate clean -i EMM_F3_clean.fasta -o F3_clean_out.fasta

# rename headers
funannotate sort -i F3_clean_out.fasta -o F3_renamed_contigs.fasta

# perform masking
funannotate mask -i F3_renamed_contigs.fasta -o F3_masked.fasta

# predict genes
funannotate predict -i F3_masked.fasta -o EMM_F3_out -s "EMM_F3"
