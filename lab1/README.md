# Lab 1 Introduction to Linux



1. Install Shell terminal to your Laptop

Install Cygwin 

https://www.pcwdld.com/cygwin-cheat-sheet/

2. Create your lab directory

```sh
cd ~
mkdir <your_user_name>
cd <your_user_name>
mkdir lab1
cd lab1
```

3. Download a file from NCBI

   FTP directory for RefSeq assembly

   https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/

```sh
# download the genome
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz

# download the cds sequences
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_cds_from_genomic.fna.gz

# download protein sequences
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_protein.faa.gz
```



4. how many chromosomes

