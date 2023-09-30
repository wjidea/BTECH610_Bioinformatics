#!/usr/bin/python3
import sys
from Bio import SeqIO
from Bio.SeqUtils import GC

def parse_fasta_file(fasta_file_path):
    sequences = SeqIO.parse(fasta_file_path, "fasta")
    for seq_record in sequences:
        print(seq_record.id, len(seq_record), round(GC(seq_record.seq), 2))

if __name__ == "__main__":
    parse_fasta_file(sys.argv[1])


