
setwd("~/OneDrive - King's College London/UKB_GWAS_analysis_Files/CWP_WHOLE_26April/Genetic Correlations with other traits")

wc <- fread("all_sample_gc.rg.results.csv",data.table=F)

setwd("~/Downloads")

load("20190215_maping_225_traits_and_GC_v2.RData")

cleaning=function(GClho){
  GClho=GClho[which(GClho$Category!="ukbb"),]
  GClho=GClho[!is.na(GClho$rg),]
  
  dup_tr=unique(GClho$trait2[duplicated(GClho$trait2)])
  tr=dup_tr[1]
  for(tr in dup_tr){
    ind=which(GClho$trait2==tr) 
    print(GClho$PMID[ind])
    ind=ind[-which.max(GClho$PMID[ind])[1]]
    print(GClho$PMID[ind])
    GClho=GClho[-ind,]
  }
  
  dim(GClho)
  ind=which(GClho$trait2%in%c("Years of schooling (proxy cognitive performance)","Years of schooling 2013")) 
  GClho=GClho[-ind,]
  dim(GClho)
  ind=which(GClho$trait2%in%c("Years of schooling 2016"))
  GClho$trait2[ind]="Years of schooling"
  print(dim(GClho))
  
  trts=intersect(map$trait2,GClho$trait2)
  GClho=GClho[GClho$trait2%in%trts,]
  map_c=map[map$trait2%in%trts,]
  
  ind=match(map_c$trait2,GClho$trait2)
  table(map_c$trait2==GClho$trait2[ind])
  
  GClho=GClho[ind,]
  print(dim(GClho))
  
  
  return(GClho)
}

gpc1=cleaning(wc)

table(map[,2:5]==gpc1[,2:5])


######

thr=0.01/(nrow(gpc1))
thr_rg=0.2
trts=gpc1[(gpc1$p<=thr & abs(gpc1$rg)>=thr_rg),"trait2"]


ind=which(gpc1$trait2%in%trts)
gpc1=gpc1[ind,]

map=map[ind,]
GC=GC[ind,ind]

##########
GClho=gpc1
trls=paste(GClho[,2]," [",GClho$PMID,"]",sep="")
out_rg=out_p=array(NA,c(length(trls)+1,length(trls)+1))
colnames(out_rg)=rownames(out_rg)=c("CWP [this  study]",trls)
colnames(out_p)=rownames(out_p)=colnames(out_rg)

out_rg[-(1),-(1)]=as.matrix(GC)
#out_p[-(1),-(1)]=GC

out_rg[1,-(1)]=gpc1[,"rg"]
out_rg[-(1),1]=gpc1[,"rg"]

diag(out_rg)=1
diag(out_p)=0
out_rg[out_rg>1]=1
out_rg[out_rg<(-1)]=-1

#PLOT
org=out_rg
dd=(1-abs(org))

d=as.dist(dd)
h1=hclust(d,method="ward.D2")
#h1=hclust(d,method="single")
#pdf("20190423_hclust_gpc1.pdf",width = 7,height = 7)
plot(h1,hang = -1)
#dev.off()
library(corrplot)
#dd=out_rg[-1,-1]
dd=org

dd2plot=dd[h1$order,h1$order]
pdf("20200205_CWP_gencors.pdf",width = 10,height = 10)
corrplot(corr = dd2plot,method = "square",tl.col="black",
         tl.srt = 75)
dev.off()





