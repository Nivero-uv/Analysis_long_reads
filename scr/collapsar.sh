#!/bin/bash
#SBATCH --job-name=seqJobTD       # Job name (showed with squeue)
#SBATCH --output=log/seqJob_TD_%j.out  # Standard output and error log
#SBATCH --error=log/seqJob_TD_%j.err
#SBATCH --qos=short                 # QoS: short,medium,long,long-mem
#SBATCH --nodes=1                   # Required only 1 node
#SBATCH --ntasks=1                  # Required only 1 task
#SBATCH --cpus-per-task=2           # Required only 1 cpu
#SBATCH --mem=40G                   # Required 10GB of memory
#SBATCH --time=23:50:00             # Required 5 minutes of execution time.
#SBATCH --array=1-8

module Anaconda3

readarray myarray < class_names.fofn

# Read the file corresponding to the task
file=${myarray[$SLURM_ARRAY_TASK_ID]}

dir="/home/nivero/Iso_Seq/analysis/sqanti3_isoseq"
ori_name=$(basename $file)
filename="${ori_name%_}"

echo $filename

# Create file with data for counts if it is most frecuent
salida=/home/nivero/Iso_Seq/analysis/${filename}_class_mod_transcripts.txt

module anaconda3
source activate SQANTI3.env
dir_UJC="/home/nivero/Iso_Seq/analysis/uniquejunctions/Isoseq_UJC"

echo "python collapsar_from_class.py ${dir}/${filename}/${filename}_classification.txt ${dir_UJC}/${filename}_corrected_UJC.txt ${dir_UJC}/${filename}_corrected_UJC_count.txt ${filename}_corrected_gc_content.txt ${salida}"

python collapsar_from_class.py ${dir}/${filename}/${filename}_classification.txt ${dir_UJC}/${filename}_corrected_UJC.txt ${dir_UJC}/${filename}_corrected_UJC_count.txt /home/nivero/Iso_Seq/scripts/${filename}_corrected_gc_content.txt ${salida}
