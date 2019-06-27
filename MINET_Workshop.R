library(minet)

mutualInfo <- function()
{
filePath <- "E:/Toxin_Study/RNAseq_Workshop/Normalized_Data_Synechococcus_Transpose.csv"
data <- read.table(filePath, header=TRUE, sep=",", quote="", stringsAsFactors=FALSE, comment="", check.names = F)

print(data[4,4])

net1 <- build.mim(data)

print("Done with Build MIM")

net2 <- clr(net1)

writePath <- "E:/Toxin_Study/RNAseq_Workshop/Normalized_Data_Synechococcus_Transpose_WhtMatrix_CLR.csv"
write.table(net2, file=writePath, quote=FALSE, sep=",", col.names=TRUE, row.names=FALSE)

}