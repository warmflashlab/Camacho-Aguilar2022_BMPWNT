
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
load('allPeaks.mat');
setAnalysisParam_this;
global analysisParam;

%% plotting
figure(6); clf; hold on;
for iCon = 1:analysisParam.nCon
    
    for iPos = 1:analysisParam.nPosPerCon
        for iTime = 1:length(allPeaks{iCon,iPos})
            nCells(iPos,iTime) = size(allPeaks{iCon,iPos}{iTime},1);
            
        end
        
    end
    nCells(nCells == 0) = nan;
        minVector(iCon) = min(min(nCells));
        maxVector(iCon) = max(max(nCells));
    if analysisParam.nCon > 8;
        subplot(2,6,iCon);
    else
        subplot(2,4,iCon);
    end
    plot(nCells');
    clear nCells;
end
for iCon = 1:analysisParam.nCon
    if analysisParam.nCon > 8;
        subplot(2,6,iCon);
    else
        subplot(2,4,iCon);
    end
    title(analysisParam.conNames(iCon));
ylim([min(minVector) max(maxVector)]);
xlim([1 iTime]);
end
legend(int2str([1:analysisParam.nPosPerCon]'));

