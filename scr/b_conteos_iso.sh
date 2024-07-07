#!/bin/bash
#SBATCH --job-name=Conteos_Isoseq	#Job name to show with squeue
#SBATCH --output=log/Conteos_%A.out 	#Output file
#SBATCH --time=23:00:00         	#Time limit to execute the job
#SBATCH --qos=short
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50gb
#SBATCH --array=1
#SBATCH --error=log/Conteos_Isoseq_%A.err 	#Error file


dir=/home/nivero/Iso_Seq/analysis/counts

# Cuantificacion total categorias y subcategorias
echo -e "Seq\tSample\tCount\tCategory" > ${dir}/isoseq_categorias_conteo.txt
for linea in $(cat "${dir}/isoseq_classification.txt"); do
  base=$(basename "$linea" _classification.txt)
   grep -v "SIRV" "$linea" | cut -f6 | sort | uniq -c | column -t | sed "s/^/Iso-seq\t$base\t/"
done >> ${dir}/isoseq_categorias_conteo.txt

echo -e "Seq\tSample\tCount\tSubategory" > ${dir}/isoseq_subcategorias_conteo.txt
for linea in $(cat "${dir}/isoseq_classification.txt"); do
  base=$(basename "$linea" _classification.txt)
  grep -v "SIRV" "$linea" | cut -f15 | sort | uniq -c | column -t | sed "s/^/Iso-seq\t$base\t/"
done >> ${dir}/isoseq_subcategorias_conteo.txt

# Cuantificacion total categorias y subcategorias filtrado solo para sirvs
echo -e "Seq\tSample\tCount\tCategory" > ${dir}/isoseq_categorias_conteos_soloSIRVs.txt
for linea in $(cat "${dir}/isoseq_classification.txt"); do
  base=$(basename "$linea" _classification.txt)
  grep "SIRV" "$linea" | cut -f6 | sort | uniq -c | column -t | sed "s/^/Iso-seq\t$base\t/"
done >> ${dir}/isoseq_categorias_conteos_soloSIRVs.txt

echo -e "Seq\tSample\tCount\tSubcategory" > ${dir}/isoseq_subcategorias_conteos_soloSIRVs.txt
for linea in $(cat "${dir}/isoseq_classification.txt"); do
  base=$(basename "$linea" _classification.txt)
  grep "SIRV" "$linea" | cut -f15 | sort | uniq -c | column -t | sed "s/^/Iso-seq\t$base\t/"  
done >> ${dir}/isoseq_subcategorias_conteos_soloSIRVs.txt

# Cuantificacion de categorias y subcategorias por SIRVs
echo -e "Seq\tSample\tCount\tSirv\tCategory" > ${dir}/isoseq_categorias_conteos_chromSIRVs.txt
for linea in $(cat "${dir}/isoseq_classification.txt"); do
  base=$(basename "$linea" _classification.txt)
  cut -f2,6 "$linea" | grep "SIRV" | sort | uniq -c | column -t | sed "s/^/Iso-seq\t$base\t/"
done >> ${dir}/isoseq_categorias_conteos_chromSIRVs.txt

echo -e "Seq\tSample\tCount\tSirv\tSubcategory" > ${dir}/isoseq_subcategorias_conteos_chromSIRVs.txt
for linea in $(cat "${dir}/isoseq_classification.txt"); do
  base=$(basename "$linea" _classification.txt)
  cut -f2,15 "$linea" | grep "SIRV" | sort | uniq -c | column -t | sed "s/^/Iso-seq\t$base\t/"
done >> ${dir}/isoseq_subcategorias_conteos_chromSIRVs.txt

# Cuantification de associated transcript SIRV 
echo -e "Seq\tSample\tCount\tSirv_transcript" > ${dir}/isoseq_sirv_associated_transcript.txt
for linea in $(cat "${dir}/isoseq_classification.txt"); do
  base=$(basename "$linea" _classification.txt)
  cut -f8 "$linea" | grep "SIRV" | sort | uniq -c | column -t | sed "s/^/Iso-seq\t$base\t/"
done >> ${dir}/isoseq_sirv_associated_transcript.txt

echo -e "Seq\tSample\tCount\tSirv_gene" > ${dir}/isoseq_sirv_associated_gene.txt
for linea in $(cat "${dir}/isoseq_classification.txt"); do
  base=$(basename "$linea" _classification.txt)
  cut -f7 "$linea" | grep "SIRV" | sort | uniq -c | column -t | sed "s/^/Iso-seq\t$base\t/"
done >> ${dir}/isoseq_sirv_associated_gene.txt
