# Genome Assembly and Annotation for Novel Yeast EMM_F3

A pipeline that encompasses general genome assembly steps, starting from raw Illumina reads.
The scripts in this pipeline were originally run on the [Alabama Supercomputer](https://www.asc.edu/) (ASC) and thus might make reproducibility difficult for users who do not utilize this system. The ASC utilizes a slurm queue system where jobs are submitted and run. Keep in mind that the paths used in this pipeline may need to be added/changed depending on the user's needs.
Scripts from this pipeline are grouped in a [folder](https://github.com/Beatrice-Severance/Genome_Assembly/tree/main/Scripts). The sequence that will be used in this example is the yeast EMM_F3, likely from the Dothideomycetes class.

## Programs and version numbers used in this pipeline:
- BBDuk *v 39.06* (BBTools)
  - BBDuk is a program that can be used to process Illumina reads before genome assembly is performed. Read more about BBDuk [here](https://jgi.doe.gov/data-and-tools/software-tools/bbtools/bb-tools-user-guide/bbduk-guide/).
- FastQC *v 0.10.1*
  - FastQC can be used to check quality of Illumina reads. Read more about FastQC [here](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/).
- SPAdes *v 3.15.5*
  - SPAdes is a program that can be used to perform genome assembly. Read more about SPAdes [here](https://github.com/ablab/spades).
- FCS-GX *v 0.5.0*
  - [FCS-GX](https://github.com/ncbi/fcs/wiki/FCS-GX) is used to detect contamination from foreign organisms using the genome cross-species aligner (GX).
- QUAST *v 5.2.0*
  - QUAST is a tool that is used to check the quality of an assembled genome. Read more about QUAST [here](https://github.com/ablab/quast).
- BUSCO *v 5.4.3*
  - BUSCO is a tool that is used to assess the genome assembly and give an idea of annotation completeness, utilizing single-copy genes. Read more about BUSCO [here](https://busco.ezlab.org/).
- funannotate *v 1.8.13*
  - Learn more about [funannotate](https://github.com/nextgenusfs/funannotate)
- InterProScan *v 5.66*
  - Funannotate can incorporate annotation information from InterProScan in its analysis. Learn more about [InterProScan5](https://github.com/ebi-pf-team/interproscan)
- EggNOG-Mapper *v 2.1.7*
  - Funannotate can incorporate annotation information from EggNOG-Mapper in its analysis. Learn more about [EggNOG-Mapper](https://github.com/eggnogdb/eggnog-mapper)
  
## Output

The assembled genome for EMM_F3 is located [here](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Output/EMM_F3_clean.fasta). Associated genome annotations are located [here](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Output/EMM_F3.sqn). These files have been uploaded to NCBI under the accession number TBD.

## Step 1: [Adapter Removal](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/adapter_removal/01-adapter.sh)
This step contains a script that utilizes BBDuk to remove adapters that may be present from Illumina sequencing. For the purpose of the yeast genome, the [adapter.fa](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/adapter_removal/adapter.fa) file is used as a reference to ensure that nothing is missed. The raw reads are used as the input, and the output files are named "clean1.fq" for forward reads and "clean2.fq" for reverse reads so that the user can keep track of processed reads.

## Step 2: [Trim Reads](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/02-reads.sh)
This step utilizes a script that will quality-trim reads to Q10 using the Phred algorithm. Both the left and right sides of the reads were trimmed for the yeast genome, but users have the ability to change this to fit their needs. The "clean.fq" files will be used as input for this step, and the output files are named "clean_trim1.fq" and "clean_trim2.fq" for forward and reverse reads, respectively.

## Step 2.5: [Remove PhiX](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/phix_removal/02.5-phix.sh)
The PhiX gene is a potential contaminant that can be misassembled into a genome. Therefore, this step is used to check and make sure that there is no contamination from this source. The [genome.fa file](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/phix_removal/genome.fa) is downloaded from [Illumina](https://support.illumina.com/sequencing/sequencing_software/igenome.html) under the PhiX species classification and is used as a reference so that BBDuk can filter out any reads that match.

The "outm" files will be where any reads that match PhiX will be located, and "out" will simply show unmatched reads. If there is no contamination, then the "outm" files will be empty. If this is the case, then users can continue using the "clean_trim" files from the Trim Reads step when continuing the pipeline.

## Step 3: FastQC
This step does not contain a script to be run. Rather, the fastqc module was loaded from the ASC and the following were typed:

```
fastqc F3_S480_R1.clean1.fq
fastqc F3_S480_R2.clean2.fq
```

The output of these lines will produce HTML files that can be visualized in a browser and will give quality statistics. If users are satisfied with this information, then they may continue with genome assembly. If not, then previous steps can be amended to trim the reads further to achieve better quality.

## Step 4: Genome Assembly with [SPAdes](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/04-spades.sh)
As mentioned above, SPAdes is a program that can be used to perform genome assembly. [spades.sh](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/04-spades.sh) is run to perform assembly. K values are specified, forward and reverse reads are used as input, and the output file is labeled "F3_spades" in this case. The output folder provides a file called "contigs.fasta", which will contain the assembled genome.

## Step 5: Decontaminating your Assembly
The program [FCS-GX](https://github.com/ncbi/fcs/wiki/FCS-GX) is used to detect contamination from foreign organisms using the genome cross-species aligner (GX). The following [script](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/05-fcsgx.sh) was run in order to remove contamination from EMM_F3, using Dothideomycetes as a reference (tax_id: 147541). A decontaminated assembly is the output, and can be used for gene prediction, annotation, and comparison without as much potential for off-target or false positive hits.

For EMM_F3, common bacterial contaminants fell under multiple genus clades, including Stenotrophomonas, Cupriavidus, and Acinetobacter. Bacillus and Pythium contaminants were found to a smaller extent, but all of these were removed and the clean assembly used from there.

## Step 6: Run QUAST for Assembly Statistics
QUAST is a tool that is used to check the quality of an assembled genome. Read more about QUAST [here](https://github.com/ablab/quast). This step does not contain a script either, as the following is all that is necessary to run an assessment in the ASC:

```
module load quast/5.2.0
quast.py contigs.fasta
```

The "contigs.fasta" file is used as input for the command, and the output is a text file that can be viewed for general statistics of the assembly, like N50, number of contigs, etc.

A QUAST analysis of EMM_F3's assembly includes 123 contigs with a GC content of 54.39%, an N50 of 334563, and an L50 of 23.

## Assembly Size Comparison
If users have an idea of a similar fungal genome size they want to compare QUAST statistics to, then they can go to the [Joint Genome Institute](https://mycocosm.jgi.doe.gov/mycocosm/home)(JGI). If genome sizes are comparable, then it strengthens the reliability of the assembly.

## Step 7: BUSCO Scores
BUSCO was run on the "contigs.fasta" file, with both the [general fungi database](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/07.1-augustus.sh), and also the [Dothideomycetes database](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/07.2-augustus_dothideo.sh). To run this properly on the ASC, an Augustus directory has to be created using the lines below:

```
mkdir augustus
cd augustus
cp -r /opt/asn/apps/anaconda_3-4.2.0_cent/pkgs/augustus-3.2.3-boost1.60_0/config .
```

If this step is performed correctly, then the above scripts should run properly and give directories that provide single-copy genes that can be used for further downstream analysis.

# Comparative Genomics
Now that a genome has been assembled and decontaminated, comparative genomics can be run on EMM_F3. This involves a series of steps, taken mostly from the [funannotate](https://github.com/nextgenusfs/funannotate) pipeline.

For EMM_F3, the assembly must first be cleaned for repetitive contigs (funannotate clean), FASTA headers replaced (funannotate sort), and then softmasked (funannotate mask). Once these steps are performed, gene prediction can be performed.

## Step 8: [Gene Prediction](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/08-funpredict.sh)
Gene prediction using funannotate takes the masked FASTA file as input. An output directory can be specified, and the isolate can be named.

## Step 9: [Functional Annotation](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/09-annotationF3.sh)
Gene annotation can be performed using funannotate. There are a couple programs that must be run separately on the Alabama Supercomputer in order for funannotate to recognize them for annotation. These two programs are [InterProScan5](https://github.com/ebi-pf-team/interproscan) and [EggNOG-Mapper](https://github.com/eggnogdb/eggnog-mapper).

### InterProScan5
InterPro is a database that gives an overview of families that a protein belongs to and the domains and sites it contains. By running this, funannotate compare can provide a more thorough output file for EMM_F3.

### EggNOG-Mapper
EggNOG-Mapper provides quick functional annotation of novel sequences, using orthologous groups and phylogenies from the eggNOG database. By running this, funannotate compare can provide a more thorough output file for EMM_F3.

## Step 10: [Funannotate compare](https://github.com/Beatrice-Severance/Genome_Assembly/blob/main/Scripts/10-funcompare.sh)
Funannotate compare can take information from multiple genome annotations and combine them together in order to provide comparative genomics results, including a RAxML tree. 24 genomes were compared against EMM_F3, taken from the Joint Genome Institute (JGI). The masked genome assemblies were downloaded from JGI, and then processed using the 'funannotate annotate' function. These output folders were used for comparative genomics, and the RAxML tree took approximately two weeks to complete.

## Additional Steps

### AntiSMASH
AntiSMASH is a tool used to find potential antibiotic and secondary metabolite properties from a genome. Read more about AntiSMASH [here](https://github.com/antismash/antismash).

For this pipeline, [fungal AntiSMASH](https://fungismash.secondarymetabolites.org/#!/start) was used because the genome of interest was a yeast. Users can upload data from their computer or from NCBI. For the purpose of this pipeline, the "contigs.fasta" file was used. An email can be provided before running AntiSMASH to get a notification when it has finished running.

The output for AntiSMASH is an HTML file that visualizes nodes where secondary metabolite regions are predicted. This information can be utilized however the user desires, and can be useful for future steps to take on genome analysis.

### BLAST
[BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi) is a tool that can be used to find sequence similarity in local regions. If there are potential genes of interest discovered by AntiSMASH, then these can be run in BLAST to see if there are similar sequences in the NCBI database. This is another direction users can take to get more out of their genome assembly.

### Interactive Tree of Life (iTOL)
[iTOL](https://itol.embl.de/) can be used in order to edit the RAxML tree file that 'funannotate compare' provides as an output. This can be used to make the phylogenetic tree look nice for publications.