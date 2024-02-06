# this example of the histogram over the boxplot comes from:
# https://stackoverflow.com/questions/48164435/merge-and-perfectly-align-histogram-and-boxplot-using-ggplot2

library(tidyverse)
library(egg)
library(cowplot)
library(devtools)
library(patchwork)

mydata <- read.csv("clu_calc.csv")
mydata_sliced <- mydata %>% 
  filter(label=="2")
# remove(mydata_sliced)

plt1 <- mydata_sliced |>
  ggplot(aes(x="", y = Age))+
  geom_boxplot(fill="lightblue", color="black")+
  coord_flip()+
  theme_classic()+
  xlab("")+
  theme(axis.text.y=element_blank(),
        axis.ticks.y = element_blank())

plt2 <- mydata_sliced |>
  ggplot()+
  geom_histogram(aes(x=Age, y=(..count..)/sum(..count..)),
                 position = "identity", binwidth = 1,
                 fill="lightblue", color="black")+
  ylab("Relative Frequency") +
  theme_classic()

# egg
egg::ggarrange(plt2,plt1, heights=2:1)

# cowplot
cowplot::plot_grid(plt2, plt1,
                   ncol=1, rel_heights = c(2,1),
                   align = 'v', axis = 'lr')

# patchwork
plt2 + plt1 + plot_layout(nrow = 2, heights = c(2,1))
