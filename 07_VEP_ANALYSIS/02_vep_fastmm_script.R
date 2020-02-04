library(data.table)



setwd("/home/ubuntu/polyomica/projects/CWP_project/CWP_DATA_MAIN")
cwp <- fread("CWP_GWAS.txt")

rs1491985 <- cwp[cwp$BP > 49239507 & cwp$BP < 50239507 & cwp$P < 1.60E-07,] # 500kb apart

rs10490825 <- cwp[cwp$BP > 130196383 & cwp$BP < 131196383 & cwp$P < 1.30E-07,] # 500kb apart
#130696383+500000
#130696383-500000

rs165599 <- cwp[cwp$BP > 19456781 & cwp$BP < 20456781 & cwp$P < 2.50E-07,]
#19956781+500000
#19956781-500000

setwd("/home/ubuntu/polyomica/projects/CWP_project/VEP")
tagsnps <- rbind(rs1491985,rs10490825,rs165599)
tagsnps <- tagsnps[,c(1,2,3,4,5)]
fwrite(tagsnps, file="tagsnps_fathmm.txt")


vep_gwas_snps <- tagsnps[,1]
fwrite(vep_gwas_snps, file = "vep_gwas_snps.txt", col.names=FALSE)


vep_gwas_snps <- fread("vep_gwas_snps.txt", header = FALSE)
chr22 <- fread("tagsnps_pl22.tags", header = FALSE) #plink tag snps
chr3 <- fread("tagsnps_pl3.tags", header = FALSE) #plink tag snps

vepsnps <- rbind(chr22, chr3, vep_gwas_snps)
vepsnps <- vepsnps[!duplicated(vepsnps$V1)]
fwrite(vepsnps, file="vepsnps.txt", col.names = FALSE)



library(tidyr)

df <- fread("tagsnps_fathmm.txt")
head(df)
df$x <- do.call(sprintf, c(df[,2:5],'%s,%s,%s,%s'))
df <- df[,6]
write.table(df, file="snps_fathmm.txt", col.names=FALSE, quote = FALSE, row.names = FALSE)



setwd("/home/ubuntu/polyomica/gwas/reference/by_chr")

ch22 <- fread("ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes_nodup.bim") # bim file used for selecting plink tag snps
ch3 <- fread("ALL.chr3.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes_nodup.bim")


setwd("/home/ubuntu/polyomica/projects/CWP_project/VEP")
chr22snps <- fread("tagsnps_pl22.tags", header = FALSE) # plink tag snps
chr3snps <- fread("tagsnps_pl3.tags", header = FALSE) # plink tag snps

chr22snps <- ch22[ch22$V2%in%chr22snps$V1,]
chr3snps <- ch3[ch3$V2%in%chr3snps$V1,]
chr3_22 <- rbind(chr22snps,chr3snps) #149 snps

setwd("/home/ubuntu/polyomica/projects/CWP_project/VEP")
df <- fread("tagsnps_fathmm.txt")



chr3_22 <- chr3_22[!chr3_22$V2 %in% df$RS_ID,] #73
chr3_22 <- chr3_22[,c(1,4:6)]
chr3_22$snps <- do.call(sprintf, c(chr3_22[,1:4],'%s,%s,%s,%s'))
chr3_22 <- chr3_22[,5]


df$snps <- do.call(sprintf, c(df[,2:5],'%s,%s,%s,%s'))
df <- df[,6]



fathmm_final <- rbind(df,chr3_22)
write.table(fathmm_final, file="fathmm_final.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)


## using fathm_final snps get fathm results then downloaded result as fathmm.txt, 
##after that manually allgned all reference snps where fathmm provided warning: follows
fathmm <- fread("fathmm.txt")
fathmm <- fathmm[,1:4]
fathmm$snps <- do.call(sprintf, c(fathmm[,1:4],'%s,%s,%s,%s'))
fathmm <- fathmm[,5]
fwrite(fathmm, file = "fathmm.txt", col.names = FALSE, quote = FALSE)
# this file was used for final analysis of FATHMM. 
