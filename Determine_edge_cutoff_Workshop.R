countOnes <- function() {

  inputFilePath <- "E:/Toxin_Study/RNAseq_Workshop/Normalized_Data_Synechococcus_Transpose_WhtMatrix_CLR.csv"
  x <- read.table(inputFilePath, header=TRUE, sep=",", quote="", stringsAsFactors=FALSE)

  edges <- c(10000, 8000, 6000, 4000, 2000, 1000, 500)
  #############_CHECK THIS_#############
  #If the matrix is Pearson or Spearman correlation coeffecients, which are negative and postive be sure to fun the lines below
  diag(x) <- 0
  x <- abs(x)
  print("Did you check to see if this is Pearson/Spearman?")
  #############_CHECK THIS_#############
  
  x_list <- unlist(x)

  x_sort <- sort(x_list, decreasing = TRUE)

  print(max(x_sort))
  print(min(x_sort))

  edge_1 <- x_sort[edges[1]]
  edge_2 <- x_sort[edges[2]]
  edge_3 <- x_sort[edges[3]]
  edge_4 <- x_sort[edges[4]]
  edge_5 <- x_sort[edges[5]]
  edge_6 <- x_sort[edges[6]]
  edge_7 <- x_sort[edges[7]]
  
  included_edges <- c(edge_1, edge_2, edge_3, edge_4, edge_5, edge_6, edge_7)

  outputData <- cbind(Edge_Cutoff=included_edges, edges)

  print(outputData)

}

