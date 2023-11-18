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
