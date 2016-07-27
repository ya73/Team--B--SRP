# Rscript  for genome RN4 genome whihc takes a gene name as an argument searches cuff_diff output and outputs a position
args <- commandArgs(trailingOnly = TRUE)
#uses cummeRbund functions 
library("cummeRbund")
#make db object
cuff_data <- readCufflinks('cuff_diff_RN4')
#make gene object
gene1 <- getGene(cuff_data, args[1])
#part of that genes attributes contains the location 
print(attributes(gene1)$annotation$locus)
