for i in {3 22}
do
plink  \
--bfile /home/ubuntu/polyomica/gwas/reference/by_chr/ALL.chr${i}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes_nodup \
--file \
--show-tags /home/ubuntu/polyomica/projects/CWP_project CWP_DATA_MAIN/cwp_index_snps.txt \
--list-all \
--tag-r2 0.8 \
--out /home/ubuntu/polyomica/projects/CWP_project/VEP/tagsnps_pl
done
