export PROD=TRUE

gs_id=$(cat /home/ubuntu/polyomica/projects/CWP_project/DESCRIPTORS/complex_gwas.csv)

for gid in $gs_id
do
echo $gid

run_smrheidi \
--gwas-id-1 1287006 \
--gwas-id-2 $gid \
--snp-list /home/ubuntu/polyomica/projects/CWP_project/CWP_DATA_MAIN/snplist.csv \
--version 1
done
