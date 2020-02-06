

# downloading SMR heidi result from GWAS_MAP server.
prod_psql_connect
\copy (select * from gwas.smrheidi where gwas_id_1 = 1287006) To '/home/ubuntu/polyomica/projects/CWP_project/SMRHEIDI_COM_TRAITS/smrheidi_report.csv' With CSV HEADER DELIMITER ',';


library(dplyr)
library(tidyr)


smr <- fread("smrheidi_report.csv") #47559

smr$l=paste(smr$gwas_id_2,smr$marker_snp_id,sep="_")

length(unique(smr$l)) #31615

smr= smr[!duplicated(smr$l),] # removing duplicated combination

dim(smr)
colnames(smr)


ind=which(smr$p_smr<=2e-4 & abs(smr$z_2)>=sqrt(qchisq(5e-8,df=1,low=F)) & smr$p_heidi>0.001)
smr_f=smr[ind,]
dim(smr_f) # provide this table as suplimentary result.

fwrite(smr_f, file="hmr_heidi_resultswithoutDRG.csv")


unique_traits <- unique(smr_f$gwas_id_2) #53

smr_long <- smr[smr$gwas_id_2 %in% unique_traits,] #97

smr_long <- smr_long[,c(2,15,22,25,28)]
colnames(smr_long)

# collecting trait name from the descriptors
des <- fread("DESCRIPTORS.csv")
colnames(des)
#smr_des <- des[des$gwas_id %in% unique_traits,]
#smr_des <- smr_des[,c(1,15)]



# # Matirx for beta smr
bsmr_w <- smr_long %>% select(gwas_id_2,beta_smr,marker_snp_id) %>% spread(gwas_id_2,beta_smr)
bsmr_w <- as.matrix(bsmr_w)
rownames(bsmr_w)=paste0("rs",bsmr_w[,1])
bsmr_w <- bsmr_w[,-1]
# Matching colnames with descriptors with bsmr_w matrix.
ind=match(colnames(bsmr_w),des$gwas_id)
table(des[ind,"gwas_id"]==colnames(bsmr_w))
trts=des$trait_name[ind]
trts
ind_to_excl=c(53,42:44,31:34,4:7,9:11,15:16,18,25:27,35,36:38,50) # excluding these traits
colnames(bsmr_w)=trts
bsmr_w[is.na(bsmr_w)]=0
bsmr_w=bsmr_w[,-ind_to_excl]




# # Matrix for p smr
psmr_w <- smr_long %>% select(gwas_id_2,p_smr,marker_snp_id) %>% spread(gwas_id_2,p_smr)
psmr_w <- as.matrix(psmr_w)
rownames(psmr_w)=paste0("rs",psmr_w[,1])
psmr_w <- psmr_w[,-1]
# Matching colnames with descriptors with psmr_w matrix.
ind=match(colnames(psmr_w),des$gwas_id)
table(des[ind,"gwas_id"]==colnames(psmr_w))
trts=des$trait_name[ind]
trts
ind_to_excl=c(53,42:44,31:34,4:7,9:11,15:16,18,25:27,35,36:38,50) # excluding these traits

colnames(psmr_w)=trts
psmr_w[is.na(psmr_w)]=0
psmr_w=psmr_w[,-ind_to_excl]


# # Matrix for p heidi
pheidi_w <- smr_long %>% select(gwas_id_2,p_heidi,marker_snp_id) %>% spread(gwas_id_2,p_heidi)
pheidi_w <- as.matrix(pheidi_w)
rownames(pheidi_w)=paste0("rs",pheidi_w[,1])
pheidi_w <- pheidi_w[,-1]
# Matching colnames with descriptors with pheidi_w matrix.
ind=match(colnames(pheidi_w),des$gwas_id)
table(des[ind,"gwas_id"]==colnames(pheidi_w))
trts=des$trait_name[ind]
trts
ind_to_excl=c(53,42:44,31:34,4:7,9:11,15:16,18,25:27,35,36:38,50) # excluding these traits
colnames(pheidi_w)=trts
pheidi_w[is.na(pheidi_w)]=0
pheidi_w=pheidi_w[,-ind_to_excl]

# matrix for z2
z2_w <- smr_long %>% select(gwas_id_2,z_2,marker_snp_id) %>% spread(gwas_id_2,z_2)
z2_w=as.matrix(z2_w)
rownames(z2_w)=paste0("rs",z2_w[,1])
z2_w=z2_w[,-1]
# Matching colnames with descriptors with z2_w matrix.
ind=match(colnames(z2_w),des$gwas_id)
table(des[ind,"gwas_id"]==colnames(z2_w))
trts=des$trait_name[ind]
trts
ind_to_excl=c(53,42:44,31:34,4:7,9:11,15:16,18,25:27,35,36:38,50) # excluding these traits
colnames(z2_w)=trts
z2_w[is.na(z2_w)]=0
z2_w=z2_w[,-ind_to_excl]



out_pp=array(NA,dim(bsmr_w))
out_pp[psmr_w<=2e-4 & abs(z2_w)>=sqrt(qchisq(5e-8,df=1,low=F)) & pheidi_w>0.001]="*"   

## 4 matrix were created for forming heatmap:
library(gplots)
toPlot=bsmr_w
#toPlot[abs(toPlot)>5]=5

pdf(file = "smr_heidi.pdf",width = 10,height = 7)

heatmap.2(toPlot,notecol="black",col=redblue(75),margins = c(23,5),cellnote = out_pp, 
          density.info="none", trace="none",cexRow=0.8,srtCol=45,cexCol = 0.8)

dev.off()
















