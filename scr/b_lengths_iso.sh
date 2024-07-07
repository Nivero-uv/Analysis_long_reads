#!/bin/bash
#SBATCH --job-name=Conteos_Isoseq	#Job name to show with squeue
#SBATCH --output=Conteos_%A.out 	#Output file
#SBATCH --time=23:00:00         	#Time limit to execute the job
#SBATCH --qos=short
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=50gb
#SBATCH --array=1
#SBATCH --error=Conteos_Isoseq_%A.err 	#Error file


dir=/home/nivero/Iso_Seq/analysis/counts

echo -e "Seq\tSample\tLength" > ${dir}/lengths_fl_isoseq.txt
for linea in $(cat "${dir}/isoseq_classification.txt"); do
  base=$(basename "$linea" _classification.txt)
  cut -f4 "$linea" | column -t | sed "s/^/Iso-seq\t$base\t/"
done >> ${dir}/lengths_fl_isoseq.txt

# Obtaining lengths from sirv reads
echo -e "Seq\tSample\tassociated_transcript\tLength" > ${dir}/lengths_sirv_isoseq.txt
for linea in $(cat "${dir}/isoseq_classification.txt"); do
  base=$(basename "$linea" _classification.txt)
  awk '$8 ~ /^SIRV/ { print $8, $4 }' "$linea" | column -t | sed "s/^/Iso-seq\t$base\t/"
done >> ${dir}/lengths_sirv_isoseq.txt
 
 #echo -e "Seq\tSample\tCount\tSirv_gene" > ${dir}/isoseq_sirv_associated_gene.txt
#for linea in $(cat "${dir}/isoseq_classification.txt"); do
#  base=$(basename "$linea" _classification.txt)
#  cut -f7 "$linea" | grep "SIRV" | sort | uniq -c | column -t | sed "s/^/Iso-seq\t$base\t/"
#done >> ${dir}/isoseq_sirv_associated_gene.txt
