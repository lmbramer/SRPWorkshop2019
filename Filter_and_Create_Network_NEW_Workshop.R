library(igraph)

filterAndCreateNetwork <- function() {

  cutoffs <- c(9.235387)

  print(cutoffs)
  
  inputFilePath <- "E:/Toxin_Study/RNAseq_Workshop/Normalized_Data_Synechococcus_Transpose_WhtMatrix_CLR.csv"
  adjMatWht <- read.table(inputFilePath, header=TRUE, sep=",", quote="", stringsAsFactors=FALSE, check.names = F)
  
  for(n in (1:length(cutoffs))) {
  
    adjMat <- adjMatWht
    
    minZVal <- cutoffs[n]
    print(minZVal)
    
    #############_CHECK THIS_#############
    #If the matrix is Pearson or Spearman correlation coeffecients, which are negative and postive be sure to fun the lines below
    diag(adjMat) <- 0
    adjMat <- abs(adjMat) 
    print("Did you check to see if this is Pearson/Spearman?")
    #############_CHECK THIS_#############
    
    adjMat[adjMat < minZVal] <- 0
    adjMat[adjMat >= minZVal] <- 1
    
    adjMat <- as.matrix(adjMat) 
    
    #-------ALERT ALERT ALERT ---- Take note of the mode argument in the line below-----------
    
    #For any method to make the association matrix excpet for 'GENIE3' the modePicked should be 'undirected'
    modePicked <- "undirected"
    g <- graph.adjacency(adjMat, mode= modePicked) 
    print(modePicked)
    
    #-----------------------------------------------------------------------------------------
    
    g <- delete.vertices(g, which(degree(g) == 0))
    
    outputData <- get.edgelist(g)
    
    outputData <- cbind(outputData[, 1], "C", outputData[, 2])
    
    outputFilePath <- sprintf("E:/Toxin_Study/RNAseq_Workshop/Normalized_Data_Synechococcus_Transpose_WhtMatrix_CLR_Unwht_%s.sif", minZVal)
    write.table(outputData, file=outputFilePath, quote=FALSE, sep=" ", row.names=FALSE, col.names=FALSE)
    print(nrow(outputData))
    
    outputFilePath <- sprintf("E:/Toxin_Study/RNAseq_Workshop/Normalized_Data_Synechococcus_Transpose_WhtMatrix_CLR_Unwht_%s.graphml", minZVal)
    write.graph(g, outputFilePath, format="graphml")
    
    print("Done with CreateNetwork")

  }
}


