#!/bin/bash
#SBATCH --job-name=fasta_mas      #Job name to show with squeue
#SBATCH --output=fasta_%A.out #Output file
#SBATCH --time=23:00:00         #Time limit to execute the job
#SBATCH --qos=short
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=100gb
#SBATCH --array=1
#SBATCH --error=fastas_%A.err 


find /home/nivero/Mas_Seq_0923/sqanti3/*/ -name "B31-round2*fasta" | sort | xargs -I {} tail -n +0 {} >> fastas/_B31-round2_corrected.fasta

find /home/nivero/Mas_Seq_0923/sqanti3/*/ -name "B32_flnc*fasta" | sort | xargs -I {} tail -n +0 {} >> fastas/_B32_corrected.fasta

find /home/nivero/Mas_Seq_0923/sqanti3/*/ -name "B33-round*fasta" | sort | xargs -I {} tail -n +0 {} >> fastas/_B33-round2_corrected.fasta

find /home/nivero/Mas_Seq_0923/sqanti3/*/ -name "K31-round*fasta" | sort | xargs -I {} tail -n +0 {} >> fastas/_K31-round2_corrected.fasta

find /home/nivero/Mas_Seq_0923/sqanti3/*/ -name "K32*fasta" | sort | xargs -I {} tail -n +0 {} >> fastas/_K32_corrected.fasta

find /home/nivero/Mas_Seq_0923/sqanti3/*/ -name "K33*fasta" | sort | xargs -I {} tail -n +0 {} >> fastas/_K33_corrected.fasta

find /home/nivero/Mas_Seq_0923/sqanti3/*/ -name "B31_20_80*fasta" | sort | xargs -I {} tail -n +0 {} >> fastas/_BK20_80_1_corrected.fasta

find /home/nivero/Mas_Seq_0923/sqanti3/*/ -name "B32_20_80*fasta" | sort | xargs -I {} tail -n +0 {} >> fastas/_BK20_80_2_corrected.fasta

find /home/nivero/Mas_Seq_0923/sqanti3/*/ -name "B33_20_80*fasta" | sort | xargs -I {} tail -n +0 {} >> fastas/_BK20_80_3_corrected.fasta
