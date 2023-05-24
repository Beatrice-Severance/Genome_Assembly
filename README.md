# Genome Assembly

A pipeline that encompasses general genome assembly steps, starting from raw Illumina reads.
The scripts in this pipeline were originally run on the [Alabama Supercomputer](https://www.asc.edu/) and thus might make reproducibility difficult for users who do not utilize this system. The Alabama Supercomputer utilizes a slurm queue system where jobs are submitted and run. Keep in mind that the paths used in this pipeline may need to be added/changed depending on the user's needs.
Scripts from this pipeline are grouped in a folder. The sequence that will be used in this example is a yeast genome, likely from the Dothideomycetes class.

BBDuk is a program that can be used to process Illumina reads before genome assembly is performed. Read more about BBDuk [here](https://jgi.doe.gov/data-and-tools/software-tools/bbtools/bb-tools-user-guide/bbduk-guide/).

SPAdes is a program that can be used to perform genome assembly. Read more about SPAdes [here](https://github.com/ablab/spades).

## [Adapter Removal](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/adapter_removal/adapter.sh)
This step contains a script that utilizes BBDuk to remove adapters that may be present from Illumina sequencing. For the purpose of the yeast genome, the [adapter.fa](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/adapter_removal/adapter.fa) file is used as a reference to ensure that nothing is missed. The raw reads are used as the input, and the output files are named "clean1.fq" for forward reads and "clean2.fq" for reverse reads so that the user can keep track of processed reads.

## [Trim Reads](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/reads.sh)
This step utilizes a script that will quality-trim reads to Q10 using the Phred algorithm. Both the left and right sides of the reads were trimmed for the yeast genome, but users have the ability to change this to fit their needs. The "clean.fq" files will be used as input for this step, and the output files are named "clean_trim1.fq" and "clean_trim2.fq" for forward and reverse reads, respectively.

## [Remove PhiX](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/phix_removal/phix.sh)
The PhiX gene is a potential contaminant that can be misassembled into a genome. Therefore, this step is used to check and make sure that there is no contamination from this source. The [genome.fa file](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/phix_removal/genome.fa) is downloaded from [Illumina](https://support.illumina.com/sequencing/sequencing_software/igenome.html) under the PhiX species classification and is used as a reference so that BBDuk can filter out any reads that match.

The "outm" files will be where any reads that match PhiX will be located, and "out" will simply show unmatched reads. If there is no contamination, then the "outm" files will be empty. If this is the case, then users can continue using the "clean_trim" files from the Trim Reads step when continuing the pipeline.

## FastQC
FastQC can be used to check quality of Illumina reads. Read more about FastQC [here](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/).
This step does not have a script to be run. Rather, the fastqc module was loaded from the Alabama Supercomputer and the following was typed: 
> - fastqc F3_S480_R1.clean1.fq
> - fastqc F3_S480_R2.clean2.fq



## Genome Assembly with SPAdes


## Run QUAST for Assembly Statistics


## Comparison


## BUSCO Scores


## Future Steps

