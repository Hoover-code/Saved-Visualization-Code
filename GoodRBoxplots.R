
# Start libraries
library(tidyverse)


mydata <- read.csv("clu_calc.csv")

# https://stackoverflow.com/questions/29916014/add-mean-to-boxplot-with-different-subgroups
ggplot(mydata, aes(x=factor(label), y=Age))+
  geom_boxplot(varwidth = TRUE)+
  labs(x="Cluster")+
  stat_summary(fun=mean, geom = "point", shape=5, size=2, color="red")

means <- aggregate(Age ~ label, mydata, mean)

# https://stackoverflow.com/questions/19876505/boxplot-show-the-value-of-mean
ggplot(mydata, aes(x=factor(label), y=Age))+
  geom_boxplot(varwidth = TRUE)+
  labs(x="Cluster")+
  stat_summary(fun=mean, geom = "point", shape=5, size=2, color="red")+
  stat_summary(fun=mean, geom = "text", show_guide=FALSE, hjust=-0.3,
               color="red",
               aes(label=round(after_stat(y), digits=1)))