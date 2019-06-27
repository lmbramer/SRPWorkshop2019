

makeVolcano <- function(){
      filePath <- "E:/Toxin_Study/RNAseq_Workshop/Norm_Data_Zebrafish_Retene_v_Control.csv"
      data <- read.table(filePath, header=TRUE, sep=",", quote="", stringsAsFactors = FALSE, comment="")

      data <- na.omit(data)
       
      keeps <- c("names", "log2FoldChange", "padj")
      
      data <- data[keeps]
      reg_genes <- subset(data, padj < 0.05)
      reg_genes <- subset(reg_genes, abs(log2FoldChange) > 1)
      up_reg_genes <- subset(reg_genes, log2FoldChange < -1)
      down_reg_genes <- subset(reg_genes, log2FoldChange > 1)
      
      print(head(reg_genes))
      print(paste0("Regulated Genes: ", nrow(reg_genes)))
      print(paste0("Down_Reg Genes: ", nrow(down_reg_genes)))
      print(paste0("Up_Reg Genes: ", nrow(up_reg_genes)))

      with(data, plot(log2FoldChange, -log10(padj), pch=20, main="Volcano plot", xlim=c(-4,4), ylim=c(0,50)))
     
      with(subset(data, padj<.05 ), points(log2FoldChange, -log10(padj), pch=20, col="grey"))
      with(subset(data, abs(log2FoldChange)>1), points(log2FoldChange, -log10(padj), pch=20, col="red"))
      with(subset(data, padj<.05 & abs(log2FoldChange)>1), points(log2FoldChange, -log10(padj), pch=20, col="blue"))
    }
  

      


    

 



