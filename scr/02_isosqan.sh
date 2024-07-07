#!/bin/bash
#SBATCH --job-name=sq_iseq
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=23:00:00
#SBATCH --mem-per-cpu=50G
#SBATCH --array=0-8%2
#SBATCH --qos=short
#SBATCH --output=log/sq_seq_r_%A_%a.out
#SBATCH --error=log/sq_seq_r_%A_%a.err


#mkdir sqanti3
dir="/home/nivero/Iso_Seq/analysis/sqanti3_isoseq"
#find "/home/nivero/Iso_Seq/splitted" -name "*gtf" | sort > ${dir}/gtf_filenames.txt
filenames="${dir}/filenames_gtf.txt"
#splitted_gtf=`awk -v line=$SLURM_ARRAY_TASK_ID 'NR==line' ${filenames}`
#sample=`awk -v line=$SLURM_ARRAY_TASK_ID -F'/' 'NR==line {print $6}' ${filenames} | sed 's/.aln.sorted.bam.gtf//g'`
readarray FILES < "${dir}/filenames_gtf.txt"
splitted_gtf=${FILES[$SLURM_ARRAY_TASK_ID]}
sample=$(basename ${FILES[$SLURM_ARRAY_TASK_ID]} .aln.sorted.bam.gtf)
echo "${splitted_gtf}"
echo "${sample}"

# Define reference annotation and genome
ref_annotation="/storage/gge/genomes/mouse_ref_NIH/reference_genome/mm39.ncbiRefSeq_SIRV.gtf"
genome="/storage/gge/genomes/mouse_ref_NIH/reference_genome/mm39_SIRV.fa"
PolyA_motif="/home/nivero/SQANTI3/data/polyA_motifs/mouse_and_human.polyA_motif.txt"
PolyA_file="/home/nivero/SQANTI3/data/polyA_motifs/atlas.clusters.2.0.GRCm38.96.bed"
TSSRef_file="/home/nivero/SQANTI3/data/ref_TSS_annotation/refTSS_v4.1_mouse_coordinate.mm39.bed"
################ref_TSS

# SQANTI classification of Iso-seq reads
# Define Illumina SJ.out.tab files (this is STRANDED). Same order in the two list of files (filenames*txt)

#############cambiar
filenames_illumina="${dir}/filenames_ilumina.txt"
illumina_sample=`awk -v line=$SLURM_ARRAY_TASK_ID 'NR==line' ${filenames_illumina}`

module load anaconda3
source activate SQANTI3.env
export PYTHONPATH=$PYTHONPATH:/home/nivero/SQANTI3/cDNA_Cupcake/sequence/
export PYTHONPATH=$PYTHONPATH:/home/nivero/SQANTI3/cDNA_Cupcake/

python /home/nivero/SQANTI3/sqanti3_qc.py --skipORF -c "${illumina_sample}" --CAGE_peak "${TSSRef_file}" --polyA_motif_list ${PolyA_motif} --polyA_peak ${PolyA_file} --dir "${dir}/${sample}" -t 4 --output "${sample}" ${splitted_gtf} ${ref_annotation} ${genome} 

