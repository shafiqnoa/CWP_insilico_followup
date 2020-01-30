
rg <- fread("rg1287006_filtered.csv")
dim(rg)
colnames(rg)
rg_sig_id <- rg[,2]

list <- paste(rg_sig_id$gwas_id_2, collapse = ",")


list <- as.list(list)
write.table(list, file = "list.txt", quote = FALSE, col.names = FALSE, row.names = FALSE)


# ***
#finnaly added CWP GWAS id manually to the list.txt file which made a total of 262 ids.
