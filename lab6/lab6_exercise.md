# Lab 6 Reproducible Research

1. Create your lab directory

```sh
cd ~  # change to home directory
mkdir btech
cd btech 
mkdir lab6
cd lab6
```

2. activate btech conda environment

```sh
conda activate btech
```

3. register an account on GitHub

Follow the link here to sign up an account with GitHub

https://github.com/

4. Create a new repository to your GitHub account

https://github.com/new

repository name: btech610

Make it public  and click create repository button



5. git for version control

```sh
git --version
```

git version 2.21.0 (Apple Git-122)

if you don't have git

- MacOS
  - `brew install git`
- Ubuntu
  - `sudo apt update`
  - `sudo apt install git`

6. set git config



```sh
git config --global user.name "your git user name"
git config --global user.email "your email address here"
```



7. create a markdown notebook

Make some modifications to the code block below and save it to a `README.md` file to lab6 directory

````markdown
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
````

Let's save the above code block into a `README.md` file

8. Create your own personal Github Token

Settings -> Developer settings -> Personal access tokens -> Tokens (classic) -> Generate New Token (classic)

- Write a note to your token

- set an expiration date -> Custom -> 12/31/2025

- Check all boxes under repo

- Click Generate token button 

**Make sure to copy your personal access token now. You won’t be able to see it again!**



9. create a new repository on the command line

replace `<MY_USERNAME>` with your github username

replace `<MYTOKEN>` with token generated above 

```sh
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://<MY_USERNAME>:<MYTOKEN>@github.com/<MY_USERNAME>/btech610.git
git push -u origin main
```

Below is an example with my login information. 

```sh
echo "# btech2" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://jwstmary:github.com/jwstmary/btech2.git
git push -u origin main
```



12. Now you should be able to see your `README.md` file

