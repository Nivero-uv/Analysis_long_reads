#!/bin/bash
#SBATCH --job-name=Conteos_Masseq	#Job name to show with squeue
#SBATCH --output=log/Conteos_%A.out 	#Output file
#SBATCH --time=23:00:00         	#Time limit to execute the job
#SBATCH --qos=short
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50gb
#SBATCH --array=1
#SBATCH --error=log/Conteos_Masseq_%A.err 	#Error file


dir=/home/nivero/Mas_Seq/analysis/counts

echo -e "Seq\tSample\tLength" > ${dir}/lengths_fl_masseq.txt
for linea in $(cat "${dir}/masseq_classification.txt"); do
  base=$(basename "$linea" _classification.txt)
  cut -f4 "$linea" | column -t | sed "s/^/Mas-seq\t$base\t/"
done >> ${dir}/lengths_fl_masseq.txt

# Obtiene lengths de lecturas de trasncritos sirvs
echo -e "Seq\tSample\tassociated_transcript\tLength" > ${dir}/lengths_sirv_masseq.txt
for linea in $(cat "${dir}/masseq_classification.txt"); do
  base=$(basename "$linea" _classification.txt)
  awk '$8 ~ /^SIRV/ { print $8, $4 }' "$linea" | column -t | sed "s/^/Mas-seq\t$base\t/"
done >> ${dir}/lengths_sirv_masseq.txt


