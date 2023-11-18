# Lab11 Transcriptomics - RNAseq analysis



### Preapare environment

```sh
cd ~/btech
mkdir example_rnaseq
cd example_rnaseq
mkdir 1_clean_qc 2_mapping 3_feature_count 4_DE_analysis data ref


conda activate
conda install -c bioconda sra-tools
```

if conda install failed, we can downloaded compiled binaries from its source

https://github.com/ncbi/sra-tools



Fastq-dump explained (good reading)

https://github.com/ncbi/sra-tools/wiki/HowTo:-fasterq-dump/32262a567c820086136796b49e4275dfe91bbc5b



### 1, download data from SRA and extract fastq files

```sh
# download SRR4785492 from SRA
fasterq-dump SRR4785492
fasterq-dump SRR4785493
fasterq-dump SRR4785494

# rcd 1-1 mock
fasterq-dump SRR4785495
fasterq-dump SRR4785496
fasterq-dump SRR4785497

# Download treated group
fasterq-dump SRR4785504
fasterq-dump SRR4785505
fasterq-dump SRR4785506
```



### 2, Preprocessing - trim adpater and low quality bases

Trim low-quality sequence and adapters

```sh
# loading modules to $PATH
module load Trimmomatic/0.36

for file in data/*.fastq.gz; do
  prefix=`basename ${file%%.fastq.gz}`
  java -jar $TRIM/trimmomatic SE -threads 1 $file 1_clean_qc/${prefix}_trim.fq.gz \
  ILLUMINACLIP:ref/TruSeq3-SE.fa:2:15:8 \
  LEADING:5 TRAILING:5 SLIDINGWINDOW:4:15 MINLEN:17
done
```



### 3. align read to reference genome



```sh
# build index
mkdir ref/STAR_index
STAR --runThreadN 4 --runMode genomeGenerate \
  --genomeDir ref/STAR_index  \
  --genomeFastaFiles ref/TAIR10_Chr.all.fasta  \
  --sjdbGTFfile ref/Araport11_GFF3_genes_transposons.201606.gtf

cd 2_mapping
# mapping read to genome
for file in ../1_clean_qc/*.fq.gz; do
  prefix=`basename ${file%%_trim.fq.gz}`
  STAR  --genomeDir ../ref/STAR_index \
    --runThreadN 12 \
    --readFilesIn $file \
    --outFilterMismatchNmax 8 \
    --outFilterMultimapNmax 1 \
    --alignIntronMax 8000 \
    --outSAMstrandField intronMotif \
    --outSAMattributes Standard  \
    --readFilesCommand zcat \
    --outFileNamePrefix ${prefix} \
    --outReadsUnmapped Fastx \
    --outStd SAM  | samtools sort -@8 -O bam -o ${prefix}_trim.bam
done
```



### 4, featureCounts

- preapare featureCount data

```sh
find . -name '*.bam' -exec readlink -f {} \; > bamList.txt

TRT	FeatureCountsFile
wild_mock	/data/run/wangj/data/tmp/example_rnaseq/2_mapping/SRR4785504_trim.bam
wild_mock	/data/run/wangj/data/tmp/example_rnaseq/2_mapping/SRR4785505_trim.bam
wild_mock	/data/run/wangj/data/tmp/example_rnaseq/2_mapping/SRR4785506_trim.bam
rcd_mock	/data/run/wangj/data/tmp/example_rnaseq/2_mapping/SRR4785495_trim.bam
rcd_mock	/data/run/wangj/data/tmp/example_rnaseq/2_mapping/SRR4785496_trim.bam
rcd_mock	/data/run/wangj/data/tmp/example_rnaseq/2_mapping/SRR4785497_trim.bam
DC3000	/data/run/wangj/data/tmp/example_rnaseq/2_mapping/SRR4785492_trim.bam
DC3000	/data/run/wangj/data/tmp/example_rnaseq/2_mapping/SRR4785493_trim.bam
DC3000	/data/run/wangj/data/tmp/example_rnaseq/2_mapping/SRR4785494_trim.bam
```



Prepare featurecount Rscript

```sh
#!/opt/software/R/3.3.1--GCC-4.4.7/bin/Rscript

library("limma")
library("edgeR")
library("Rsubread")

setwd("/data/run/wangj/data/tmp/example_rnaseq/3_feature_count")

targets <- readTargets("/data/run/wangj/data/tmp/example_rnaseq/2_mapping/bamList.txt", sep="")

fc <- featureCounts(files=targets$FeatureCountsFile,
annot.ext="/data/run/wangj/data/ARCHIVE/sharkeyLab/Isoprene_B2EB3/Atha/genome/Araport11_representative_genes.201606.gtf",
isGTFAnnotationFile=TRUE,
GTF.featureType="exon",
GTF.attrType="gene_id",
chrAliases=NULL,
useMetaFeatures=TRUE,
allowMultiOverlap=FALSE,
readExtension5=0,
readExtension3=0,
read2pos=NULL,
countMultiMappingReads=FALSE,
minMQS=0,
ignoreDup=FALSE,
strandSpecific=0,
checkFragLength=FALSE,
minFragLength=50,
maxFragLength=600,
countChimericFragments=TRUE,
nthreads=20,
reportReads=TRUE)

save(fc, file='design1.Rdata')
```



