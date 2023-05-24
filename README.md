# Genome Assembly

A pipeline that encompasses general genome assembly steps, starting from raw Illumina reads.
The scripts in this pipeline were originally run on the [Alabama Supercomputer](https://www.asc.edu/)(ASC) and thus might make reproducibility difficult for users who do not utilize this system. The ASC utilizes a slurm queue system where jobs are submitted and run. Keep in mind that the paths used in this pipeline may need to be added/changed depending on the user's needs.
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
This step does not have a script to be run. Rather, the fastqc module was loaded from the ASC and the following were typed:

```
fastqc F3_S480_R1.clean1.fq
fastqc F3_S480_R2.clean2.fq
```

The output of these lines will give HTML files that can be visualized in a browser and will give quality statistics. If users are satisfied with this information, then they may continue with genome assembly. If not, then previous steps can be amended to trim the reads further to achieve better quality.

## Genome Assembly with SPAdes
As mentioned above, SPAdes is a program that can be used to perform genome assembly. The following [script](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/spades.sh) is used to achieve assembly. K values are specified, forward and reverse reads are used as input, and the output file is labeled "F3_spades" in this case. The output folder provides a file called "contigs.fasta", which will contain the assembled genome.

## Run QUAST for Assembly Statistics
QUAST is a tool that is used to check the quality of an assembled genome. Read more about QUAST [here](https://github.com/ablab/quast). This step does not contain a script either, as the following is all that is necessary to run an assessment in the ASC:

```
module load quast/4.6.3
quast.py contigs.fasta
```

The "contigs.fasta" file is used as input for the command, and the output is a text file that can be viewed for general statistics of the assembly, like N50, number of contigs, etc.

## Comparison
If users have an idea of a similar fungal genome size they want to compare QUAST statistics to, then they can go to the [Joint Genome Institute](https://mycocosm.jgi.doe.gov/mycocosm/home)(JGI). If genome sizes are comparable, then it strengthens the reliability of the assembly.

## BUSCO Scores
BUSCO is a tool that is used to assess the genome assembly and give an idea of annotation completeness, utilizing single-copy genes. Read more about BUSCO [here](https://busco.ezlab.org/).

BUSCO was run on the "contigs.fasta" file, with both the [general fungi database](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/augustus.sh), and also the [Dothideomycetes database](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/augustus_dothideo.sh). To run this properly on the ASC, an Augustus directory has to be created using the lines below:

```
mkdir augustus
cd augustus
cp -r /opt/asn/apps/anaconda_3-4.2.0_cent/pkgs/augustus-3.2.3-boost1.60_0/config .
```

If this step is performed correctly, then the above scripts should run properly and give directories that provide single-copy genes that can be used for further downstream analysis.

## Future Steps
AntiSMASH
BLAST
