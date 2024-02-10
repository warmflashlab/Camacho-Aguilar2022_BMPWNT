
%AnalysisParamScript

global analysisParamCellClassification;

fprintf(1, '%s called to define params\n',mfilename);


%% Plate 1
analysisParamCellClassification(1).ExperimentName = '220909_BMPCommitment_Exp77';
analysisParamCellClassification(1).dataSegmentation = 'Plate1_AllDataMatrixDAPINorm.mat';
analysisParamCellClassification(1).NumofPlates = 1;
analysisParamCellClassification(1).NamesConditions ={'mTeSR 0-48h','BMP10 0-16, mTeSR 16-48h','BMP10+IWP2 0-4, CHIR15+IWP2 4-48h','CHIR15 0-48h',...
                                'BMP10+IWP2 0-4, CHIR10+IWP2 4-48h','CHIR10 0-48h'};              
analysisParamCellClassification(1).nCon = 6;
analysisParamCellClassification(1).conNamesPlot = {'mTeSR 0-48h','BMP10 0-16, mTeSR 16-48h','BMP10+IWP2 0-4, CHIR15+IWP2 4-48h','CHIR15 0-48h',...
                                'BMP10+IWP2 0-4, CHIR10+IWP2 4-48h','CHIR10 0-48h'};
%analysisParam.conNamesPlot = {{'mTeSR', '0-48h'};{'BMP', '0-4h'};{'BMP', '0-8h'};{'BMP', '0-16h'};{'BMP', '0-24h'};{'BMP', '0-32h'};{'BMP', '0-40h'};{'BMP', '0-48h'}};
analysisParamCellClassification(1).ConditionOrder = [1:6];
analysisParamCellClassification(1).nChannels = 3;
analysisParamCellClassification(1).ChannelOrder = [2,3,1];
analysisParamCellClassification(1).Channels = {'ISL1','SOX2','BRA'};
analysisParamCellClassification(1).ChannelOrder3D = [1,2,3];

analysisParamCellClassification(1).ChannelsLimsFile = 'QuantileLimitsData.mat';

analysisParamCellClassification(1).figDir = 'figures';