#!/bin/bash
#SBATCH --job-name=Fl_UJC
#SBATCH --output=./log/class_freq_UJC_%A_%a.out 
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=15gb
#SBATCH --qos=short
#SBATCH --time=24:00:00
#SBATCH --array=0-2,5-7,15-17

#source ~/.bashrc

# Create array of files
readarray myarray < list_UJCs.fofn

# Read the file corresponding to the task
file=${myarray[$SLURM_ARRAY_TASK_ID]}

dir="/home/nivero/Iso_Seq/analysis/class_UJC"
sqanti_dir="/home/nivero/Iso_Seq/analysis/sqanti3_isoseq/" #"/home/nivero/Iso_Seq/data/classification"

ori_name=$(basename $file)
filename="${ori_name%_corrected_UJC.txt}"

echo $filename

# Create file with data for counts if it is most frecuent
salida=${dir}/${filename}_Isoseq_freq.txt

dircount="/home/nivero/Iso_Seq/analysis/uniquejunctions/Isoseq_UJC"

# ujc\tlength\texons\tchrom\tstructural_category\tassociated_gene\tassociated_transcript\tref_length\tref_exons\tsubcategory
#paste <(awk '{print $2 "\t" $1}' ${dircount}/${filename}_corrected_UJC_count.txt) <(awk '{print $2,$6,$7,$8,$9,$10,$11,$12}' ${dir}/${filename}_class_Isoseq_UJC_gc.txt | sort | uniq -c | sort -k2,2 -k1,1nr | awk '!seen[$2]++') > $salida

#salida=${dir}/${filename}_Isoseq_freq_.txt

#echo -e "UJC\tFL\t_\tujc\tlength\texons\tchrom\tstructural_category\tassociated_gene\tassociated_transcript\tref_length\tref_exons\tgc\tujc_\tlen_\tdist_to_CAGE_peak\twithin_CAGE_peak\tdist_to_polyA_site\twithin_polyA_site\tpolyA_motif\tpolyA_dist\tpolyA_motif_found" > $salida

#paste <(cat ${dir}/${filename}_Isoseq_freq.txt | sort) <(paste <(cat ${file} | sort) <(awk -F'\t' 'NR==FNR {a[$1]; next} ($1 in a) {print $0}' ${file} ${sqanti_dir}/${filename}/${filename}_classification.txt | awk -F '\t' '{print  $1,$4,$40,$41,$42,$43,$44,$45,$46}' | sed 's/  / NA /g' | sort) | awk '{print $2,$4,$5,$6,$7,$8,$9,$10,$11}' | sort | uniq -c | sort -k2,2 -k1,1nr | awk '!seen[$2]++' | awk '{print $2,$3,$4,$5,$6,$7,$8,$9,$10}' | sort -k1) >> $salida
# awk '{print $2,$6,$7,$4,$8,$9,$10,$11,$12,$52}' ${dir}/${filename}_class_Isoseq_UJC_gc.txt | sort | uniq -c | sort -k2,2 -k1,1nr | awk '!seen[$2]++'

#sed -i 's/ \+/\t/g' $salida

#awk 'FNR==NR{a[$3$5]; next} ($2$3 in a)'
#paste <(cat ${salida} | sort) <(awk -F'\t' 'NR==FNR {a[$5$6$7$8$9$10]; next} ($6$7$4$8$9$10 in a) {print $0}' ${salida} ${sqanti_dir}/${filename}_classification.txt | cut -f1- | sort) > ${dir}/${filename}_Isoseq_cage.txt
#awk -F'\t' 'NR==FNR{a[$6"\t"$7\t"$4\t"$8]; next} ($5"\t"$6\t"$7\t"$8 in a) {print $0}' $(sort -k5 /home/nivero/Iso_Seq/analysis/class_UJC/B31_Isoseq_freq.txt) $(sort -k6 /home/nivero/Iso_Seq/analysis/class_UJC/B31_class_Isoseq_UJC_gc.txt)  > ${dir}/${filename}_Isoseq_cage.txt


while IFS=$'\t' read -r _ col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 _; do   
    grep -m 1 -P "$col4\t$col5\t$col6\t$col7\t$col8\t$col9\t$col10" ${sqanti_dir}/${filename}/${filename}_classification.txt ;
done < ${salida} >> ${dir}/${filename}_Isoseq_cage.txt 


