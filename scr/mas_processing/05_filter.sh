#!/bin/bash
#SBATCH --job-name=sqanti3_filter_MAS-seq
#SBATCH --time 2-00:00:0
#SBATCH --qos=medium
#SBATCH --nodes=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=200gb
#SBATCH --array=1-9
#SBATCH --output=log/sqanti3_filter_MAS-seq_%A_%a.out
#SBATCH --error=log/sqanti3_filter_MAS-seq_%A_%a.err

#mkdir sqanti3_filter_rules
dir="/home/nivero/Mas_Seq_0923/sqanti3_filter_rules"
#find "/home/nivero/Mas_Seq_0923/classification" -name "*_head.txt" | sort > ${dir}/classificationfiles_joined.txt
classificationfiles="${dir}/classificationfiles_joined.txt"
class_files=`awk -v line=$SLURM_ARRAY_TASK_ID 'NR==line' ${classificationfiles}`
sample=`awk -v line=$SLURM_ARRAY_TASK_ID -F'/' 'NR==line {print $6}' ${classificationfiles} | sed 's/_head.txt//g'`

export PYTHONPATH=$PYTHONPATH:/home/nivero/SQANTI3/cDNA_Cupcake/sequence/
export PYTHONPATH=$PYTHONPATH:/home/nivero/SQANTI3/cDNA_Cupcake/

# Running Sqanti filter
python /home/nivero/SQANTI3/sqanti3_filter.py rules ${class_files} --dir ${dir}/${sample} --output ${sample}
