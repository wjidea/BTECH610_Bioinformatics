# Lab 1 Introduction to Linux

1. Setup Shell terminal on your laptop
   - If you are using a window laptop, you will need to install the virtualbox and ubuntu image
   - If you are using a Mac, you can use the Terminal from your system
   - If you are using a Linux (e.g., Ubuntu), you can use the Terminal from your system




2. Create your lab directory

```sh
NAME="Eric_Smith"  # pay attention to the underscore here
cd ~
mkdir ${NAME}  # NAME is a vairable defined above
cd ${NAME}
mkdir lab1
cd lab1
```

3. Download a file from NCBI

   FTP directory for RefSeq assembly

   https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/

```sh
# download the genome
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz -O ecoli_genome_seq.fna.gz

# download the cds sequences
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_cds_from_genomic.fna.gz -O ecoli_cds_seq.faa.gz

# download protein sequences
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_protein.faa.gz -O ecoli_protein_seq.faa.gz
```



4. Move downloaded genome to a reference folder

```sh
mkdir 
```

