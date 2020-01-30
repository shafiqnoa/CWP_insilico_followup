export PROD=TRUE

gs_id=$(cat ~/polyomica/projects/CWP_project/DESCRIPTORS/rg_sig_id.csv)

for gid in $gs_id
do
echo $gid

run_ldscore \
--rg \
--gwas-id $gid
done
