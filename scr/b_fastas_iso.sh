#!/bin/bash
#SBATCH --job-name=fastas_iso      #Job name to show with squeue
#SBATCH --output=fastas_i_%A.out #Output file
#SBATCH --time=23:00:00         #Time limit to execute the job
#SBATCH --qos=short
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=50gb
#SBATCH --array=1
#SBATCH --error=fastas_i_%A.err #Error file



## Obtaining fasta data from ISo-seq samples

dir=/home/nivero/Iso_Seq/data/fastas

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1001*fasta" | sort | xargs -I {} tail -n +0 {} >> $dirs/Iso-seq/B31_corrected.fasta

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1002*fasta" | sort | xargs -I {} tail -n +0 {} >> $dir/Iso-seq/B32_corrected.fasta

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1003*fasta" | sort | xargs -I {} tail -n +0 {} >> $dir/Iso-seq/B33_corrected.fasta

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1004*fasta" | sort | xargs -I {} tail -n +0 {} >> $dir/Iso-seq/K31_corrected.fasta

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1005*fasta" | sort | xargs -I {} tail -n +0 {} >> $dir/Iso-seq/K32_corrected.fasta

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1006*fasta" | sort | xargs -I {} tail -n +0 {} >> $dir/Iso-seq/K33_corrected.fasta

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1018*fasta" | sort | xargs -I {} tail -n +0 {} >> $dir/Iso-seq/BK20_80_1_corrected.fasta

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1019*fasta" | sort | xargs -I {} tail -n +0 {} >> $dir/Iso-seq/BK20_80_2_corrected.fasta

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P2*bc1008*fasta" | sort | xargs -I {} tail -n +0 {} >> $dir/Iso-seq/BK20_80_3_corrected.fasta
