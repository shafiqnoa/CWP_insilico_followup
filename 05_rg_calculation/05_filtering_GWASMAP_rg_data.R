
setwd("/home/ubuntu/polyomica/projects/CWP_project/DESCRIPTORS")
library(data.table)


# all the descriptors of GWAS ids
des <- fread("DESCRIPTORS.csv")

# reading genetic correlation findings 
rgd <- fread("DESCRIPTORS_rg_1287006.csv") # main file for genetic correlation obtained from GWAS-MAP server.

#ids <- fread("gwasid_for_rg.csv") # these ids were used for calculating genetic correlation.

#summary(rgd1$gwas_id_1)
rgd_des <- des[des$gwas_id %in% rgd$gwas_id_2,]
colnames(rgd_des)
rgd_des<- rgd_des[,c(1,14,15,36)]
colnames(rgd_des) <- c("gwas_id_2","gwasid2_name","gwasid2_abbrev","gwasid2_collection")

## merging coloums for gwas_id_2 trait names, trait avvbreviation and collection:
rgd<- merge(rgd, rgd_des, by= "gwas_id_2")
#fwrite(rgd, file = "rgd.csv")

rgd <- fread("rgd.csv")
colnames(rgd) #677; 20
dim(rgd)


# gwas ids from pain3 and ukb data with pain phenotypes are to be excluded:
ids<- fread("GWAS_ID_Exclude.csv") #57


rgd_f <- rgd[!rgd$gwas_id_2 %in% ids$V1,] #621
ids_excluded <- rgd[rgd$gwas_id_2 %in% ids$V1,]  #56
fwrite(rgd_f, file="genetic_correlation.csv")
fwrite(ids_excluded, file="ids_excluded_from_genetic_correlation.csv")


## 0.05/677=7.385524e-05
rgd_f <- rgd[rgd$pval< 2.588916e-07,]  #0.05/(n(n-1)/2) where n=621
rgd_f <- rgd_f[abs(rgd_f$rg)>0.35,] #233
colnames(rgd_f)
fwrite(rgd_f, file = "genetic_correlation_after_filtering.csv")


# list of GWAS IDs to be included in pairwise rg calculation:
prg_ids <- paste(c(rgd_f$gwas_id_2,1287006), collapse = ",")
write.table(prg_ids, file = "prg_ids.txt", quote = FALSE, col.names = FALSE, row.names = FALSE)

