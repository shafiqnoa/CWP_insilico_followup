library("data.table")
library("R.utils")



setwd("~/polyomica/projects/DRG_eQTLs/01_raw_data/eQTLs")

# Reading pp0 files
pp0_cis_MF <- fread("DRG_pp0_cis_MF.bed.gz")
pp0_cis_M <- fread("DRG_pp0_cis_M.bed.gz")
pp0_cis_F <- fread("DRG_pp0_cis_F.bed.gz")
# Reading pp1 files
pp1_cis_MF <- fread("DRG_pp1_cis_MF.bed.gz")
#dim(pp1_cis_MF)
pp1_cis_M <- fread("DRG_pp1_cis_M.bed.gz")
#dim(pp1_cis_M)
pp1_cis_F <- fread("DRG_pp1_cis_F.bed.gz")
#dim(pp1_cis_F)


# excluding first column from the each bed files (col 1: always chrX (this is to fool tabix))
pp0_cis_MF <- pp0_cis_MF[,-1]
pp0_cis_M <- pp0_cis_M[,-1]
pp0_cis_F <- pp0_cis_F[,-1]

pp1_cis_MF <- pp1_cis_MF[,-1]
pp1_cis_M <- pp1_cis_M[,-1]
pp1_cis_F <- pp1_cis_F[,-1]

# for checking numbers for raid and genes (seems alright)
#nrsid <- pp0_cis_MF[!duplicated(pp0_cis_MF$RSID),]
#ngene <- pp0_cis_MF[!duplicated(pp0_cis_MF$HUGO_GENE),]


# changing colnames for each bed files.
colnames(pp0_cis_MF)<- c("RSID","rsID","HUGO_GENE","BETA","P")
colnames(pp0_cis_M)<- c("RSID","rsID","HUGO_GENE","BETA","P")
colnames(pp0_cis_F)<- c("RSID","rsID","HUGO_GENE","BETA","P")
colnames(pp1_cis_MF)<- c("RSID","rsID","HUGO_GENE","BETA","P")
colnames(pp1_cis_M)<- c("RSID","rsID","HUGO_GENE","BETA","P")
colnames(pp1_cis_F)<- c("RSID","rsID","HUGO_GENE","BETA","P")


pp0_cis_MF$RSID <- sub("^","rs",pp0_cis_MF$RSID)
pp0_cis_M$RSID <- sub("^","rs",pp0_cis_M$RSID)
pp0_cis_F$RSID <- sub("^","rs",pp0_cis_F$RSID)

pp1_cis_MF$RSID <- sub("^","rs",pp1_cis_MF$RSID)
pp1_cis_M$RSID <- sub("^","rs",pp1_cis_M$RSID)
pp1_cis_F$RSID <- sub("^","rs",pp1_cis_F$RSID)


# reading chr_merged file preaperd: see 01_chr_merged_prep.R
chr_merged <- fread("~/polyomica/projects/CWP_project/DRG_DATA_MERGED/chr_merged.txt")


# Merging all snps with pp0 files.
pp0_eqtlmerged_MF <- merge(chr_merged, pp0_cis_MF, by="RSID")
pp0_eqtlmerged_M <- merge(chr_merged, pp0_cis_M, by="RSID")
pp0_eqtlmerged_F <- merge(chr_merged, pp0_cis_F, by="RSID")


# Merging all snps with pp1 files.
pp1_eqtlmerged_MF <- merge(chr_merged, pp1_cis_MF, by="RSID")
pp1_eqtlmerged_M <- merge(chr_merged, pp1_cis_M, by="RSID")
pp1_eqtlmerged_F <- merge(chr_merged, pp1_cis_F, by="RSID")


# Saving all data files
fwrite(pp0_eqtlmerged_MF, file="~/polyomica/projects/CWP_project/DRG_DATA_MERGED/pp0_eqtlmerged_MF.csv")
fwrite(pp0_eqtlmerged_M, file="~/polyomica/projects/CWP_project/DRG_DATA_MERGED/pp0_eqtlmerged_M.csv")
fwrite(pp0_eqtlmerged_F, file="~/polyomica/projects/CWP_project/DRG_DATA_MERGED/pp0_eqtlmerged_F.csv")

fwrite(pp1_eqtlmerged_MF, file="~/polyomica/projects/CWP_project/DRG_DATA_MERGED/pp1_eqtlmerged_MF.csv")
fwrite(pp1_eqtlmerged_M, file="~/polyomica/projects/CWP_project/DRG_DATA_MERGED/pp1_eqtlmerged_M.csv")
fwrite(pp1_eqtlmerged_F, file="~/polyomica/projects/CWP_project/DRG_DATA_MERGED/pp1_eqtlmerged_F.csv")
