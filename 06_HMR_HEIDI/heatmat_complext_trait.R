library(data.table)
library(dplyr)
library(tidyr)

etwd("~/polyomica/projects/CWP_project/SMRHEIDI_COM_TRAITS")
smrct <- fread("cwp_smrheidi_comtraits.csv") #14281 obs new
colnames(smrct)
table(smrct$Trait_Collection)
a <- smrct[!duplicated(smrct$Index_SNP),] # 3 Index SNPs
l <- unique()


smrct_sig <- smrct %>% filter(p_SMR < 1E-04) # 31 obs

#smrct_sig <- smrct %>% filter(p_SMR < 1E-07) # 2 obs

smrct_sig <- smrct %>% filter(p_SMR < 1E-04 & p_HEIDI > 0.001)
colnames(smrct_sig)
table(smrct_sig$Index_SNP)

smrct_sig <- smrct_sig[,c(5,9,27,28,29)]
colnames(smrct_sig)[1] <- "t2"

smrct_sig <- unique(smrct_sig)
betasmr <- smrct_sig[,c(1,2,3)]
psmr <- smrct_sig[,c(1,2,4)]
pheidi <- smrct_sig[,c(1,2,5)]


betasmr_w <- betasmr %>% spread("t2" ,"beta_SMR")
dim(betasmr_w)
psmr_w <- psmr %>% spread("t2" ,"p_SMR")
pheidi_w <- pheidi %>% spread("t2" ,"p_HEIDI")

colnames(betasmr_w)
betasmr_w[is.na(betasmr_w)] <- 0
str(betasmr_w)
row.names(betasmr_w) <- betasmr_w$Index_SNP
betasmr_w <- betasmr_w[,-1]
betasmr_matrix <- data.matrix(betasmr_w)
smr_heatmap <- heatmap(betasmr_matrix, Rowv=NA, Colv=NA, col = cm.colors(256), scale="column", margins=c(3,3))




library(gplots)

pdf(file = "20190228_smr_heidi.pdf",width = 10,height = 7)

heatmap.2(betasmr_matrix,notecol="black",col=redblue(75),margins = c(23,5),density.info="none", trace="none",
          cexRow=0.8,srtCol=45,cexCol = 0.8)

dev.off()

