#!/bin/bash
#SBATCH --job-name=mapping_gff_MAS-seq
#SBATCH --time 23:00:00
#SBATCH --qos=short
#SBATCH --nodes=1
#SBATCH --cpus-per-task=15
#SBATCH --mem=50gb
#SBATCH --array=1-9		# For each sample, 9 simultaneous tasks
#SBATCH --output=log/mapp_gff_MAS-Seq_%A_%a.out
#SBATCH --error=log/mapp_gff_MAS-Seq_%A_%a.err

#mkdir mapped_gff
dir="/home/nivero/Mas_Seq/mapped_gff"
#find /home/nivero/Mas_Seq/Bam_flnc -name "*flnc*.bam" | sort > ${dir}/filenames_flnc_bam.txt
filenames="${dir}/filenames_flnc_bam.txt"     # list of .bam from MAS-Seq, with FLNC files
sample=`awk -v line=$SLURM_ARRAY_TASK_ID -F'/' 'NR==line {print $6}' ${filenames} | sed 's/.bam//g'`
ref_annotation="/storage/gge/genomes/mouse_ref_NIH/reference_genome/mm39.ncbiRefSeq_SIRV.gtf"
genome="/storage/gge/genomes/mouse_ref_NIH/reference_genome/mm39_SIRV.fa"
samplein=`awk -v line=$SLURM_ARRAY_TASK_ID -F'/' 'NR==line {print $0}' ${filenames}`
sampleout=`awk -v line=$SLURM_ARRAY_TASK_ID -F'/' 'NR==line {print $6}' ${filenames}`

# BAM to FASTQ
#module purge && module load anaconda3
#conda activate pbtk
bam2fastq ${samplein} -o ${dir}/${sampleout}

# Mapping with minimap2
minimap2 -ax splice:hq -uf --MD -t 40 ${genome} ${dir}/${sample}.bam.fastq.gz > ${dir}/${sample}.sam
# splice:hq  MInimap PacBio Iso-seq/traditional cDNA
# -a long sequences against a reference genome 
# -x splice assumes the read orientation relative to the transcript strand is unknown
# -u f to force minimap2 to consider the forward transcript strand only
# to generate the MD (Mismatching positions/bases)
# number o threads for cputime

# Filter SAM to primary alignments (https://github.com/lh3/minimap2/issues/416) and then sort and index BAM file
#module purge && module load anaconda && module load biotools
samtools view -bS -F0x900 ${dir}/${sample}.sam | samtools sort -o ${dir}/${sample}_primary_aln_sorted.bam
samtools index ${dir}/${sample}_primary_aln_sorted.bam

# Minimap BAM to GTF. To avoid deletion of 8 bases or longer considered as introns -t 1000000 is assigned in spliced_bam2gff arguments. Args from spliced_bam2gff are switching between MaxDel -t and -d MaxProcs
# Increase -t parameter OR feed SQANTI directly with reads (should be splitted into multiple files)
# converts BAM alignments, produced by spliced aligners (such as minimap2
spliced_bam2gff -M -t 1000000 ${dir}/${sample}_primary_aln_sorted.bam > ${dir}/${sample}_primary_aln.gff 
# this script removes automatically 2ary alignments. For supplementary alignments -S would be provided
