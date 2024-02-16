## Start process file on by one
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 SD_C6_1.fq.gz -2 SD_C6_2.fq.gz --validateMappings -o transcripts_quant_C6
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 SD_C18_1_1.fq.gz -2 SD_C18_1_2.fq.gz --validateMappings -o transcripts_quant_C18_1
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 SD_C18_2_1.fq.gz -2 SD_C18_2_2.fq.gz --validateMappings -o transcripts_quant_C18_2
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 SD_U_1.fq.gz -2 SD_U_2.fq.gz --validateMappings -o transcripts_quant_U
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 SD_W6_1.fq.gz -2 SD_W6_2.fq.gz --validateMappings -o transcripts_quant_W6
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 SD_W18_1.fq.gz -2 SD_W18_2.fq.gz --validateMappings -o transcripts_quant_W18
# -l A auto mode to recognize pair-end
# pre-computed index: ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default
