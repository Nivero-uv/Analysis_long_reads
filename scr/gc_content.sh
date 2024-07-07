#!/bin/bash
#SBATCH --job-name=gc       # Job name
#SBATCH --output=log/gc_cont_%j.out       # Standard output and error log
#SBATCH --nodes=1                       # Run all processes on a single node
#SBATCH --ntasks=1                      # Run a single task
#SBATCH --cpus-per-task=2               # Number of CPU cores per task
#SBATCH --mem-per-cpu=10gb                       # Job memory request
#SBATCH --time=23:00:00			# Time limit hrs:min:sec
#SBATCH --array=0-8
#SBATCH --qos=short                 # QoS: short,medium,long,long-mem

# Conseguir los ficheros gc_content 
# srun -n 1 python3 gccontent.py

# cat $(ls ${sample}_flnc_primary_aln_splitted* | sort) > ${dir}/${sample_name}_corrected_gc_content.txt

# Calcula la mediana del gc_conten de cada read
datos=(`ls *_corrected_gc_content.txt`)
data=${datos[$SLURM_ARRAY_TASK_ID]}
file=$(basename ${datos[$SLURM_ARRAY_TASK_ID]} _corrected_gc_content.txt)
sort -k1,1 ${data} | awk '{arr[$1] = arr[$1] " " $2} END {for (iso in arr) {split(arr[iso], gc_content); n = length(gc_content); if (n % 2 == 0) {median = (gc_content[n/2] + gc_content[n/2 + 1]) / 2} else {median = gc_content[(n+1)/2]} print iso "\t" median}}' > ${file}_med.txt


