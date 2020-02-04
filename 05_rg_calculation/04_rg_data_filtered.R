
setwd("/home/ubuntu/polyomica/projects/CWP_project/DESCRIPTORS")
library(data.table)


# all the descriptors of GWAS ids
des <- fread("DESCRIPTORS.csv")

# reading genetic correlation findings 
rgd <- fread("DESCRIPTORS_rg_1287006.csv")

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




# list to be included in pairwise rg calculation:
prg_ids <- paste(c(rgd_f$gwas_id_2,1287006), collapse = ",")
write.table(prg_ids, file = "prg_ids.txt", quote = FALSE, col.names = FALSE, row.names = FALSE)











# now running pairwise genetic correlation.











pld <- fread("paiwise_ld_matrix.csv")
dim(pld)
head(pld)
colnames(pld)
#no_dups <- pld[!duplicated(pld$gwas_id_2),]

#gwas_ids <- pld %>% filter(gwas_id_1== "1287006" & abs(rg)>0.65)


#ids <- data.frame(ids=c(gwas_ids$gwas_id_2,1287006))

pld_new <- pld[pld$gwas_id_1 %in% gwas_ids & pld$gwas_id_2 %in% gwas_ids, ]

#pld_new2 <- pld_new %>% filter(pld_new$gwas_id_2 %in% ids$ids)

pld_new2 <- pld_new #[pld_new$gwas_id_2 %in% ids$ids, ]


colnames(pld_new2)
pld_new2 <- pld_new2[,c(1,2,4)]



pl_w <- pld_new2 %>% spread(gwas_id_1,rg)
pl_w=as.matrix(pl_w)
rownames(pl_w)=as.vector(pl_w[,1])
pl_w=pl_w[,-1]

pl_w2=apply(pl_w,MAR=2,as.numeric)
colnames(pl_w2)=colnames(pl_w)
rownames(pl_w2)=rownames(pl_w)
pl_w=pl_w2

colnames(pl_w)%in%rownames(pl_w)
n_m=rownames(pl_w)[which(!rownames(pl_w)%in%colnames(pl_w))]
pl_w[n_m,]
pl_w=cbind(pl_w,MC=NA)
colnames(pl_w)[ncol(pl_w)]=n_m
pl_w=pl_w[colnames(pl_w),colnames(pl_w)]


pl_w[is.na(pl_w)] <- 0
tt=t(pl_w)
pl_w <- pl_w+tt
diag(pl_w)=1

pl_w[pl_w>1]=1
pl_w[pl_w<(-1)]=-1


#colnames(pld_new2_w)
#rownames(pld_new2_w)



#row.names(pld_new2_w) <- pld_new2_w$trait_abbreviation_2
#pld_new2_w<- pld_new2_w[,-1]
#pld_new2_w <- data.matrix(pld_new2_w)

#dim(pld_new2_w)

library(corrplot)
corrplot(pl_w, type = "upper", order = "hclust", tl.col = "black")







