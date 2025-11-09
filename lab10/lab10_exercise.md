# Lab 10 Sequence Alignment

1. Create your lab directory

```sh
cd ~  # change to home directory
cd btech 
mkdir lab10
cd lab10
```

2. activate btech conda environment

```sh
conda activate btech
```

3. Install packages with conda

```sh
conda config --add channels bioconda
conda config --add channels conda-forge
conda install -y samtools==1.21 bwa
conda update --all # optional, run this line if see errors while running samtools. 
```


4. Download reference genome and raw reads

```sh
curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab10/Sacc.R1.filter_fastq.gz -o Sacc.R1.filter_fastq.gz

curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab10/Sacc.R2.filter.fastq.gz -o Sacc.R2.filter.fastq.gz

curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab10/Scerevisiae_renamed.fa -o Scerevisiae_renamed.fa

curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab10/Sbayanus_renamed.fa -o Sbayanus_renamed.fa
```



5. Run `bwa` and `samtools` to generate genome index

```sh
# samtool fasta index
samtools faidx Sbayanus_renamed.fa
samtools faidx Scerevisiae_renamed.fa

# bwa bw transformation index
bwa index Sbayanus_renamed.fa
bwa index Scerevisiae_renamed.fa
```



6. Align reads to reference genome

```sh
bwa mem Scerevisiae_renamed.fa Sacc.R1.filter_fastq.gz Sacc.R2.filter.fastq.gz > Sacc_cer.aligned_renamed.sam

bwa mem Sbayanus_renamed.fa Sacc.R1.filter_fastq.gz Sacc.R2.filter.fastq.gz > Sacc_bayanu.aligned_renamed.sam
```



7. convert sam to bam and sort by chromosome and coordinates

```sh
samtools view -Sb Sacc_cer.aligned_renamed.sam > Sacc_cer.aligned_renamed.bam
samtools view -Sb Sacc_bayanu.aligned_renamed.sam > Sacc_bayanu.aligned_renamed.bam
samtools sort -o Sacc_bayanu.aligned_renamed.sorted.bam Sacc_bayanu.aligned_renamed.bam
samtools sort -o Sacc_cer.aligned_renamed.sorted.bam Sacc_cer.aligned_renamed.bam
```



8. check alignment flag summary statistics

```sh
samtools flagstats Sacc_bayanu.aligned_renamed.sorted.bam
samtools flagstats Sacc_cer.aligned_renamed.sorted.bam
```



9. create bam index

```sh
samtools index Sacc_cer.aligned_renamed.sorted.bam
samtools index Sacc_bayanu.aligned_renamed.sorted.bam
```



10. Download and install IGV

https://igv.org/doc/desktop/#DownloadPage/

11. add reference genome to IGV
1. select Genomes in the menu bar
2. select load genome from file
3. select the file Scerevisiae_renamed.fa

12. load alignment
1. select file in the menu bar
2. select Load from file
3. load the file Sacc_cer.aligned_renamed.sorted.bam

13. Zoom in and check sequences
1. use the zoom tool on the top right corner of the IGV window
2. click the plus button a few time until you can see the aligned reads in the window

