library(tidyverse)
library(ggplot2)
library(dplyr)
library(reshape2)
library(trelliscopejs)

# read in normalized data #
data = read.csv("Subset_Norm_Data_Zebrafish.csv", stringsAsFactors = F)

# read in DESeq2 results #
deseq_res = read.csv("Subset_DESeq2_results.csv", stringsAsFactors = F)

# Read in sample meta data #
meta_data = read.csv("Zebrafish_Subset_Condition_Info.csv", stringsAsFactors = F)

#### Preprocess Data ####
# turn data into "long form" (i.e. one column for a value to be plotted on an axis) #
temp = melt(data, id.var = "Gene")

# take a look #
head(temp)

# get rid of it and name columns at the same time #
rm(temp)

# turn data into "long form" with appropriate column names #
melt_data = melt(data, id.var = "Gene", variable.name = "Sample", value.name = "Norm_Count")

# merge data with sample group information #
mydata = merge(x = melt_data, y = meta_data, by = "Sample", all.x = T, all.y = T)

# divide the data by gene and nest #
nested_data = mydata %>% group_by(Gene) %>% nest()

# look at data for one gene's worth of data #
nested_data$data[[1]]


#### create a plot function which will be applied to each Gene ####

# we need to write a function to plot one gene's data #
# set an example dataset to program around #
x = nested_data$data[[1]]

boxplot_fn <- function(x){
  ggplot(data = x, aes(x = Group, y = Norm_Count, color = Group)) +
    geom_boxplot() +
    geom_point() +
    theme_bw() +
    guides(color = F) +
    ylab("Normalized Count") +
    theme(axis.text = element_text(size = 12), axis.title = element_text(size = 14))
    
}

# test the function #
boxplot_fn(x)

# apply and save the plot for each gene #
nested_data2 = nested_data %>% mutate(panel = map_plot(.x = data, .f = boxplot_fn))

# take a look #
head(nested_data2)

nested_data2$panel[[5]]

# send the plots to trelliscope #
nested_data2 %>% trelliscope(name = "gene_boxplots", desc = "Boxplot comparing retene and control samples", path = "/Users/bram489/Desktop/my_trelliscope_displays", thumb = T, auto_cog = T)

#### prepare deseq results ####
# add a column that only contains gene information before "." #
deseq_res$Partial_Gene = unlist(lapply(strsplit(as.character(deseq_res$Gene), "\\."), function(x) x[1]))

# divide our deseq data by Gene and nest #
deseq_nest = deseq_res %>% group_by(Gene) %>% nest()

names(deseq_nest)[2] = "stats"

# merge with our nested data #
all_data = nested_data2 %>% inner_join(deseq_nest, by = "Gene")

# define our own cognostics #
x = all_data$stats[[1]]

cog_fn <- function(x){
  url = paste("https://uswest.ensembl.org/Danio_rerio/Gene/Summary?g=", x$Partial_Gene, sep = "")
  tibble(
    log2FC = cog(x$log2FoldChange, desc = "Log2 fold-change retene/control", type = "numeric"),
    pvalue = cog(x$pvalue, desc = "pvalue for comparing retene and control", type = "numeric"),
    adj_pvalue = cog(x$padj, desc = "adjusted pvalue for comparing retene and control", type = "numeric"),
    zebrafishDB_url = cog_href(url, desc = "link to zebrafish gene database", default_label = T)
  )
}

cog_fn(x)

# compute cognostics for each gene #
final_data = all_data %>% mutate(cogs = map_cog(.x = stats, .f = cog_fn))

head(final_data)

# recreate trelliscope display using our hand specified cognostics #  
final_data %>% select(-data, -stats) %>% trelliscope(name = "gene_boxplots", 
                           desc = "Boxplot comparing retene and control samples", 
                           path = "/Users/bram489/Desktop/my_trelliscope_displays", 
                           thumb = T, 
                           auto_cog = F)




