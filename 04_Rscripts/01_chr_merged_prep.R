# reading files with SNPs from all 22 chromosomes
setwd("~/polyomica/projects/DRG_eQTLs/01_raw_data/eQTLs/rs_freq_information")
all.files <- list.files()
l <- lapply(all.files, fread, sep="\t")
chr_merged <- rbindlist(l)
colnames(chr_merged )[1]<- "RSID"
dim(chr_merged) # 81653337; 7
chr_merged <- chr_merged[chr_merged$MAF>=0.01,] 
chr_merged <- chr_merged[chr_merged$NCHROBS>=(max(chr_merged$NCHROBS)*0.95),]
chr_merged <- chr_merged[which(!duplicated(chr_merged$RSID)),]
dim(chr_merged) #8145704; 7
fwrite(chr_merged, file="~/polyomica/projects/CWP_project/DRG_DATA_MERGED/chr_merged.txt")
