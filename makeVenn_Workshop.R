library(gplots)

makeVenn <- function(){
  
  filePath <- "E:/Toxin_Study/RNAseq_Workshop/DEGs_5_PAHs.csv"
  data <- read.table(filePath, header=FALSE, sep=",", quote="", stringsAsFactors=FALSE, comment="")
  
  set1 <- data[,1]
  print(length(set1))
  set1 <- set1[set1 != ""]
  print(length(set1))
  
  set2 <- data[,2]
  print(length(set2))
  set2 <- set2[set2 != ""]
  print(length(set2))
  
  set3 <- data[,3]
  print(length(set3))
  set3 <- set3[set3 != ""]
  print(length(set3))
  
  set4 <- data[,4]
  print(length(set4))
  set4 <- set4[set4 != ""]
  print(length(set4))
  
  set5 <- data[,5]
  print(length(set5))
  set5 <- set5[set5 != ""]
  print(length(set5))
  
  venn(list("BbF"=set1, "BjF"=set2, "BkF"=set3, "Carbozole"=set4, "DBahP"=set5))
  
}