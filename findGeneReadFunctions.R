readMACS = function(filename){
	peaks=read.table(filename,header=T,fill=T,sep='\t')
	peaks$summit=peaks$summit+peaks$start
	peaks$p_value=10^(-peaks$X.10.log10.pvalue./10)
	peaks=peaks[,c('chr_no','start','end','length','summit','FDR...','p_value', 'tags', 'fold_enrichment')]
	peaks$MACS_SICER='MACS'
	colnames(peaks)[5:6, 8]=c('summit/centre','FDR', 'pileup') # Change column names from FDR(%) to FDR and summit to summit/centre
	peaks
}

readMACS2 = function(filename){
  #browser()
  peaks=read.table(filename,header=T,fill=T,sep='\t')
  
  if ("abs_summit" %in% colnames(peaks)){
    peaks$summit=peaks$abs_summit
    
  } else {
    peaks$summit=(peaks$end - peaks$start)/2 + peaks$start

  }
  peaks=peaks[,c('chr_no','start','end','length','summit','X.log10.pvalue.', 'X.log10.qvalue.', 'pileup', 'fold_enrichment')]
  peaks$MACS_SICER='MACS2'
  colnames(peaks)[5]=c('summit/centre') # Change column names from FDR(%) to FDR and summit to summit/centre
  peaks  
}

readSICER = function(filename){
	peaks=read.table(filename,fill=T)
	colnames(peaks)=c("chrom", "start", "end", "ChIP_island_read_count", "CONTROL_island_read_count","p_value", "fold_change", "FDR","chr_no","centre") #10 columns
	peaks$length=peaks$end-peaks$start+1
	peaks=peaks[,c('chr_no','start','end','length','centre','FDR','p_value')]
	peaks$MACS_SICER='SICER'
	colnames(peaks)[5]='summit/centre'
	peaks=peaks[which(peaks$chr_no!=-1),]
	peaks
}