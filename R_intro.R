## 1. Programming in R
# In R, the comment character is ‘#’. Anything typed after ‘#’ will be ignored by R. Comments are a very useful way to annotate your code, both for yourself and others.


### 1.2 Working Directory
# Change your working directory with the 'setwd()' function, such as:
  
setwd("~/mydirectory")

# Note that the slashes always have to be forward slashes, even if you're on a Windows system. For Windows, the command might look something like:

# You can retrieve the working directory where R is currently pointing:

getwd()

### 1.3 Installing Packages

#### 1.3.1 CRAN Packages
#The command for installing a package is:
  
install.packages("thepackagename")

# To see which packages are already installed on your system, type:
  
installed.packages()

#### 1.3.2 Bioconductor Packages

# Bioconductor is a popular repository that has a collection of packages aimed at biological applications.

# Installing a Bioconductor package first requires the package 'BiocManager', a CRAN package which provides a method for R to access Bioconductor packages. This can be done with the command:
  
install.packages("BiocManager")

# Subsequent Bioconductor packages can then be installed with the following command:
  
BiocManager::install("thepackagename")

#### 1.3.3 Github Packages
# Many useful packages in beta or final versions exist on Github. The package 'devtools' is required to directly install packages from Github. *Note: If you're on a Windows PC, you will need to first install Rtools from https://cran.r-project.org/bin/windows/Rtools/.* 

# Then, install 'devtools' as you would for any CRAN package:

install.packages("devtools")

# Github packages can then be installed with the following syntax:

devtools::install_github("owner/repository")

## packages for this seminar
## pre-requirements
install.packages("BiocManager") 
BiocManager::install("minet") 
BiocManager::install("biomaRt") 
BiocManager::install("DESeq2") 
BiocManager::install("org.Dr.eg.db") 
BiocManager::install("topGO") 
BiocManager::install("tximport") 
BiocManager::install("org.Dr.eg.db")
install.packages("devtools") 
devtools::install_github("hafen/trelliscopejs")
install.packages("rbokeh") 
install.packages("readr") 
install.packages("rjson") 
install.packages("vegan") 
install.packages("ggplot2") 
install.packages("gplots") 
# install.packages("cividis")

install.packages("igraph") 
install.packages("tidyverse") 
install.packages("purrr") 
install.packages("dplyr") 
install.packages("reshape2")

## new packages that weren't in the preworkshop requirements #
install.packages("ggfortify")
install.packages("clusterSim")
install.packages("plyr")

# https://github.com/marcosci/cividis
# cividis




### 1.4 Calculations in R

# R can be used like a calculator and automatically returns the results of the following calculations.

# some arithmetic
24*7
exp(4)

### 1.5 Variables
# In addition to using R like a calculator, we can assign a name to each value, creating a variable. These values can be numeric (a number), character (a combination of letters, some symbols (such as "_" or "."), and numbers), or logical (TRUE or FALSE). Both "<-" and "=" work as assignment operators in R.

a <- 3^2
b = TRUE
x <- log2(7)
word = "something"

# We can paste strings together using the paste() command, where the argument sep specifies what character to use as a separator between the strings to be pasted together. Below, we use an empty string as the separator so that there are no spaces or other characters in between the first two arguments.

# we can paste strings together
paste("This string says: ", word, sep = "")

# When defining a character variable, use either single (‘inside single quotes’) or double quotes ("inside double quotes").

# By entering the variable name into the command window or using the print() command, we can see its value. The environment/history window also shows the names and values of the variables defined in the current R session (click on the Environment tab if it is not currently selected).

a

print(a)

# Variable names can contain letters (upper or lower case), numbers, ".", or "_", but must begin with a letter. R is case-sensitive, so the following variables are different.

time <- 47
Time <- 3

# To check for equality in numeric or character variables, use the logical equals symbol, "==". To check for inequality, use "!=". For numeric variables or values, "<", "<=", ">", and ">=" can be used to make comparisons.

time == Time
time != Time

# we can also use these operators on functions
sqrt(10) > log2(16)

# These commands all return logical values, either TRUE or FALSE.

