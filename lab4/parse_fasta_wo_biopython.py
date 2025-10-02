#!/usr/bin/python3

import sys

def parse_fasta_file(fasta_file_path):
    fh = open(fasta_file_path)
    seq = ""
    seq_name=""
    for line in fh.readlines():
        if line.startswith('>'):
            if len(seq_name) > 0:
                print(seq_name, len(seq), gc_fraction(seq))
            seq_name = line.split(' ')[0][1:]
            seq = ""
        else:
            seq += line.rstrip()
    print(seq_name, len(seq), gc_fraction(seq))
    fh.close()

def gc_fraction(seq):
    GC_bases = seq.count('G') + seq.count('g') + seq.count('C') + seq.count('c')
    return round(GC_bases/len(seq), 2)

if __name__ == "__main__":
    parse_fasta_file(sys.argv[1])