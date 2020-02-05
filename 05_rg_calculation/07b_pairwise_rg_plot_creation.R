
setwd("~/Desktop/other")
load("big_matrix_234x234.RData")


setwd("~/Desktop/Clean results polyomica/GENETIC_CORRELATION")
x <- fread("genetic_correlation.csv") #621
new_f=x[abs(x$rg)>0.7&x$pval<=2.58891e-7,]
colnames(new_f)
new_gwasids=new_f$gwas_id_2
new_gwasids=c(new_gwasids,1287006)

pl_w_n=pl_w[as.character(new_gwasids),as.character(new_gwasids)]


gwasid_name=c(new_f$gwasid2_abbrev,"CWP")

colnames(pl_w_n) <- gwasid_name
rownames(pl_w_n) <- gwasid_name

pdf(file = "DRFAT_RG.pdf",height=25,width = 25)
corrplot(pl_w_n, type = "upper", order = "hclust", tl.col = "black")
dev.off()


