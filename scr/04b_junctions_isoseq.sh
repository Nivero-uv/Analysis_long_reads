dir="/home/nivero/Iso_Seq/data/junctions"

cat ${dir}/head.txt > ${dir}/B31_junctions.txt
cat ${dir}/head.txt > ${dir}/B32_junctions.txt
cat ${dir}/head.txt > ${dir}/B33_junctions.txt
cat ${dir}/head.txt > ${dir}/BK20801_junctions.txt
cat ${dir}/head.txt > ${dir}/BK20802_junctions.txt
cat ${dir}/head.txt > ${dir}/BK20803_junctions.txt
cat ${dir}/head.txt > ${dir}/K31_junctions.txt
cat ${dir}/head.txt > ${dir}/K32_junctions.txt
cat ${dir}/head.txt > ${dir}/K33_junctions.txt

find /storage/gge/nih/PacBio_IsoSeq/Pool1/RUN* -name "P1*bc1001*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> ${dir}/B31_junctions.txt
find /storage/gge/nih/PacBio_IsoSeq/Pool1/RUN* -name "P1*bc1002*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> ${dir}/B32_junctions.txt
find /storage/gge/nih/PacBio_IsoSeq/Pool1/RUN* -name "P1*bc1003*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> ${dir}/B33_junctions.txt
find /storage/gge/nih/PacBio_IsoSeq/Pool1/RUN* -name "P1*bc1018*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> ${dir}/BK20801_junctions.txt
find /storage/gge/nih/PacBio_IsoSeq/Pool1/RUN* -name "P1*bc1019*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> ${dir}/BK20802_junctions.txt
find /storage/gge/nih/PacBio_IsoSeq/Pool1/RUN* -name "P1*bc1004*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> ${dir}/K31_junctions.txt
find /storage/gge/nih/PacBio_IsoSeq/Pool1/RUN* -name "P1*bc1005*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> ${dir}/K32_junctions.txt
find /storage/gge/nih/PacBio_IsoSeq/Pool1/RUN* -name "P1*bc1006*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> ${dir}/K33_junctions.txt
find /storage/gge/nih/PacBio_IsoSeq/Pool2/RUN* -name "P2*bc1008*junctions.txt" | sort | xargs -I {} tail -n +2 {} >> ${dir}/BK20803_junctions.txt
