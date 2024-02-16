if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.16")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("SummarizedExperiment")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("tximeta")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("edgeR")

###################




# load the summarized experiment  and tximeta packages. 
suppressPackageStartupMessages(library(SummarizedExperiment))
library(tximeta) #load tximeta package


# Make a list of the data files and condition names in a dataframe:
prefix = 'data_processedby_Salmon/'
fn = 'quant.sf'
files <- c(file.path(prefix,'transcripts_quant_mTeSR_r1_20190521',fn), file.path(prefix,'transcripts_quant_WNT6h_r1_20190521',fn), file.path(prefix,'transcripts_quant_WNT18h_r1_20190521',fn),file.path(prefix,'transcripts_quant_CHIR6h_r1_20190521',fn),file.path(prefix,'transcripts_quant_mTeSR_r2_20220228',fn), file.path(prefix,'transcripts_quant_WNT6h_r2_20220228',fn), file.path(prefix,'transcripts_quant_WNT18h_r2_20220228',fn),file.path(prefix,'transcripts_quant_CHIR6h_r2_20220228',fn),file.path(prefix,'transcripts_quant_CHIR18h_r1_20220228',fn),file.path(prefix,'transcripts_quant_CHIR18h_r2_20220228',fn))
coldata <- data.frame(files,names = c("mTeSR","WNT6h","WNT18h","CHIR6h","mTeSR","WNT6h","WNT18h","CHIR6h","CHIR18h","CHIR18h"),conditions = c("r1","r1","r1","r1","r2","r2","r2","r2","r2","r3"),stringsAsFactors = FALSE)
# View(coldata)

se <- tximeta(coldata) #run on all conditions, outputs a summarizeExperiment


# these are good functions for examining the data. 
# colData(se)
# assayNames(se)
# rowRanges(se)
# seqinfo(se)
#se.exons <- addExons(se)

# summarize to gene level. Typically, abundance is provided by the quantification tools as TPM (transcripts-per-million), while the counts are estimated counts (possibly fractional), and the "length" matrix contains the effective gene lengths.
gse <- summarizeToGene(se)
rnaDataFrame = data.frame(rowData(gse)$symbol,assays(gse)$counts) #export gene symbols and counts as df
write.csv(rnaDataFrame,'/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/LabFiles/Siqi/RNA-seq/For_Elena/Analysis_ECA/WNTdata_bulkRNASeqExpressionMat_samenamesrepeats.csv')

