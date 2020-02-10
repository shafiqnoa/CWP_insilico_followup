for gid in 0 1 2 3 4 5 6 7 8 9 10
do
echo $gid
run_upload \
--gwas-path=/home/ubuntu/polyomica/projects/CWP_project/DRG_DATA_UNIFIED/pp0_MF_output/pp0_MF_unification_"$gid"_done.csv \
2>&1 | tee /home/ubuntu/polyomica/projects/CWP_project/DRG_DATA_UNIFIED/pp0_MF_output/log_upload_"$gid".txt

done