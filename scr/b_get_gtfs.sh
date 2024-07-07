#!/bin/bash
#SBATCH --job-name=ge_gtf_iso      #Job name to show with squeue
#SBATCH --output=log/getgtf_%A.out #Output file
#SBATCH --time=23:00:00         #Time limit to execute the job
#SBATCH --qos=short
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50gb
#SBATCH --array=1
#SBATCH --error=log/getgtf_%A.err #Error file

dir="/home/nivero/Iso_Seq/analysis/uniquejunctions/Isoseq_UJC"

# Obtener los nombres de los archivos Junctions de Output de Sqanti

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1001*gtf" | sort | xargs -I {} tail -n +0 {} >> $dir/B31_corrected.gtf

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1002*gtf" | sort | xargs -I {} tail -n +0 {} >> $dir/B32_corrected.gtf

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1003*gtf" | sort | xargs -I {} tail -n +0 {} >> $dir/B33_corrected.gtf

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1004*gtf" | sort | xargs -I {} tail -n +0 {} >> $dir/K31_corrected.gtf

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1005*gtf" | sort | xargs -I {} tail -n +0 {} >> $dir/K32_corrected.gtf

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1006*gtf" | sort | xargs -I {} tail -n +0 {} >> $dir/K33_corrected.gtf

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1018*gtf" | sort | xargs -I {} tail -n +0 {} >> $dir/BK20801_corrected.gtf

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1019*gtf" | sort | xargs -I {} tail -n +0 {} >> $dir/BK20802_corrected.gtf

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P2*bc1008*gtf" | sort | xargs -I {} tail -n +0 {} >> $dir/BK20803_corrected.gtf
