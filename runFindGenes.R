source('/data/ChIPSeqAnalysis/RScripts/geneFindR/findGeneReadFunctions.R')
source('/data/ChIPSeqAnalysis/RScripts//geneFindR/findGenes.R')
source('/data/ChIPSeqAnalysis/RScripts//geneFindR/findGeneFunctions.r')
source('/data/ChIPSeqAnalysis/RScripts//geneFindR/reformatMACSOut.R')

args <- commandArgs(trailingOnly = TRUE)
# args <- c('/data/ChIPSeqAnalysis/Experiments/WT1_300519/results/peakCalls/1_PCOS_AR_i7_filteredhg38_trim_bowtie2UPBlkLstRm_MACS_peaks.xls',
#           'MACS', '/data/ChIPSeqAnalysis/RScripts/geneTable/GeneCoordinates_ENSEMBL_Biomart150319sorted.txt',
#           '/data/ChIPSeqAnalysis/Experiments/WT1_300519/testOut2.xls')

args <- c('/data/ChIPSeqAnalysis/Experiments/ChIP_BRD4_OVCAR3/results_Brd4_OVCAR3_MACS2_BROAD_NO_TRIM/peakCalls/SRR3144652_1_bowtie2UPBlkLstRm_MACS2Small_peaks.xls',
          'MACS2', '/data/ChIPSeqAnalysis/RScripts/geneTable/GeneCoordinates_ENSEMBL_Biomart150319sorted.txt',
                     '/data/ChIPSeqAnalysis/Experiments/ChIP_BRD4_OVCAR3/results_Brd4_OVCAR3_MACS2_BROAD_NO_TRIM/peakCalls//testGnLst.xls' )

#args <- c('/home/rstudio/data2/testChr20_21PeakFile.xls',
#          'MACS', '/home/rstudio/scripts/geneTable/GeneCoordinates_ENSEMBL_Biomart150319sorted.txt',
#          '/home/rstudio/data2/WT1_300519/testChr20_21PeakFileOut.xls')
peaksFile = args[1]
programme = args[2]
geneFile= args[3] #'../geneTable/NCBIgenes301014_ensembldesc171114.xls'
outputPath = args[4]

if (length(args) > 4){
  dist = as.numeric(args[5])
}else {
  
  dist = 10000
}
if (length(args) > 5){
  pValue = as.numeric(args[6])
} else {
  
  pValue = 1
}
if (length(args) > 6){
  FDR = as.numeric(args[7])
} else {
  FDR = 100
}


print(geneFile)
print(peaksFile)
print(outputPath)
print(programme)


if (programme == 'MACS' | programme == 'MACS2'){
  reformatMACSOut(peaksFile)  
}


## Run the gene finder

if (programme == 'MACS' | programme == 'MACS2'){
  peaksFileMod = gsub('.xls', '_modified.xls', peaksFile)
} else {
  peaksFileMod = peaksFile
}

findGenes(peaksFileMod,programme,geneFile,dist,pValue,FDR,outputPath)
