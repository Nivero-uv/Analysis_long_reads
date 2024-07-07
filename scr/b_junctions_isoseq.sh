#!/bin/bash
#SBATCH --job-name=Junctions_Iso      #Job name to show with squeue
#SBATCH --output=Conteos_%A.out #Output file
#SBATCH --time=23:00:00         #Time limit to execute the job
#SBATCH --qos=short
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=50gb
#SBATCH --array=1
#SBATCH --error=Junctions_%A.err #Error file


# Classification by sample
# find /storage/gge/nih/RUN* -name "P2*bc1008*classification.txt" | sort | xargs -I {} tail -n +2 {} >> B33_20_80-BK20.txt

# head -n 1 /storage/gge/nih/RUN5_070623/Cell1/demultiplexed_bam/flnc/run_SQANTI/P2_L1_AC_SMRT1-m54366Ue_230607_092933.fl.bc1008_5p--bc1008_3p_primary_aln_sorted/P2_L1_AC_SMRT1-m54366Ue_230607_092933.fl.bc1008_5p--bc1008_3p_primary_aln_sorted_classification.txt > B33_20_80_classification.txt

# cat classification_temp.txt >> B33_20_80_classification.txt

## Obtaining junction data from Iso-seq samples

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1001*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> B31_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' B31_junctions.txt | sort | uniq > B31__junctions.txt

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1002*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> B32_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' B32_junctions.txt | sort | uniq > B32__junctions.txt

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1003*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> B33_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' B33_junctions.txt | sort | uniq > B33__junctions.txt

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1004*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> K31_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' K31_junctions.txt | sort | uniq > K31__junctions.txt

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1005*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> K32_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' K32_junctions.txt | sort | uniq > K32__junctions.txt

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1006*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> K33_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' K33_junctions.txt | sort | uniq > K33__junctions.txt

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1018*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> BK20801_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' BK20801_junctions.txt | sort | uniq > BK20801__junctions.txt

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P1*bc1019*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> BK20802_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' BK20802_junctions.txt | sort | uniq > BK20802__junctions.txt

find /storage/gge/nih/PacBio_IsoSeq/*/*/*/*_bam/* -name "P2*bc1008*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> BK20803_junctions.txt
awk -F'\t' -v OFS="\t" 'NR>1{print $2"/"$5"/"$6"/"$3,$8,$15,$20}' BK20803_junctions.txt | sort | uniq > BK20803__junctions.txt


