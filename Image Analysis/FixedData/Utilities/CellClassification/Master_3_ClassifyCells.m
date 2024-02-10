%% Classify cells

%% First, save data in singleCells format
% Go to savesingleCells.m and modify parameters. Then run this section

savesingleCells

%% Second, set parameters for cell classification
% Go to AnalysisParamScript_2 and set up parameters
% Go to CellClassifParamScript and set up path and parameters
% Run this section

CellClassificationFunction

%% Plot Cell Classification

%48h
plotCellClassificationFixedSingleTimePointv2(1,1,1) 
ScatterCellClassificationFixedSingleTimePointv2(1,1)

%72h
plotCellClassificationFixedSingleTimePointv2(2,1,1) 
ScatterCellClassificationFixedSingleTimePointv2(2,1)
