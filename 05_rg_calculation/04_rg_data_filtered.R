setwd("~/polyomica/projects/CWP_project/DESCRIPTORS")
rgdata <- fread("DESCRIPTORS_rg_1287006.csv")
colnames(rgdata) #514; 17
dim(rgdata)
rg1287006_filtered <- rgdata[rgdata$pval< 0.00000038,]  # formula: n*(n-1)/2=515*514/2= 0.00000038
dim(rg1287006_filtered) # 261; 17
fwrite(rgdata_filtered, file="rg1287006_filtered.csv")