### 1.6 Functions
# Some of the commands we’ve run so far have been functions (e.g. log2(), paste(), print()).

# The general structure used to call a function includes the function name, a set of parentheses to enclose the arguments to the function, and the arguments themselves. Best practice is to include the argument name for clarity (sometimes the R function requires this in order to work properly). For instance, if the function documentation says that it expects to see arguments named x and y, call the function as *some_function(x=my.x.values, y=my.y.values)*. If not including the parameter name, be especially aware of the order in which the function expects its arguments. Note that when specifying function arguments, the "=" must be used to assign the argument values (and not the "<-" assignment operator).

# Sometimes we may want to include a function as an argument to another function, such as the following, where the sqrt() (square root) function is one of the arguments to the paste() function.

paste("The square root of 10 is ", sqrt(10), "!", sep = "")

# We will see more examples of calling functions later.

### 1.7 Documentation
# To get more information about a defined function, type "?" and the name of the function in the command window.

?paste

# The documentation for the specified function will appear in the Help/Files/Plots/Packages/Viewer window. Typically, the documentation includes a description, the arguments that the function takes (either required or optional), any details that may be important, the value(s) that the function returns, pertinent references, other topics that may be of interest, and one or more examples of calling the function. Depending on the function (and on the authors of the function), the documentation may be more or less detailed and useful.

### 1.7 Managing the R environment
# When we open R Studio (and hence R), we have opened an R session. Associated with an R session is a workspace, which consists of the variables that we create in the R session. Any variables that we create are only available in the current R session; we can choose to save the workspace so that those variables will be available to us in future sessions. In addition to using the Environment window in R Studio, we can ask R to show us the variables that exist in the current R session.

# print the variables that exist in the R session
ls()

# remove one of them
rm(time)

# remove all of them 
rm(list=ls())

ls()

## 2. Vectors
# All of the variables we created in the previous section were scalars, taking a single value. These scalars are actually interpreted by R as vectors (i.e. a listing of values) of length one.

# We can define vectors of length greater than one, such as:

my_vector <- c(1, 2, 3) # a numeric vector
my_vector

length(x = my_vector) # The function "length" is expecting one argument, named x. It is up to us whether we specify "x=" or not.

my_vector2 <-c('ab', 'bc', 'ca', 'ac', 'bb', 'ab', 'ca', 'bb', 'bc', 'a') # a character vector
print(my_vector2)

my_vector3 <- 1:10 # a sequence of numbers to make a numeric vector
my_vector3

length(my_vector3)

# To view the begining or end of a vector, use the head() and tail() commands.

head(my_vector2)

tail(my_vector2)

# Accessing specific elements of a vector is done using square brackets.

my_vector2[1:3] # returns the first 3 elements

my_vector2[c(1, 3)] # returns the 1st and 3rd elements

my_vector2[-1] # returns all but the 1st element

my_vector2[-c(1, 3)] # returns all but the 1st and 3rd elements

# If we want to see the unique values of a vector, we can use the unique() command.

unique(my_vector2)

# We can also pull the index (position in the vector) of a specific value using *which()* or *grep()* (particularly useful for character vectors since *grep()* can look for partial matches).

which(my_vector2 == 'ab')

grep('ab', my_vector2)

grep('a', my_vector2) # includes partial matches

# Vectors must contain elements of the same class, e.g. all numeric or all character.

# Missing values are represented by "NA" (or, specific to mathematical operations, "NaN" [not a number]). Be aware that by default some functions ignore missing values while others do not; see the function documentation for details.

## 3. Lists and dataframes

### 3.1 Lists
# In R, ‘lists’ are a special type of vector. They can contain elements of different classes (one element can be character, another element can be numeric), and those elements can have different lengths or dimensions. We can assign names to the elements of a list using the *names()* function.

my_list <- list(my_vector, my_vector2, my_vector3)
names(my_list) # there are no names right now
names(my_list) <- c("Vector1", "Vector2", "Vector3")
names(my_list) # now there are names

# Another useful function to be aware of when working with lists is lapply(), which allows us to apply a function over the elements of the list. Below we use lapply() to get the length of each element of my_list.

lapply(my_list, length)

