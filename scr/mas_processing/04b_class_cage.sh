ls /home/nivero/Mas_Seq/analysis/sqanti3_masseq/*/*_class* | awk -F_flnc '{print $1}' | sort -u | while read -r prefix; do # awk -F/ '{print $NF}' | awk -F '_flnc' '{print $1}' | sort | uniq | while read -r prefix; do
    files=$(ls ${prefix}_flnc*/*classification.txt  | sort)
    first_file=$(echo "$files" | head -n1)
    other_files=$(echo "$files" | tail -n +2)
    name=$(basename $prefix)
    cat ${first_file} > /home/nivero/Mas_Seq/data/classification_cage/${name}_classification.txt
    ls ${other_files} | sort | xargs -I {} tail -n +2 {} >> /home/nivero/Mas_Seq/data/classification_cage/${name}_classification.txt
done


ls /home/nivero/Mas_Seq/analysis/sqanti3_masseq/*/*_junctions* | awk -F_flnc '{print $1}' | sort -u | while read -r prefix; do # awk -F/ '{print $NF}' | awk -F '_flnc' '{print $1}' | sort | uniq | while read -r prefix; do
    files=$(ls ${prefix}_flnc*/*junctions.txt  | sort)
    first_file=$(echo "$files" | head -n1)
    other_files=$(echo "$files" | tail -n +2)
    name=$(basename $prefix)
    cat ${first_file} > /home/nivero/Mas_Seq/data/classification_cage/${name}_junctions.txt
    ls ${other_files} | sort | xargs -I {} tail -n +2 {} >> /home/nivero/Mas_Seq/data/classification_cage/${name}_junctions.txt
done


