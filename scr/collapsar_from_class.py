#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pandas as pd
import argparse

def find_most_representative(group):
    """
    Find the most representatives groups of reads to transform it
    """
    most_common_category = group['structural_category'].mode().iloc[0]  # Frecuent category
    filtered_group = group[group['structural_category'] == most_common_category]
    most_common_length = group['length'].mode().iloc[0]  # Frecuent length
    if len(group[group['length'] == most_common_length]) == 1:
        most_common_length = filtered_group['length'].max()  
    filtered_group = group[group['length'] == most_common_length]
    representative_row =  filtered_group[filtered_group['length'] == most_common_length].iloc[0]
    return representative_row


def main(class_file, UJC_file, count_file, gc_cont_file, output_file):
    # Reading files
    class_file = pd.read_csv(class_file, sep="\t", header=0, dtype=str)
    UJC_file = pd.read_csv(UJC_file, names=["isoform", "UJC"], sep="\t", dtype=str)

    # Fusion of tables
    merged_table = pd.merge(UJC_file, class_file, left_on="isoform", right_on="isoform")

    # Apply filter
    most_rep = merged_table.groupby('UJC', as_index=False).apply(find_most_representative) #, include_groups=False)

    gc_cont_file = pd.read_csv(gc_cont_file, names=["isoform", "gc_cont"], sep="\t", dtype=str)
    count_file = pd.read_csv(count_file, names=["FL", "UJC"], sep="\t", dtype=str)

    # 
    tabla_fusionada = pd.merge(most_rep, gc_cont_file, left_on="isoform", right_on="isoform") 
    print(tabla_fusionada.shape)

    # Merge count files
    merged = pd.merge(tabla_fusionada, count_file, on='UJC', how='left', suffixes=('', '_new'))
    merged['FL'] = merged['FL_new']
    merged.drop(columns=['FL_new'], inplace=True)

    # Does write the output file 
    merged.to_csv(output_file, sep='\t', index=False, na_rep='NA')

    # Print confirmation 
    print("Run OK. {}".format(output_file))


if __name__ == "__main__":
    # Set argparse to read file paths
    parser = argparse.ArgumentParser(description="Procesar archivos de entrada y guardar el archivo de salida.")
    parser.add_argument("input_file1", help="Path classification file")
    parser.add_argument("input_file2", help="Path UJC with isoform ids file")
    parser.add_argument("input_file3", help="Path counts file")
    parser.add_argument("input_file4", help="Path gc_content file")
    parser.add_argument("output_file", help="Path to output file")

    args = parser.parse_args()
    
    # Calling to args
    main(args.input_file1, args.input_file2, args.input_file3, args.input_file4, args.output_file)


