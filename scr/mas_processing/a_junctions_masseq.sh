#!/bin/bash
#SBATCH --job-name=Junctions_Mas      #Job name to show with squeue
#SBATCH --output=Junctions_%A.out #Output file
#SBATCH --time=23:00:00         #Time limit to execute the job
#SBATCH --qos=short
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=50gb
#SBATCH --array=1
#SBATCH --error=Junctions_%A.err #Error file

dir=/home/nivero/Mas_Seq_0923/junctions

# Obtener los nombres de los archivos Junctions de Output de Sqanti
find /home/nivero/Mas_Seq_0923/sqanti3/ -type d -name "B31-round*" -exec find {} -type f -name "*junctions.txt" \; | sort | xargs tail -n +2 | cat > $dir/B31-round2_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' B31-round2_junctions.txt | sort | uniq >  $dir/B31-round2__junctions.txt

find /home/nivero/Mas_Seq_0923/sqanti3/ -type d -name "B32*" -exec find {} -type f -name "*junctions.txt" \; | sort | xargs tail -n +2 | cat > $dir/B32_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' B32_junctions.txt | sort | uniq > $dir/B32__junctions.txt

find /home/nivero/Mas_Seq_0923/sqanti3/ -type d -name "B33-round*" -exec find {} -type f -name "*junctions.txt" \; | sort | xargs tail -n +2 | cat > $dir/B33-round2_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' B33-round2_junctions.txt | sort | uniq > $dir/B33-round2__junctions.txt

find /home/nivero/Mas_Seq_0923/sqanti3/ -type d -name "B31_20_80*" -exec find {} -type f -name "*junctions.txt" \; | sort | xargs tail -n +2 | cat > $dir/BK20_80_1_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' BK20_80_1_junctions.txt | sort | uniq > $dir/BK20_80_1__junctions.txt

find /home/nivero/Mas_Seq_0923/sqanti3/ -type d -name "B32_20_80*" -exec find {} -type f -name "*junctions.txt" \; | sort | xargs tail -n +2 | cat > $dir/BK20_80_2_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' BK20_80_2_junctions.txt | sort | uniq > $dir/BK20_80_2__junctions.txt

find /home/nivero/Mas_Seq_0923/sqanti3/ -type d -name "B33_20_80*" -exec find {} -type f -name "*junctions.txt" \; | sort | xargs tail -n +2 | cat > $dir/BK20_80_3_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' BK20_80_3_junctions.txt | sort | uniq > $dir/BK20_80_3__junctions.txt

find /home/nivero/Mas_Seq_0923/sqanti3/ -type d -name "K31-round*" -exec find {} -type f -name "*junctions.txt" \; | sort | xargs tail -n +2 | cat > $dir/K31-round2_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' K31-round2_junctions.txt | sort | uniq > $dir/K31-round2__junctions.txt

find /home/nivero/Mas_Seq_0923/sqanti3/ -type d -name "K32*" -exec find {} -type f -name "*junctions.txt" \; | sort | xargs tail -n +2 | cat > $dir/K32_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' K32_junctions.txt | sort | uniq > $dir/K32__junctions.txt 

find /home/nivero/Mas_Seq_0923/sqanti3/ -type d -name "K33*" -exec find {} -type f -name "*junctions.txt" \; | sort | xargs tail -n +2 | cat > $dir/K33_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' K33_junctions.txt | sort | uniq > $dir/K33__junctions.txt 


#dir=/home/nivero/Mas_Seq_0923/counts
#masseq_classification.txt

#for linea in $(cat "${dir}/masseq_classification.txt"); do
#  base=$(basename "$linea" _classification.txt)
#  awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' archivo_junctions_SQANTI.txt | sort | uniq 
#  "s/^/Mas-seq\t$base\t/"
#done >> ${dir}/lengths_fl_masseq.txt
