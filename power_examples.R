library(ggplot2)
library(dplyr)
library(tidyverse)

# read in data #
mydata = read.csv("Power_Example_Data.csv", header = T)

head(mydata)

table(mydata$Treatment)

# boxplots #
ggplot(data = mydata, aes(x = Treatment, y = Benzo.a.pyrene)) +
  geom_boxplot()

# histograms #
ggplot(data = mydata, aes(x = Benzo.a.pyrene)) +
  geom_histogram() +
  facet_grid(~Treatment)

# reduce number of bins #
ggplot(data = mydata, aes(x = Benzo.a.pyrene)) +
  geom_histogram(bins = 10) +
  facet_grid(~Treatment, scales = "free") # let scales be unequal #

# what about log scale #
ggplot(data = mydata, aes(x = Benzo.a.pyrene)) +
  geom_histogram(bins = 10) +
  scale_x_continuous(trans = "log") +
  facet_grid(~Treatment, scales = "free") # let scales be unequal #

# compute some summary statistics by treatment #
mydata %>% group_by(Treatment)

mydata %>% group_by(Treatment) %>% summarise(Mean_Benzo = mean(Benzo.a.pyrene))

data_summary = mydata %>% group_by(Treatment) %>% summarise(Mean_Benzo = mean(Benzo.a.pyrene), Var_Benzo = var(Benzo.a.pyrene), Var_Log2_Benzo = var(log2(Benzo.a.pyrene)))


# power analysis for test of two groups t-test comparison in R #
# Type 1 error - 0.05
# n = 10 per group
# effect size of 8 #
# use tipi variance - data_summary$Var_Benzo[2]#

power.t.test(n = 10, delta = 8, sd = sqrt(data_summary$Var_Benzo[2]), sig.level = 0.05)

# what if my alternate hypothesis is one-sided? #
power.t.test(n = 10, delta = 8, sd = sqrt(data_summary$Var_Benzo[2]), sig.level = 0.05, alternative = "one.sided")

# what if we assume shed variance? #
power.t.test(n = 10, delta = 8, sd = sqrt(data_summary$Var_Benzo[1]), sig.level = 0.05)

# how many samples for 80% power? #
power.t.test(delta = 8, sd = sqrt(data_summary$Var_Benzo[1]), sig.level = 0.05, power = 0.8)


### what if I don't know my desired sample size??? ###
# log transform data #
# effect size becomes fold-change #
# what if we assume shed variance? #
# on log2 scale ==> effect size = 1 corresponds to 2-fold change #
power.t.test(n = 10, delta = 1, sd = sqrt(data_summary$Var_Log2_Benzo[1]), sig.level = 0.05)


power.t.test(n = c(10,20), delta = 1, sd = sqrt(data_summary$Var_Log2_Benzo[1]), sig.level = 0.05)

### other functions available for ANOVA or test of proportions ###
## outside of these ==> contact a statistician ##

