# Lab 2 Introduction to Linux Part 2

1. Create your lab directory

```sh
NAME="change_you_name_here" # change your name in your home directory
cd ~
mkdir ${NAME}  # NAME is a vairable defined above
cd ${NAME}
mkdir lab2
cd lab2
```



2. Download a file from NCBI

Escherichia coli str. K-12 substr. MG1655, complete genome

FTP directory for RefSeq assembly

https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/

Prepare directories

```sh
cd ${NAME}
mkdir ref
cd ref
```

Download genomic files 

```sh
# download the genome
curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz -o ecoli_genome_seq.fna.gz

# download the cds sequences
curl -s  https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_cds_from_genomic.fna.gz -o ecoli_cds_seq.fna.gz

# download protein sequences
curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_protein.faa.gz -o ecoli_protein_seq.faa.gz

# download genome annotation
curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.gtf.gz -o ecoli_genome_annotation.gtf.gz

# download feature counts
curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_feature_count.txt.gz -o ecoli_feature_count.txt.gz

# download feature table
curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_feature_table.txt.gz -o ecoli_feature_table.txt.gz
```

To understand all the files downloaded here, you can read the README.txt file here:

https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/README.txt



Decompress those files

```sh
gunzip ecoli_genome_seq.fna.gz
gunzip ecoli_cds_seq.fna.gz
gunzip ecoli_protein_seq.faa.gz
gunzip ecoli_genome_annotation.gtf.gz
gunzip ecoli_feature_count.txt.gz
gunzip ecoli_feature_table.txt.gz
```

Avoid redundancy, you may run `gunzip` next time. 

```sh
for file in *.gz; do 
  gunzip $file; 
done
```



3. Creating symbolic links from ref folder to lab2 folder

```sh
cd ~/${NAME}/lab2/

# create symbolic links to lab 2 folder
ln -s ../ref/ecoli_genome_seq.fna .
ln -s ../ref/ecoli_cds_seq.fna .
ln -s ../ref/ecoli_protein_seq.faa .
ln -s ../ref/ecoli_genome_annotation.gtf .
ln -s ../ref/ecoli_feature_count.txt.gz .
```

Can you convert this 5 command using a loop statement?

```sh
```



4. Get all the chromosome names

```sh
grep '>' ecoli_genome_seq.fna
```

How can you get the chromosome names with the GTF file? Try it with cut, sort, and uniq

```sh
```



5. Count how many genes in *E. coli* genome

Let's count from the protein sequence file first

```sh
grep -c '>' ecoli_protein_seq.faa
```

How many genes records in the `ecoli_cds_seq.faa`?

```sh

```

How many genes features in the `ecoli_genome_annotation.gtf`?

```sh
```



What did you notice? and why?



6. NCBI annotation feature counts

Let's take a look at the NCBI annotation featue counts file

```sh
less ecoli_feature_count.txt.gz
```

Try explore the file with your awk commands



Count how many genes?

```sh
awk -F"\t" 'BEGIN{sum=0} {if($1=="gene") sum += $7} END{print sum}' ecoli_feature_count.txt
```

How many protein coding gene and CDS?

```sh
awk -F"\t" '{if($1=="gene" && $2=="protein_coding") print $7}' ecoli_feature_count.txt

awk -F"\t" '{if($1=="CDS" && $2=="with_protein") print $7}' ecoli_feature_count.txt
```

Why are they different? 

```sh
# hint isoforms

```





7. install miniconda

https://docs.conda.io/projects/miniconda/en/latest/

if you are using a Intel-chip mac, download [Miniconda3 macOS Intel x86 64-bit bash](https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh)

if you are using a apple silicon-chip mac, download [ Miniconda3 macOS Apple M1 64-bit bash](https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh)

if you are using a ubuntu system: download [Miniconda3 Linux 64-bit](https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh)

You can download with the following command

```sh
# Ubuntu
curl -s https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o Miniconda3-latest-Linux-x86_64.sh

# install miniconda
bash Miniconda3-latest-Linux-x86_64.sh
```

it will prompt you to answer a few questions. 



Create conda environment

```sh
conda create -n btech python=3.10
```



8. install seqkit with miniconda

```sh
conda activate btech
conda install -c bioconda seqkit
```



seqkit usages

```sh
seqkit stats -a ecoli_genome_seq.fna
```



Try some other functions, sequence to tabular data `seqkit fx2tab`



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

