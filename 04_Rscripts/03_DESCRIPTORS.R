prod_psql_connect

\copy (select * from gwas.descriptors order by gwas_id) To '/home/ubuntu/polyomica/projects/CWP_project/DESCRIPTORS/DESCRIPTORS.csv' With CSV HEADER DELIMITER ',';


descriptors <- fread("DESCRIPTORS.csv")
table(descriptors$collection)
eqtl_gwas <- descriptors[descriptors$collection=="Cedar" | descriptors$collection=="Westra_eQTL" | descriptors$collection=="GTEx_v7",]
dim(eqtl_gwas) #1253952
eqtl_gwas <- eqtl_gwas[,1]
fwrite(eqtl_gwas, file="eqtl_gwas.csv", col.names=FALSE)


complex_gwas <- descriptors[descriptors$collection==""|
                            descriptors$collection=="Healthspan"|
                            descriptors$collection=="Cytokines"|
                            descriptors$collection=="CVD"|
                            descriptors$collection=="Metabolomics"|
                            descriptors$collection=="Lipidom"|
                            descriptors$collection=="OLINK"| 
                            descriptors$collection=="PLINK-3"|
                            descriptors$collection=="Plasma_Glycome"|
                            descriptors$collection=="SomaLogic_2017"|
                            descriptors$collection=="UKB_GeneAtlas"| 
                            descriptors$collection=="UKB_GeneAtlas_v2"|
                            descriptors$collection=="UKB_NealeLab"|
                            descriptors$collection=="UKB_SAIGE"|
                            descriptors$collection=="consortia_traits"|
                            descriptors$collection=="glycomics-igg",]

dim(complex_gwas) #4393
complex_gwas <- complex_gwas[,1]
fwrite(complex_gwas, file="complex_gwas.csv", col.names=FALSE)