# Recall that to access the elements of a vector, we used square brackets. To access the elements of a list, we use double square brackets or "\$". Notice the output of the lapply() statement above. R returned the dimensions using "\$" notation and the element name. If no names were specified for the list elements, R would have returned the lengths using double square brackets ("[[1]]", "[[2]]", "[[3]]") to denote the list elements.

my_list[[1]] # 1st element of my_list

my_list[[1]][1] # 1st element of my_vector, which is the first element of my_list

my_list$Vector1

my_list$Vector1[1:2]

### 3.2 Data.frames
# Data.frames are a special type of list where each element has the same length (each column of the data.frame is like an element of a list). The columns of a data.frame can be of different classes (e.g. numeric, character, or logical). Data.frames are very useful because they store tabular data, such as a table of data collected as part of an experiment.

# As with lists, we can set the names of a data.frame (both for rows and for columns). Row names are automatically generated as integers, starting at 1 for the first row and continuing in sequence, but can be re-set to more meaningful names if desired. Data.frames are usually created by reading in data from a .csv or .xls file, but can also be created using the *data.frame()* function. Just as with vectors and lists, we can use the head() and tail() functions to display the first and last portions of a data.frame.

# as.character() is used to force the names to be characters
x <- data.frame(name = as.character(c("Michael", "Jim", "Kevin", "Ryan", "Oscar")), age = c(50, 31, 36, 28, 38), height = c(68, 73, 72, 70, 69))

rownames(x)

colnames(x)

colnames(x) <- c("FirstName", "Age_yrs", "Height_in")

head(x) # shows us the entire dataframe because there are less than 6 rows--'head()' shows the first 6 rows

# We can access the columns of dataframe x by using the ‘$’ operator.

x$Age_yrs

# The columns, rows, individual cells, or subsets of a dataframe can be accessed using square brackets.

# x[which rows, which columns]
x[1, 3] # first element of third column

x[1, ] # first row, all columns

## 4. Plots
# A very powerful tool for creating plots in R is the ggplot2 package (Wickham 2009); we'll load that library here. Note the base R installation has many functions for plotting, and there are several other packages such as plotly, lattice and highcharter which you may use.

library(ggplot2)

# There are many types of graphs that ggplot2 supports, but we will look at a simple scatter plot to illustrate a few aspects of plotting. We’ll use the dataframe x that we created earlier.

# The *qplot()* function can be used to make quick plots with limited complexity. Here we will make a scatter plot, where the first element is the variable for the x-axis, the second element is the variable for the y-axis, and the third element is the dataframe that contains the variables.

qplot(Age_yrs, Height_in, data = x, geom = "point")

# We can modify the graph with different colors and shapes for the different first names, a title, and prettier labels for the axes.

qplot(Age_yrs, Height_in, data = x, color = FirstName, pch = FirstName) + labs(title = "Age and Height", x = "Age (years)", y = "Height (inches)")

# Specific colors and plot symbols can be specified as well. Colors can be specified using names, numbers, or their hex constants. There are many resources available online to help with color specification. For instance http://research.stowers-institute.org/efg/R/Color/Chart/. A listing of plot symbols can be found here http://www.endmemo.com/program/R/pchsymbols.php.

## 5. Working with External Data

### 5.1 Reading Data into R
# To read data into R, two commonly used functions are *read.table()* for .txt files and *read.csv()* for .csv files.

# There are a number of optional arguments to these functions, but the following syntax provides a basic example of how to call these functions.

read.csv(filepath, header=TRUE)
read.table(filepath, header=TRUE)

# In the above function calls, the filepath argument is a string (in quotes) specifying the directory location plus name of the file to read and the 'header=TRUE' argument specifies that column names are included in the file as the first row (if no column names are included in the file, then specify 'header=FALSE').

### 5.2 Writing Data from R
# Similarly to the functions used for reading data into R, *write.table()* and *write.csv* are used to write .txt and .csv files, respectively. Again, the following sytax provides a basic example of how to call these functions. See the function documentation for additional information.

write.csv(outputData, filepath, row.names=FALSE)
write.table(outputData, filepath, row.names=FALSE)
