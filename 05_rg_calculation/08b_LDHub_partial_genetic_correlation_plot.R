
setwd("~/Desktop/other")
load("gc_matrixld_hub.rda")

colnames(dd2plot)

ind=c(8,13,17,19,21,24) # with out neuroticism
dd3plot <- dd2plot[ind,ind]


#install.packages("ggm")
library(ggm)

corr.all <- parcor(dd3plot)

corrplot(corr = dd3plot,method = "square",tl.col="black",tl.srt = 75) # older correlation

corrplot(corr = corr.all,method = "square",tl.col="black", tl.srt = 75) # partial genetic correlation

# formula to calculate p-value = pchisq((rg/se)^2, degreee of freedom=1, lower.tail=F)

# does genetic correlation change significantly? calculate p-value.
# Standard error were taken from main genetic correlation analysis and plugged in the chi-square formula with one degree of freedom with lower tail== FALSE.
SE <- c(0.0358,0.0516, 0.0873, 0.0412,0.0331) # without neuroticism
a <- corr.all[5,-5]/SE 

#calculating p-value
pchisq(a^2,1, lower.tail = F)

### make separate figure of partial genetic correlation analysis.

