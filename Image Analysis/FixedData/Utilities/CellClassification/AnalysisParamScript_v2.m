
%AnalysisParamScript

global analysisParamCellClassification;

fprintf(1, '%s called to define params\n',mfilename);


%% Plate 1
analysisParamCellClassification(1).ExperimentName = '230609_BMPCommitment_Exp99_48h';
analysisParamCellClassification(1).dataSegmentation = 'Plate1_AllDataMatrixDAPINorm.mat';
analysisParamCellClassification(1).NumofPlates = 2;
analysisParamCellClassification(1).NamesConditions ={'mTeSR 48h','BMP 0.3ng/ml 48h','BMP 1ng/ml 48h','BMP 1.5ng/ml 48h','BMP 10ng/ml 48h','BMP 10ng/ml 0-16h, mTeSR 16-48h','BMP 2.5ng/ml 48h','BMP 2ng/ml 48h'};              
analysisParamCellClassification(1).nCon = 8;
analysisParamCellClassification(1).conNamesPlot = {'mTeSR 48h','BMP 0.3ng/ml 48h','BMP 1ng/ml 48h','BMP 1.5ng/ml 48h','BMP 10ng/ml 48h','BMP 10ng/ml 0-16h, mTeSR 16-48h','BMP 2.5ng/ml 48h','BMP 2ng/ml 48h'};
analysisParamCellClassification(1).ConditionOrder = [1 2 3 4 8 7 6 5];
analysisParamCellClassification(1).nChannels = 3;
analysisParamCellClassification(1).ChannelOrder = [2,3,1];
analysisParamCellClassification(1).Channels = {'ISL1','SOX2','BRA'};
analysisParamCellClassification(1).ChannelOrder3D = [1,2,3];

analysisParamCellClassification(1).ChannelsLimsFile = 'QuantileLimitsData.mat';

analysisParamCellClassification(1).figDir = 'figures';

%% Plate 2

analysisParamCellClassification(2).ExperimentName = '230609_BMPCommitment_Exp99_72h';
analysisParamCellClassification(2).dataSegmentation = 'Plate1_AllDataMatrixDAPINorm.mat';
analysisParamCellClassification(2).NumofPlates = 2;
analysisParamCellClassification(2).NamesConditions ={'mTeSR 72h','BMP 0.3ng/ml 72h','BMP 1ng/ml 72h','BMP 1.5ng/ml 72h','BMP 10ng/ml 72h','BMP 10ng/ml 0-16h, mTeSR 16-72h','BMP 2.5ng/ml 72h','BMP 2ng/ml 72h'};
analysisParamCellClassification(2).nCon = 8;
analysisParamCellClassification(2).conNamesPlot = {'mTeSR 72h','BMP 0.3ng/ml 72h','BMP 1ng/ml 72h','BMP 1.5ng/ml 72h','BMP 10ng/ml 72h','BMP 10ng/ml 0-16h, mTeSR 16-72h','BMP 2.5ng/ml 72h','BMP 2ng/ml 72h'};
analysisParamCellClassification(2).ConditionOrder = [1 2 3 4 8 7 6 5];
analysisParamCellClassification(2).nChannels = 3;
analysisParamCellClassification(2).ChannelOrder = [2,3,1];
analysisParamCellClassification(2).Channels = {'ISL1','SOX2','BRA'};
analysisParamCellClassification(2).ChannelOrder3D = [1,2,3];

analysisParamCellClassification(2).ChannelsLimsFile = 'QuantileLimitsData.mat';

analysisParamCellClassification(2).figDir = 'figures';


