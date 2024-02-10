global CellClassifParam


CellClassifParam.data_direc_OUT = 'Fig7E/Data';
                                          %ISL1  SOX2  BRA  
CellClassifParam.NegativePopConditions = {[1,1],[1,3],[1,1]}; %[Plate,Well]
CellClassifParam.PositivePopConditions = {[1,6],[1,1],[1,4]};
CellClassifParam.nChannels = 3;
CellClassifParam.startGeneData = 3;
CellClassifParam.NumofSubexperiments = 1;

CellClassifParam.propclassification1 = 0.5;
CellClassifParam.propclassification2 = 0.8;

CellClassifParam.nLabels = 8;
CellClassifParam.ClassificationLabels = {'All Low','SOX2+','SOX2+/BRA+','BRA+','BRA+/CDX2+','CDX2+','SOX2+/CDX2+','Mix All Markers'};
