export PROD=TRUE

gs_id=$(cat /home/ubuntu/polyomica/projects/CWP_project/DESCRIPTORS/pain_gwas_ids.csv)

for gid in $gs_id
do
echo $gid

run_ldscore \
--h2 \
--gwas-id $gid

done
