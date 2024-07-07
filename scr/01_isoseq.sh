#!/bin/bash
#SBATCH --job-name=sp_iseq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=23:59:00
#SBATCH --mem-per-cpu=30G
#SBATCH --array=1-20
#SBATCH --qos=short
#SBATCH --output=spliced_seq_%A_%a.out
#SBATCH --error=spliced_seq_%A_%a.err

# Load the required software (bwa)

dir="/home/nivero/Iso_Seq/data/gtf_Iso-Seq"
filenames="/home/nivero/Iso_Seq/metadata/bam.fofn"     # list of sorted .bam from Iso-Seq,
#sample=`awk -v line=$SLURM_ARRAY_TASK_ID -F'/' 'NR==line {print $8}' ${filenames} | sed 's/.aln.sorted.bam//g'`
ref_annotation="/storage/gge/genomes/mouse_ref_NIH/reference_genome/mm39.ncbiRefSeq_SIRV.gtf"
genome="/storage/gge/genomes/mouse_ref_NIH/reference_genome/mm39_SIRV.fa"
samplein=`awk -v line=$SLURM_ARRAY_TASK_ID -F'/' 'NR==line {print $0}' ${filenames}`
sampleout=`awk -v line=$SLURM_ARRAY_TASK_ID -F'/' 'NR==line {print $8}' ${filenames}`

# Minimap BAM to GTF. NOTE here that deletion of 8 bases or longer are considered as introns by this script,  and this should be fixed (there is a bug in spliced_bam2gff script)
# Args from spliced_bam2gff are switching between MaxDel -t and -d MaxProcs
# Increase -t parameter OR feed SQANTI directly with reads (should be splitted into multiple files)
# converts BAM alignments, produced by spliced aligners (such as minimap2
echo "spliced_bam2gff -M -t 1000000 ${samplein}  > ${dir}/${sampleout}.gtf"
spliced_bam2gff -M -t 1000000 ${samplein}  > ${dir}/${sampleout}.gtf  # this script removes automatically 2ary alignments and the whole read if it has supplementary alignments, unless option -S is provided

