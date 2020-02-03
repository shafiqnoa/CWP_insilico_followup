$!/bin/bash

clickhouse-client -h localhost --query="select gwas_id from geliphe.snp where chr==$1 and bp>$2-250000 and bp<$2+250000 and gwas_id between 4740 and 1282179 group by gwas_id;" > $3
