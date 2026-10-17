# Title: Lab6 Reproducible
- Author: Your Name
- Date: 10/14

This is my first markdown notebook.

I can make a numbered list:
1. item1
2. item2
3. item3

## Level 2 heading
I can make an unnumbered list
- item1
- item2
- item3

### Level3 heading
I can also make a table
| col1         | col2          | col3        |
| ------------ | ------------- | ----------- |
| DNA          | RNA           | Protein     |
| Genetic code | Transcripts   | Peptide     |
| Double Helix | Single strand | Alpha helix |

### Code block with Python3 example with biopython >= 1.82
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

### Code block with shell example
```sh
mkdir lab6
cd lab6
touch README.md
```

EOF
