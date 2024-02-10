function setAnalysisParam_this
% for use with quickAnalysis function
global analysisParam;
fprintf(1, '%s called to define params\n',mfilename);

analysisParam.conNames = {'BMP 0-8h';'BMP 0-16h';'BMP 0-32h';'mTeSR 0-48h';...
                         'BMP 0-48h';'BMP 0-32h,Noggin 32-48h';'BMP 0-16h,Noggin 16-48h ';'BMP 0-8h,Noggin 8-48h'};
analysisParam.conNamesPlot = {'BMP 0-8h';'BMP 0-16h';'BMP 0-32h';'mTeSR';...
                         'BMP 0-48h';{'BMP 0-32h','Noggin 32-48h'};{'BMP 0-16h','Noggin 16-48h'};{'BMP 0-8h','Noggin 8-48h'}};

analysisParam.tLigandAdded = 3; %time ligand added in hours

analysisParam.tInterval = 20/60; %time interval between each frame

ntotaltimepoints = 57;


%% normally won't have to modify below
%%compute cells parameters
analysisParam.userParam = 'setUserParam_esi017_20x';
analysisParam.chan = [2 1]; %nuclear channel listed first
analysisParam.data_direc = 'MaxI';
%% Main analysis parameters
analysisParam.nPos = 64; %total number of positions in dataset
analysisParam.nCon = 8; %total number of separate conditions
analysisParam.nMinutesPerFrame = 20; %minutes per frame
analysisParam.ligandName = 'treatment';
analysisParam.yMolecule = 'GFP-beta-catenin';
analysisParam.yNuc = 'RFP-H2B';

analysisParam.controlCondition = 8;



%% Shouldn't need to modify below
analysisParam.lastTimePoint = (ntotaltimepoints-1)*analysisParam.nMinutesPerFrame./60-analysisParam.tLigandAdded;
analysisParam.figDir = 'figures';
analysisParam.outDirec = 'MaxI-OutfilesV2'
analysisParam.isFixedCells = 0;
analysisParam.isAndorMovie = 1;
analysisParam.outDirecStyle = 1;% 1 for Andor IQ style (i.e., posX.mat) % 2 for Out_ConditionPrefix_X.mat style
 %directory containing outfiles for each position 
analysisParam.nPosPerCon = analysisParam.nPos./analysisParam.nCon; %set how many positions per condition
analysisParam.backgroundPositions = nan; %array of positions for bg subtraction
analysisParam.fig = 20; %set which figure to start plotting at
%find x Axis
load([analysisParam.outDirec filesep 'pos0.mat']);
analysisParam.plotX = (0:(ntotaltimepoints-1))*analysisParam.nMinutesPerFrame./60-analysisParam.tLigandAdded;
positionConditions = zeros(analysisParam.nPosPerCon,analysisParam.nCon);
positionConditions(:) = 0:analysisParam.nPos-1;
analysisParam.positionConditions = positionConditions';
end