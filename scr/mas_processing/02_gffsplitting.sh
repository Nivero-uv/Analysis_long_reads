#!/bin/bash
#SBATCH --job-name=splitting_gtf_MAS-Seq
#SBATCH --time 10:00:00
#SBATCH --qos=short
#SBATCH --nodes=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=100gb
#SBATCH --array=1-9
#SBATCH --output=log/splitting_gtf_MAS-Seq_%A_%a.out
#SBATCH --error=log/splitting_gtf_MAS-Seq_%A_%a.err

#mkdir splitted
dir="/home/nivero/Mas_Seq/splitted"
#find "/home/nivero/Mas_Seq/mapped_gff" -name "*.gff" | sort > ${dir}/gff_filenames.txt
filenames="${dir}/gff_filenames.txt"
sample=`awk -v line=$SLURM_ARRAY_TASK_ID 'NR==line' ${filenames}`
prefix=`awk -v line=$SLURM_ARRAY_TASK_ID -F'/' 'NR==line {print $6}' ${filenames} | sed 's/.gff//g'`

mkdir -p ${dir}/${prefix}

# This tools ar from UCSC directory
# Downloads from UCSC http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/
# To make it executable chmod +x gtfToGenePred  and  genePredToGtf

# From GTF to GenePred (download script from UCSC tools)
${dir}/gtfToGenePred ${sample} ${dir}/${prefix}/${prefix}.genepred

# Split GTF into 50 GenePred files
split --number=l/50 ${dir}/${prefix}/${prefix}.genepred ${dir}/${prefix}/${prefix}_splitted_genepred

# 50 GenePred (per sample) into GTF again
arr=`find "${dir}/${prefix}" -name "*splitted_genepred*"`

for splitted_genepred in $arr
do
        # Download script from UCSC tools
        ${dir}/genePredToGtf file ${splitted_genepred} ${splitted_genepred}.gtf
done

