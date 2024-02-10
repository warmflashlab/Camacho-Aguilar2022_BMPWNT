function [meanG2R semG2R] = singleCells2GFP2RFP(singleCells)
%singleCells2GFP2RFP takes singleCells array and outputs GFP2RFP, a matrix of [conditionXtime] 
global analysisParam;
for iCon = 1:analysisParam.nCon;
[meanG2R(iCon,:) semG2R(iCon,:)] = cellfun(@getGFP2RFP,singleCells{iCon});
end
end

