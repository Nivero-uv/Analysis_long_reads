#!/bin/bash
#SBATCH --job-name=flnc_bam_MAS-Seq
#SBATCH --time 07:00:00
#SBATCH --qos=short
#SBATCH --nodes=1
#SBATCH --cpus-per-task=15
#SBATCH --mem=60gb
#SBATCH --array=1-10 	#9+1
#SBATCH --output=log/flnc_bam_MAS-seq_%A_%a.out
#SBATCH --error=log/flnc_bam_MAS-seq_%A_%a.err

# from the Mas-seq data path it is copied to a folder named Bam_flnc
srun -n 1 -c 1 mkdir Bam_flnc
dir="/home/nivero/Mas_Seq/Bam_flnc"

# To create the file with the path to flnc files
srun -n 1 -c 1 find "/storage/gge/nih/PacBio_MASSeq/2nd_round_08_2023" -type f -name "flnc*.bam" | grep -v "flnc-2*.bam" | sort > ${dir}/flnc_files.txt

files="${dir}/flnc_files.txt"
fileflnc=`awk -v line=$SLURM_ARRAY_TASK_ID 'NR==line' ${files}`
sample=`awk -v line=$SLURM_ARRAY_TASK_ID -F'/' 'NR==line {print $7}' ${files}`

# Copying in the directory
cp ${fileflnc} ${dir}/${sample}.bam

# Creating the pacbio index via bioconda package pbtk  https://github.com/PacificBiosciences/pbtk
pbindex ${dir}/${sample}.bam


# For 1 sample:
#cp /storage/gge/mouse_bulk_MAS-seq_NIH/2nd_round_08_2023/B31-round2/02_SLoutput/flnc.bam B31-round2_flnc.bam
#pbindex B31-round2_flnc.bam

