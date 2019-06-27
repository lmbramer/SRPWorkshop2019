library(vegan)


findOutliers <- function(){
  filePath <- "E:/Toxin_Study/RNAseq_Workshop/Norm_Data_Zebrafish_Top5k_CV.csv"
  data <- read.table(filePath, header=TRUE, sep=",", row.names=1, quote="", stringsAsFactors=FALSE, comment="")

  data <- t(data)

  outlier_test <- metaMDS(data)
  plot(outlier_test, display = "sites", type = "t", cex = 0.65)


}
