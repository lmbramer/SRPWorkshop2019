library(gplots)
library(stats)
library(clusterSim)
library(cividis)

makeHeatMap <- function(){
  filePath <- "E:/Toxin_Study/RNAseq_Workshop/Norm_Data_Zebrafish_Top500_CV_NoOutliers_RepsAv.csv"
  data <- read.table(filePath, header=TRUE, sep=",", row.names=1, quote="", stringsAsFactors=FALSE, comment="")

  print(head(data))

  data <- data.Normalization (data,type="n9",normalization="row")
  data <- log2(data)

  print(head(data))

  #my_palette <- colorRampPalette(c("blue", "yellow"))(n = 299)
  heatmap.2(as.matrix(data), trace = "none", Rowv = T, Colv = T, key = T, margins = c(10,10), col=cividis(n=299), breaks = seq(-0.20, 0.20, length.out = 300))

}

