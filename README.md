# Genome Assembly

A pipeline that encompasses general genome assembly steps, starting from raw Illumina reads.
The scripts in this pipeline were originally run on the [Alabama supercomputer](https://www.asc.edu/) and thus might make reproducibility difficult for users who do not utilize this system. The Alabama Supercomputer utilizes a slurm queue system where jobs are submitted and run. Keep in mind that the paths used in this pipeline may need to be added/changed depending on the user's needs.
Scripts from this pipeline are grouped in a folder. The sequence that will be used in this example is a yeast genome, likely from the Dothideomycetes class.

BBDuk is a program that can be used to process Illumina reads before genome assembly is performed. Read more about BBDuk [here](https://jgi.doe.gov/data-and-tools/software-tools/bbtools/bb-tools-user-guide/bbduk-guide/).

## Adapter Removal
This is a script that 

## Trim Reads
This is a script that

## Remove PhiX


## FastQC


## Genome Assembly with SPAdes


## Run QUAST for Assembly Statistics


## Comparison


## BUSCO Scores


## Future Steps

