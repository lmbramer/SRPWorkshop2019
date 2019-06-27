library(ggplot2)
library(gplots)
library(igraph)
library(plyr)


findCommunities <- function()
{
  minModuleSize = 12
  cutoffs <- c(9.235387)
  
  for(i in (1:length(cutoffs))) {
    cutoff <- cutoffs[i]
    
    inputFilePath <- sprintf("E:/Toxin_Study/RNAseq_Workshop/Normalized_Data_Synechococcus_Transpose_WhtMatrix_CLR_Unwht_%s.graphml", cutoff)
    g <- read_graph(inputFilePath, format="graphml")
    
    wc <- fastgreedy.community(g)
    
    modMembership <- data.frame(GeneID=wc$names, ModuleID=wc$membership, stringsAsFactors=FALSE)
    
    modSizes <- count(modMembership, vars="ModuleID")
    mods2Keep <- modSizes[modSizes$freq >= minModuleSize, "ModuleID"]
    
    outputData <- modMembership[modMembership$ModuleID %in% mods2Keep, ]
    outputFilePath <- sprintf("E:/Toxin_Study/RNAseq_Workshop/Normalized_Data_Synechococcus_Transpose_WhtMatrix_CLR_Unwht_%s_Min12_Mods.csv", cutoff)
    write.table(outputData, file=outputFilePath, quote=FALSE, sep=",", row.names=FALSE, col.names=TRUE)

    outputData <- modSizes[modSizes$ModuleID %in% mods2Keep, ]
    colnames(outputData) <- c("ModuleID", "Size")
    outputFilePath <- sprintf("E:/Toxin_Study/RNAseq_Workshop/Normalized_Data_Synechococcus_Transpose_WhtMatrix_CLR_Unwht_%s_Min12_Mods_Sizes.csv", cutoff)
    write.table(outputData, file=outputFilePath, quote=FALSE, sep=",", row.names=FALSE, col.names=TRUE)
    print("Done with findCommunities")
  }
}