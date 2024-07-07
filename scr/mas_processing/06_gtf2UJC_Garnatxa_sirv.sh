#!/bin/bash
#SBATCH --job-name=get_UJC_Iso-seq
#SBATCH --time 10:00:00
#SBATCH --qos=short
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=110gb
#SBATCH --output=get_UJC_sirvs.out
#SBATCH --error=get_UJC_sirvs.err

# This script takes the .gtf from SQANTI files from the first batch (B31,B32,B33,K31,K32,K33,B151,B152 - 16 SMRT cells each) to create UJC per sample
# UJC are generated for chr1-19, X and Y (default in gtftools) - discarding noncanonical chr. See parameter -c (https://www.genemine.org/gtftools.php) to include other contigs (chrM, unlocalized, random contigs...).
# gtftools installation https://bioconda.github.io/recipes/gtftools/README.html

#module purge && module load anaconda
#conda activate gtftools

arr=`find "/home/nivero/Mas_Seq/analysis/uniquejunctions/Masseq_UJC" -name "*gtf"`
dir="/home/nivero/Mas_Seq/analysis/uniquejunctions/Masseq_UJC_Sirv"

for gtf_file in $arr
do
	# Get prefix name
	name=`basename ${gtf_file} | sed 's/.gtf//g'`
	cd $dir
	# Get introns
	#gtftools -i ${name}_introns.bed ${gtf_file}
	gtftools -c SIRV1,SIRV2,SIRV3,SIRV4,SIRV5,SIRV6,SIRV7 -i ${dir}/${name}_introns_sirv.bed ${gtf_file}
	# Get UJC
	awk -F'\t' -v OFS="\t" '{print $5,"chr"$1,$4,$2+1"_"$3}' ${dir}/${name}_introns_sirv.bed | bedtools groupby -g 1 -c 2,3,4 -o distinct,distinct,collapse | sed 's/,/_/g' | awk -F'\t' -v OFS="\t" '{print $1,$2"_"$3"_"$4}' > ${dir}/${name}_UJC_SIRV.txt

done

cut -f2 ${dir}/${name}_UJC_SIRV.txt | sort | uniq -c > ${dir}/${name}_UJC_SIRV_count.txt
sed -i 's/^ \+//g'  ${dir}/${name}_UJC_SIRV_count.txt
sed -i 's/ \+/\t/g' ${dir}/${name}_UJC_SIRV_count.txt
