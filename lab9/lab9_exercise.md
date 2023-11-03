# Lab 9 DNA Sequencing Technologies

1. Create your lab directory

```sh
cd ~  # change to home directory
cd btech 
mkdir lab9
cd lab9
```

2. activate btech conda environment

```sh
conda activate btech
```

3. Install package with conda

```sh
conda install -y fastp
```



4. Download Raw Reads

```sh
curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab9/Sacc.R1.fastq.gz -o Sacc.R1.fastq.gz 

curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab9/Sacc.R2.fastq.gz -o Sacc.R2.fastq.gz 
```



5. Run `fastp` to filter raw reads and get reports

```sh
fastp -i Sacc.R1.fastq.gz -I Sacc.R2.fastq.gz -o Sacc.R1.filter_fastq.gz -O Sacc.R2.filter.fastq.gz -h Sacc_R12.fastp.html
```



6. Check fastp filter results

```sh
open Sacc_R12.fastp.html
```

