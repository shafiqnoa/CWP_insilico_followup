export PROD=TRUE

gs_id=$(cat ~/polyomica/projects/CWP_project/DESCRIPTORS/gwasid_for_rg.csv)

for gid in $gs_id
do
echo $gid

run_ldscore \
--rg=TRUE \ 
--gwas-id $gid \ 
--gwas-id-1=1287006
done
