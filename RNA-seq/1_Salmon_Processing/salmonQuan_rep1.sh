## Start process file on by one
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 a1_U_1.fq.gz -2 a1_U_2.fq.gz --validateMappings -o transcripts_quant_a1
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 a2_C6_1.fq.gz -2 a2_C6_2.fq.gz --validateMappings -o transcripts_quant_a2
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 a3_SL6_1.fq.gz -2 a3_SL6_2.fq.gz --validateMappings -o transcripts_quant_a3
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 a4_SL18_1.fq.gz -2 a4_SL18_2.fq.gz --validateMappings -o transcripts_quant_a4
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 a5_W6_1.fq.gz -2 a5_W6_2.fq.gz --validateMappings -o transcripts_quant_a5
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 a6_W18_1.fq.gz -2 a6_W18_2.fq.gz --validateMappings -o transcripts_quant_a6
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 a7_SWL6_1.fq.gz -2 a7_SWL6_2.fq.gz --validateMappings -o transcripts_quant_a7
salmon quant -l A -i ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default -1 a8_SWL18_1.fq.gz -2 a8_SWL18_2.fq.gz --validateMappings -o transcripts_quant_a8
# -l A auto mode to recognize pair-end
# pre-computed index: ~/CRAZY_SCIENNY/RNA-Seq/Salmon/Pre-computed_index/default
