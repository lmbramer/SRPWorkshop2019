library(DESeq2)

generateData <- function(){
  print(Sys.time())
  filePath <- "E:/Toxin_Study/RNAseq_Workshop/Raw_Count_Data_Zebrafish.csv"
  countData <- read.table(filePath, header=TRUE, sep=",", quote="", stringsAsFactors=FALSE, comment="")
  dfcountData <- data.frame(countData)
  rownames(dfcountData) <- dfcountData [,1]
  dfcountData [,1] <- NULL
  print(head(dfcountData))
  dfcountData <- round(dfcountData)
  filePath <- "E:/Toxin_Study/RNAseq_Workshop/Zebrafish_Condition_Info_Correct_Names.csv"
  colData <- read.table(filePath, header=TRUE, sep=",", quote="", stringsAsFactors=FALSE, comment="")
  print(head(colData))
  print("--------")
  dfcolData <- data.frame(colData)
  rownames(dfcolData) <- dfcolData [,1]
  dfcolData [,1] <- NULL
  #print(row.names(dfcolData))
  #print(head(dfcolData))
  dds <- DESeqDataSetFromMatrix(countData = dfcountData, colData = dfcolData, design = ~condition)
  print("Crivens")
  #print(dds)
  #ALERT - The line below should be commented out only in datasets lacking biological replicates
  #---------------------------------------
  dds <- DESeq(dds)
  #----------------------------------------
  dds <- estimateDispersionsGeneEst(dds)
  dispersions(dds) <- mcols(dds)$dispGeneEst
  print("Crivens2")
  notAllZero <- (rowSums(counts(dds)) > 0)
  vsd <- varianceStabilizingTransformation(dds)
  normalizedCounts <- assay(vsd[notAllZero,])
  outputFilePath <- "E:/Toxin_Study/RNAseq_Workshop/Norm_Data_Zebrafish.csv"
  write.table(normalizedCounts, file=outputFilePath, quote=FALSE, sep=",", row.names=TRUE, col.names=TRUE)
  print(Sys.time())
  res <- results(dds, contrast=c("condition","A","Q"))
  print(res)
  res$names<-rownames(res)
  outputFilePath <- "E:/Toxin_Study/RNAseq_Workshop/Norm_Data_Zebrafish_Retene_v_Control.csv"
  write.table(res, file=outputFilePath, quote=FALSE, sep=",", row.names=FALSE, col.names=TRUE)
  summary(res) 
  print(Sys.time())
  #print("---------")
  #}
  
}