### work in R/Rstudio

```R
# install packages is absent
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(c("edgeR","limma", "Glimma"))
install.packages(c("gplots", "RColorBrewer", "dplyr", "ggplot2"))

getwd()
library(edgeR)
library(limma)
library(Glimma)
library(gplots)
library(RColorBrewer)
library(dplyr)
library(ggplot2)

# set working directory and load data
setwd("~/btech/lab11/")
load("design1.Rdata")
getwd()
changeName <- function(str){
  fileName <- strsplit(str, '\\.')[[1]][9:10]
  fileName_1 <- paste(fileName[1], '_', fileName[2], sep = '')
  fileName_2 <- gsub("_trim_bam", '', fileName_1)
  return(fileName_2)
}

# set experimental design matrix
trt <- factor(c(rep("wild_mock",3), rep("rcd_mock",3), rep("rcd_DC3000",3)))
mat <- model.matrix(~ trt)

# Creates a DGEList object 
x <- DGEList(counts=fc$counts, genes=fc$annotation[,c("GeneID","Length")])
x <- calcNormFactors(x, method="TMM")  ### TMM Normalization
x_rpkm <- rpkm(x, x$genes$Length)

# rename the column names
colnames(x$counts) <- unname(unlist(sapply(colnames(x$counts), changeName)))
rownames(x$samples) <- unname(unlist(sapply(rownames(x$samples), changeName)))
colnames(x_rpkm) <- unname(unlist(sapply(colnames(x_rpkm), changeName)))


# filter low expression genes
# filter with at least 3 samples expressed with more than 1 CPM
x_cpm <- cpm(x)
isexpr <- rowSums(cpm(x) > 1) >= 3
table(isexpr)
x_minimal <- x[isexpr,] 
counts.keep <- fc$counts[isexpr,]
y <- DGEList(counts.keep)
colnames(y) <- unname(mapply(changeName, colnames(y)))

##############################
# Visulize lib size in barplot
##############################

# lib size variations
barplot(y$samples$lib.size,names=colnames(y),las=2)
title("Barplot of library sizes")


###############
# make MDS plot
###############

samples <- colnames(x_rpkm)
sampleInfo <- data.frame(cbind(samples, trt))

col.cell <- c(rep('red', 3),rep('blue', 3),rep('green', 3))
pch.cell <- c(1,1,1,2,2,2,3,3,3)
plotMDS(y, col=col.cell, xlab="Coordinate 1", ylab="Coordinate 2", pch=pch.cell, cex = 1.5)
title("Sample treatment multidimensional scaling plot")
legend("topleft", xpd = TRUE,
       # legend = unique(sampleInfo$combine),
       legend = unique(trt),
       col = unique(col.cell),
       pch = unique(pch.cell),
       cex=0.7,ncol=2)


###############
# run voom stats
###############

x_minimal <- x[isexpr,] 
v <- voom(x_minimal,design=mat,plot=TRUE) 
fit <- lmFit(v, mat) # where v is a voom object

fit_log2 <- treat(fit, lfc=log2(2))
tt_log2 <- topTreat(fit_log2, coef = 2, number = dim(x_rpkm)[1])
tt_log2_p_filter <- tt_log2[tt_log2$adj.P.Val < 0.01,] # has 1162 genes
dim(tt_log2_p_filter)

tt_log2_p_filter

###############
# heatmap
###############

logcounts <- cpm(y, log = TRUE)
mypalette <- c("darkblue", 'white', 'red')
morecols <- colorRampPalette(mypalette)

col.cell <- c(rep('red', 3),rep('blue', 3),rep('green', 3))

select_var <- rownames(tt_log2_p_filter)
highly_variable_lcpm <- logcounts[rownames(logcounts) %in% select_var,]

heatmap.2(highly_variable_lcpm,col=morecols(50),trace="none",
          # heatmap.2(highly_variable_lcpm,col=c("blue", 'white', 'red'),trace="none",
          main="Differentially expressed genes ",
          ColSideColors=col.cell, scale="row", cexRow = 0.2,
          key.title = 'Color key', cexCol = 0.7, offsetCol = 0.01)


###############
# Look into specific genes across conditions
###############

gene_of_interest <- "AT3G50770"

gene1 <- as.data.frame(cbind(x_rpkm[gene_of_interest,], sampleInfo))
colnames(gene1) <- c("fpkm", "samples", "trt")
gene1$trt <- as.factor(gene1$trt)

sumMean <- gene1 %>% 
  group_by(trt) %>%
  summarise(
    n = length(fpkm),
    mean = mean(fpkm),
    sd = sd(fpkm),
    se = sd / sqrt(n)
  )

# bar plot
ggplot(sumMean, aes(x = trt, y = mean)) + 
  geom_bar(stat="identity", position=position_dodge()) + 
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se), width=.2,
                position=position_dodge(.9)) +
  ggtitle(paste("Gene: ",gene_of_interest)) 

# box plot
ggplot(gene1, aes(x = trt, y = fpkm)) + geom_boxplot() +
  geom_point(aes(color=factor(trt)),position=position_dodge(width=0.5))

# adjusted pvalue histogram
hist(tt_log2_p_filter$adj.P.Val)


```

