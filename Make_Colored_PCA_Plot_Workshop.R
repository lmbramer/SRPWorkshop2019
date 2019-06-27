library(ggfortify)

PCAPlot <- function(){
  
  filePath <- "E:/Toxin_Study/RNAseq_Workshop/Norm_Data_Zebrafish_Top5k_CV_NoOutliers_Transpose_ExpAdded.csv"
  data1 <- read.table(filePath, header=TRUE, sep=",", row.names=1, quote="", stringsAsFactors=FALSE, comment="")
  
  df <- data1[c(1:5000)]
  
  autoplot(prcomp(df), data = data1, colour = 'Experiment', size = 4)
}














