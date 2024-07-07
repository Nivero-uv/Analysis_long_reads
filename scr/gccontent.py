#!/usr/bin/env python3

import os
from Bio import SeqIO
from Bio.SeqUtils import gc_fraction
import pandas as pd

# Ruta de la carpeta que contiene los fastas
carpeta = '/home/nivero/Iso_Seq/data/fastas'
carpeta_out='/home/nivero/Iso_Seq/scripts'
# Itera sobre todos los archivos en la carpeta
for archivo in os.listdir(carpeta):
        if archivo.endswith(".fasta"):  # Verifica
             gc_file = archivo.replace(".fasta", "_gc_content.txt")
             ruta_out = os.path.join(carpeta_out, gc_file)
             with open(ruta_out, 'w') as f:
                 ruta_archivo = os.path.join(carpeta, archivo)
                 seq_objects=SeqIO.parse(ruta_archivo,'fasta')
                 sequences=[seq for seq in seq_objects]
                 for seq in sequences:
                     seq_id=seq.id
                     sequence=seq.seq
                     gc_content=gc_fraction(sequence)
                     gc_content=round(gc_content,3)
                     gc_file = archivo.replace(".fasta", "_gc_content.txt")
                     ruta_out = os.path.join(carpeta_out, gc_file)
                     f.write(f"{seq_id}\t{gc_content}\n")

