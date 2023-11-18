N_genes = 10000
lambdas = seq(1,1000, len=N_genes) #creates 10000 evenly-spaced numbers 
rep1 = rpois(N_genes, lambdas)
rep2 = rpois(N_genes, lambdas)
non_zero = which(rep1>0 & rep2>0)
lambdas = lambdas[non_zero]
rep1 = rep1[non_zero]
rep2 = rep2[non_zero]
rna_sim = data.frame(lambdas, rep1, rep2)

library(ggplot2)
ggplot(rna_sim, aes(x=lambdas, y=log2(rep1/rep2))) + geom_point(size=0.5)

