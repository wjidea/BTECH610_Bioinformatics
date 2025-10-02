# Lab 4 Biopython

1. Create your lab directory

```sh
cd ~  # change to home directory
mkdir btech # create btech directory if you don't have one
cd btech 
mkdir lab4
cd lab4
```


2. Let's start a Terminal session first

Activate the btech conda environment

```sh
conda activate btech
python -V
```

If you install the conda environment with python=3.10, you should see the following message

```sh
Python 3.10.13
```

Prepare files for today's exercise

```sh
curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/refs/heads/main/lab4/parse_fasta_wo_biopython.py -o parse_fasta_wo_biopython.py

curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/refs/heads/main/lab4/parse_fasta_biopython.py -o parse_fasta_biopython.py

curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/refs/heads/main/lab4/ecoli_cds_seq.faa -o ecoli_cds_seq.faa

```


3. Let's answer the questions from the lecture 

   1. Write Python script to parse a Fasta file without using Biopython package, print the sequence name and sequence length to the stdout using a tab delimiter

   ```python
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
   ```

   Let's look at this gc_fraction function, does this function consider all the possible conditions? If not, how can we improve it? Hint: IUPAC code

   
   We can test it with the following python command
   ```sh
   python parse_fasta_wo_biopython.py ecoli_cds_seq.faa
   ```

   

   2. Write Python script to parse a Fasta file using Biopython package, print the sequence name, sequence length, and GC content percentage to the stdout using a tab delimiter

```sh
# install biopython with conda
conda install biopython
```

   run biopython

   ```python
   #!/usr/bin/python3
   import sys
   from Bio import SeqIO
   from Bio.SeqUtils import gc_fraction
   
   def parse_fasta_file(fasta_file_path):
       sequences = SeqIO.parse(fasta_file_path, "fasta")
       for seq_record in sequences:
           print(seq_record.id, len(seq_record), round(gc_fraction(seq_record.seq), 2))
   
   if __name__ == "__main__":
       parse_fasta_file(sys.argv[1])
   
   ```

```sh
python parse_fasta_biopython.py ecoli_cds_seq.faa
```

4. Translate CDS into protein sequences

Write a script to translate coding sequence (CDS) into Protein
Use dictionary to lookup codons to convert to amino acid 

```sh
ATGTGCCGGCACTCGTTACGTAGTGATGGCGCAGGATTCTACCAGCTTGCGGGGTGTGAATACAGCTTTTCCGCGATAAA
AATTGCAGCAGGCGGTCAGTTTCTTCCCGTGATTTGCGCCATGGCAATGAAAAGCCACTTCTTTCTGATTTCGGTACTCA
ATCGCCGGTTAACCTTGACCGCTGTACAAGGTATACTCGGACGATTTTCACTGTTTTGA
```



```python 
cds_seq = "ATGTGCCGGCACTCGTTACGTAGTGATGGCGCAGGATTCTACCAGCTTGCGGGGTGTGAATACAGCTTTTCCGCGATAAAAATTGCAGCAGGCGGTCAGTTTCTTCCCGTGATTTGCGCCATGGCAATGAAAAGCCACTTCTTTCTGATTTCGGTACTCAATCGCCGGTTAACCTTGACCGCTGTACAAGGTATACTCGGACGATTTTCACTGTTTTGA"

genetic_codon = {
    "GCT": "A", "GCC": "A", "GCA": "A", "GCG": "A",
    "TGT": "C", "TGC": "C",
    "GAT": "D", "GAC": "D",
    "GAA": "E", "GAG": "E",
    "TTT": "F", "TTC": "F",
    "GGT": "G", "GGC": "G", "GGA": "G", "GGG": "G",
    "CAT": "H", "CAC": "H",
    "ATA": "I", "ATT": "I", "ATC": "I",
    "AAA": "K", "AAG": "K",
    "TTA": "L", "TTG": "L", "CTT": "L", "CTC": "L", "CTA": "L", "CTG": "L",
    "ATG": "M",
    "AAT": "N", "AAC": "N",
    "CCT": "P", "CCC": "P", "CCA": "P", "CCG": "P",
    "CAA": "Q", "CAG": "Q",
    "CGT": "R", "CGC": "R", "CGA": "R", "CGG": "R", "AGA": "R", "AGG": "R",
    "TCT": "S", "TCC": "S", "TCA": "S", "TCG": "S", "AGT": "S", "AGC": "S",
    "ACT": "T", "ACC": "T", "ACA": "T", "ACG": "T",
    "GTT": "V", "GTC": "V", "GTA": "V", "GTG": "V",
    "TGG": "W",
    "TAT": "Y", "TAC": "Y",
    "TAA": "*", "TAG": "*", "TGA": "*"
}

# Write your code here:
# Hint1: make sure len(seq)%3==0
# Hint2: use range. For example: range(1, len(seq), 3)


```





3. To quit interactive python

```python 
>>> exit()
```

