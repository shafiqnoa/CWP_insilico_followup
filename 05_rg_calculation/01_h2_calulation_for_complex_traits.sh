export PROD=TRUE

gs_id=$(cat ~/polyomica/projects/CWP_project/DESCRIPTORS/complex_gwas.csv)

for gid in $gs_id
do
echo $gid

run_ldscore \
--h2 \
--gwas-id $gid

done
