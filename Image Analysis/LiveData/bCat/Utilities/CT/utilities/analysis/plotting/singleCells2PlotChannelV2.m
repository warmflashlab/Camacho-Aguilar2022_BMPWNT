function [ output_args ] = singleCells2PlotChannelV2( singleCells,plotX,channel,filterHigh )
%singleCells2Plots generates a few plots to quickly look at singleCells
%dataset
%   
global analysisParam;
% format time


% get ratios
colors = distinguishable_colors(analysisParam.nCon);

for iCon = 1:analysisParam.nCon;
    for iTime = find(~cellfun('isempty', singleCells{iCon}))
        R = singleCells{iCon}{iTime}(:,channel);
        
    nuc2nucMeans(iCon,iTime) = meannonan(R(R<filterHigh)); % find means of ratios less than filterHigh
    nuc2nucStd(iCon,iTime) = stdnonan(R(R<filterHigh)); % 
    nCells(iCon,iTime) = size(R(R<filterHigh),1);
    end
end
% plot nuc2nucMeans
hold on;
for iCon = 1:analysisParam.nCon;
plot(plotX,nuc2nucMeans(iCon,:),'Color',colors(iCon,:));
end
%legend(analysisParam.conNames,'Location','best');
xlabel(['hours after ' analysisParam.ligandName ' added']);
x = plotX;
xMin = x(1);
xMax = x(length(x));
xlim([xMin xMax]);
if channel==5
title([analysisParam.yNuc]);
ylabel(['nuclear ' analysisParam.yNuc]);
savefig(['figures/' analysisParam.yNuc '.fig']);
end
if channel==6
title([analysisParam.yMolecule]);
ylabel(['nuclear ' analysisParam.yMolecule]);
%savefig(['figures/' analysisParam.yMolecule '.fig']);
end    



end

