# Lab12 Variant Calling



### Preapare environment

```sh
cd ~/btech
mkdir lab12
cd lab12

curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab10/Scerevisiae_renamed.fa -o Scerevisiae_renamed.fa

curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab10/Sbayanus_renamed.fa -o Sbayanus_renamed.fa

curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab12/Sacc_cer.aligned_renamed.sorted.bam -o Sacc_cer.aligned_renamed.sorted.bam

curl -s https://raw.githubusercontent.com/wjidea/BTECH610_Bioinformatics/main/lab12/Sacc_bayanu.aligned_renamed.sorted.bam -o Sacc_bayanu.aligned_renamed.sorted.bam
```



1. Install dependencies

```sh
conda activate btech
conda install -c bioconda bcftools
```
  
for those who has issue with default version bcftools use older version
`conda install bioconda/label/cf201901::bcftools`



2. run bcftools to call variant 

- `-O b` tells bcftools to generate a bcf format output file
- `-o` specifies where to write the output file
- `-f` flags the path to the reference genome

```sh
#S bayanau
bcftools mpileup -O b -o Sacc_cer.renamed.bcf -f Scerevisiae_renamed.fa Sacc_cer.aligned_renamed.sorted.bam

#S cerevisae
bcftools mpileup -O b -o Sacc_bayanus.renamed.bcf -f Sbayanus_renamed.fa Sacc_bayanu.aligned_renamed.sorted.bam
```



3. Identify SNVs using bcftools call

We have to specify ploidy with the flag `--ploidy`, which is one for the haploid *S. cerevisae*. The other parameters are:

- `-m` allows for multiallelic and rare-variant calling
- `-v` tells the program to output variant sites only (not every site in the genome)
- `-o` specifies where to write the output file

```sh
#S bayanu
bcftools call --ploidy 1 -m -v -o Sacc_cer.renamed.vcf Sacc_cer.renamed.bcf

#S cerevisae
bcftools call --ploidy 1 -m -v -o Sacc_bayanus.renamed.vcf Sacc_bayanus.renamed.bcf
```

