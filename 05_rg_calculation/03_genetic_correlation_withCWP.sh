export PROD=TRUE

gs_id=$(cat ~/polyomica/projects/CWP_project/DESCRIPTORS/gwasid_for_rg.csv)

for gid in $gs_id
do
echo $gid

run_ldscore \
--rg=TRUE \ 
--gwas-id-1 $gid \ 
--gwas-id-2=1287006
done
