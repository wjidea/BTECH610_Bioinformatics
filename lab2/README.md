# Lab 2 Introduction to Linux

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

   Escherichia coli str. K-12 substr. MG1655, complete genome

   FTP directory for RefSeq assembly
   
   https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/

```sh
# download the genome
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz -O ecoli_genome_seq.fna.gz

# download the cds sequences
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_cds_from_genomic.fna.gz -O ecoli_cds_seq.fna.gz

# download protein sequences
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_protein.faa.gz -O ecoli_protein_seq.faa.gz

# download genome annotation
wget -c https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.gtf.gz -O ecoli_genome_annotation.gtf.gz
```

decompress those files

```sh
gunzip ecoli_genome_seq.fna.gz

gunzip ecoli_cds_seq.fna.gz

gunzip ecoli_protein_seq.faa.gz

gunzip ecoli_genome_annotation.gtf.gz
```





4. Move downloaded genome to a reference folder

```sh
cd ~/you_name_dir/
mkdir reference
cd reference

mv ecoli_genome_seq.fna ecoli_cds_seq.faa ecoli_protein_seq.faa ecoli_genome_annotation.gtf
```







9. Questions from presentation

How many chromosomes in the genome, estimate the genome size?

```sh
# hint
gzcat ecoli_genome_seq.fna.gz | grep '>' -v | wc -l -c
```

How many cds sequence record in the fasta file? What is the gene density here # genes/Mbp?

```sh
# hint: get familiar with fasta format
```

What is the last gene record name in CDS file?

```sh
# hint: tail
```

