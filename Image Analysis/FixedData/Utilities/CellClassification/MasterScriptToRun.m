%% Script Analysis

% Uncomment the AllPlates part in AnalysisParamScript.m and run:
FindLimitsData


%% Create singleCells Matrix

savesingleCells
load('singleCells')

%% Cell Classification
% First change CellClassifParamScript and AnalysisParamScript_v2
CellClassificationFunction

%% Plot Cell Classification

plotCellClassificationFixedSingleTimePointv2(1,1,1) 
ScatterCellClassificationFixedSingleTimePointv2(1,1)

%%
plotCellClassificationFixedSingleTimePointv2(2,1,1) 
ScatterCellClassificationFixedSingleTimePointv2(2,1)

%%
plotCellClassificationFixedSingleTimePointv2(3,1,1) 
ScatterCellClassificationFixedSingleTimePointv2(3,1)

%%
plotCellClassificationFixedSingleTimePointv2(4,1,1) 
ScatterCellClassificationFixedSingleTimePointv2(4,1)


%%
plotCellClassificationFixedSingleTimePointv2(5,1,1) 
ScatterCellClassificationFixedSingleTimePointv2(5,1)

%%
ScatterCellClassificationFixedSingleTimePointv2_CMYK_1Condition(1,4,0,1) 

%%
plotCellClassificationFixedSingleTimePointv2_CMYK(1,0,0) 
 
