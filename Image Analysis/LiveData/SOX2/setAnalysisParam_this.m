function setAnalysisParam_this
% for use with quickAnalysis function
global analysisParam;
fprintf(1, '%s called to define params\n',mfilename);

analysisParam.conNames = {'BMP 10ng/ml 0-48h';'BMP 2ng/ml 0-48h';'BMP 10ng/ml 0-24h,Noggin 24-48h';'BMP 50ng/ml 0-24h,Noggin 24-48h';...
                         'BMP 50ng/ml 0-24h,mTeSR 24-48h';'BMP 10ng/ml 0-24h,mTeSR 24-48h ';'BMP 5ng/ml 0-24h,mTeSR 24-48h';'mTeSR'};

analysisParam.conNamesPlot = {'BMP 10ng/ml 0-48h';'BMP 2ng/ml 0-48h';'BMP 10ng/ml 0-24h,Noggin 24-48h';'BMP 50ng/ml 0-24h,Noggin 24-48h';...
                         'BMP 50ng/ml 0-24h,mTeSR 24-48h';'BMP 10ng/ml 0-24h,mTeSR 24-48h ';'BMP 5ng/ml 0-24h,mTeSR 24-48h';'mTeSR'};


analysisParam.tLigandAdded = 3.75; %time ligand added in hours

analysisParam.tInterval = 0.25; %time interval between each frame

analysisParam.imbgprovided = 0; %This is equal to 1 if an empty image has been provided to substract background;

analysisParam.nucminlevel = 286; %If there is a population of cells that have low nuclear marker
analysisParam.data_direc_INPUT = ''; %Path to MaxI folder
analysisParam.data_direc_OUTPUT = ''; %Path to folder containing MaxI
ntimeframes = 207; %number of time frames

%% normally won't have to modify below
%%compute cells parameters
analysisParam.userParam = 'setUserParamForECA_ESI017_20x1024';
analysisParam.chan = [1 2]; %nuclear channel listed first
%% Main analysis parameters
analysisParam.nPos = 64; %total number of positions in dataset
analysisParam.nCon = 8; %total number of separate conditions
analysisParam.nMinutesPerFrame = 15; %minutes per frame
analysisParam.ligandName = 'BMP';
analysisParam.yMolecule = 'YFP-SOX2';
analysisParam.yNuc = 'CFP-H2B';

analysisParam.controlCondition = 8;

%% Shouldn't need to modify below
analysisParam.figDir = 'figuresV2';
analysisParam.outDirec = 'MIP-OutfilesV2';
analysisParam.isFixedCells = 0;
analysisParam.isAndorMovie = 1;
analysisParam.outDirecStyle = 1;% 1 for Andor IQ style (i.e., posX.mat) % 2 for Out_ConditionPrefix_X.mat style
 %directory containing outfiles for each position 
analysisParam.nPosPerCon = analysisParam.nPos./analysisParam.nCon; %set how many positions per condition
analysisParam.backgroundPositions = nan; %array of positions for bg subtraction
analysisParam.fig = 20; %set which figure to start plotting at
analysisParam.plotX = (0:(ntimeframes-1))*analysisParam.nMinutesPerFrame./60-analysisParam.tLigandAdded;
%find x Axis
positionConditions = zeros(analysisParam.nPosPerCon,analysisParam.nCon);
positionConditions(:) = 0:analysisParam.nPos-1;
analysisParam.positionConditions = positionConditions';
end