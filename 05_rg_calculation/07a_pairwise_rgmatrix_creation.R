
# pairwise genetic correlation analysis conducted using 233 gwas ids, including CWP 234.


setwd("/home/ubuntu/polyomica/projects/CWP_project/DESCRIPTORS")
library(data.table)

pld <- fread("paiwise_ld_matrix.csv")

dim(pld)
head(pld)
colnames(pld)

a<- pld[,c(1,2,4,22)]

a <- a[!duplicated(a$trait_name_2),]



a$trait_name_2
#no_dups <- pld[!duplicated(pld$gwas_id_2),]

#gwas_ids <- pld %>% filter(gwas_id_1== "1287006" & abs(rg)>0.65)


#ids <- data.frame(ids=c(gwas_ids$gwas_id_2,1287006))

#pld_new <- pld[pld$gwas_id_1 %in% gwas_ids & pld$gwas_id_2 %in% gwas_ids, ]

#pld_new2 <- pld_new %>% filter(pld_new$gwas_id_2 %in% ids$ids)

#pld_new2 <- pld_new #[pld_new$gwas_id_2 %in% ids$ids, ]


pld_new <- pld[,c(1,2,4)]



pl_w <- pld_new %>% spread(gwas_id_1,rg)
pl_w=as.matrix(pl_w)
rownames(pl_w)=as.vector(pl_w[,1])
pl_w=pl_w[,-1]

pl_w2=apply(pl_w,MAR=2,as.numeric)
colnames(pl_w2)=colnames(pl_w)
rownames(pl_w2)=rownames(pl_w)
pl_w=pl_w2

table(colnames(pl_w)%in%rownames(pl_w))
table(rownames(pl_w)%in%colnames(pl_w))

#n_m=rownames(pl_w)[which(!rownames(pl_w)%in%colnames(pl_w))]
#pl_w[n_m,]
#pl_w=cbind(pl_w,MC=NA)

#colnames(pl_w)[ncol(pl_w)]=n_m
#pl_w=pl_w[colnames(pl_w),colnames(pl_w)]


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
pdf(file = "DRFAT_RG_ALL.pdf",height=25,width = 25)
corrplot(pl_w, type = "upper", order = "hclust", tl.col = "black")
dev.off()

save(file="big_matrix_234x234.RData",list=c("pl_w"))

