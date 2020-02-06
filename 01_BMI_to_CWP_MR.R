install.packages("devtools")
devtools::install_github("MRCIEU/TwoSampleMR")


devtools::install_github("MRCIEU/MRInstruments")
library(MRInstruments)

install.packages("data.table")


library(TwoSampleMR)
library(MRInstruments)
library(data.table)
cwp <- fread("cwp_unification_output_done.csv")
bmi <- fread("bmi_clumped.txt") # see method BMI and Back pain paper by yakov.




# The aim of this script is to run the primary Mendelian Randomization analysis
# for BMI/Obesity/Overweight vs Back pain/Chronic back pain


library(TwoSampleMR)
library(MRInstruments)
library(data.table)

bmi_exp_dat <- read_exposure_data(filename = "bmi_clumped.txt",
				  clump = FALSE,
				  sep = "\t",
				  snp_col = "rs_id",
				  beta_col = "beta",
				  se_col = "se", 
				  eaf_col = "eaf",
                                  effect_allele_col = "ea",
                                  other_allele_col = "ra", 
                                  pval_col = "p",
                                  samplesize_col = "n")
bmi_exp_dat[,"exposure"]=bmi_exp_dat[,"id.exposure"]="BMI"

# Load CWP data (exposure 2)


# Load CWP data (outcome 1)
cwp <- fread("cwp_unification_output_done.csv")
cwp_out_dat <- read_outcome_data(snps = NULL,
                                filename = "cwp_unification_output_done.csv",
                                sep = ",",
                                snp_col = "rs_id",
                                beta_col = "beta",
                                se_col = "se",
                                effect_allele_col = "ea",
                                other_allele_col = "ra",
                                eaf_col = "eaf",
                                pval_col = "p",
                                samplesize_col = "n")

cwp_out_dat[,"outcome"]=cwp_out_dat[,"id.outcome"]="CWP"

# Load Chronic back pain data (ou

# Exposure 1: BMI, outcome 1: Back pain
dat11 <- harmonise_data(exposure_dat = bmi_exp_dat, outcome_dat = cwp_out_dat)
dat11 <- dat11[(dat11$'eaf.exposure' < 0.95) & (dat11$'eaf.exposure' > 0.05) & (dat11$'eaf.outcome' < 0.95) & (dat11$'eaf.outcome' > 0.05), ]



dat11=dat11[dat11$mr_keep==TRUE,]

dim(dat11)


### Run MR-analysis ###

mr_report(dat11,study="CWP")


## download BMI gwas from GWAS_MAP: ID: 3428.

