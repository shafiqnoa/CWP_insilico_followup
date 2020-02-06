


library(data.table)
rs1 <- fread("rs1491985.txt")
rs2 <- fread("rs10490825.txt")
rs3 <- fread("rs165599.txt")
rs <- rbind(rs1,rs2,rs3) #17121
rs <- rs[!duplicated(rs$V1),] #9599
fwrite(rs, file = "smr_eqtl_id.txt", col.names = FALSE)
