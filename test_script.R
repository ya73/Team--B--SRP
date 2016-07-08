# R script for PIR vs normal
setwd("~/cummeRbund_test")
library("cummeRbund", lib.loc="/usr/lib/R/site-library")

# make db
cuff_data <- readCufflinks('test_cuffdiff')

# density
den <- csDensity(genes(cuff_data))
den

# scatterplot of all genes
sca <- csScatter(genes(cuff_data),'q1','q2')
plot(sca)

# volcanoplot
vol <- csVolcano(genes(cuff_data),'q1','q2')
plot(vol)

#plot expression
gene1 <- getGene(cuff_data, 'Shprh')
expressionBarplot(gene1)

#plot isoform
expressionBarplot(isoforms(gene1))

str(cuff_data)

