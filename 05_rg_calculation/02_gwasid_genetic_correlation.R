# merging and cleaning heritablity data:

setwd("/home/ubuntu/polyomica/projects/CWP_project/DESCRIPTORS")
library(data.table)
h2 <- fread("DESCRIPTORS_H2.csv")
dim(h2)   #4572 ; 9

descriptors <- fread("DESCRIPTORS.csv")
dim(descriptors) #1261929 ; 41

colnames(descriptors)
colnames(h2)

complexh2 <- merge(h2, descriptors, by="gwas_id")

complexh2 <- complexh2[complexh2$collection==""|
                         complexh2$collection=="Healthspan"|
                         complexh2$collection=="Cytokines"|
                         complexh2$collection=="CVD"|
                         complexh2$collection=="Metabolomics"|
                         complexh2$collection=="Lipidom"|
                         complexh2$collection=="OLINK"| 
                         complexh2$collection=="PLINK-3"|
                         complexh2$collection=="Plasma_Glycome"|
                         complexh2$collection=="SomaLogic_2017"|
                         complexh2$collection=="UKB_GeneAtlas"| 
                         complexh2$collection=="UKB_GeneAtlas_v2"|
                         complexh2$collection=="UKB_NealeLab"|
                         complexh2$collection=="UKB_SAIGE"|
                         complexh2$collection=="consortia_traits"|
                         complexh2$collection=="glycomics-igg",]


complexh2_filter <- complexh2[complexh2$n_people >10000 & 
                                complexh2$h2 > 0 & 
                                abs(complexh2$z) > 4 & (is.na(complexh2$n_controls)|(complexh2$n_cases>2000 &complexh2$n_controls>2000)),]

dim(complexh2_filter)
table(complexh2_filter$collection)
colnames(complexh2_filter)
gwasid_for_rg <- complexh2_filter[,1] 
fwrite(gwasid_for_rg, file="gwasid_for_rg.csv", col.names=FALSE)

