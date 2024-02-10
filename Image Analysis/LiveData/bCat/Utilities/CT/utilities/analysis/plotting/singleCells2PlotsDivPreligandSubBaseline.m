%% norm to preligand and subtract baseline
function singleCells2PlotsDivPreligandSubBaseline(singleCells)
global analysisParam;
% format time
filterHigh = 65000;
mkdir(analysisParam.figDir);
% get ratios
colors = distinguishable_colors(analysisParam.nCon);

for iCon = 1:analysisParam.nCon;
    for iTime = find(~cellfun('isempty', singleCells{iCon}))
        R = singleCells{iCon}{iTime}(:,6)./singleCells{iCon}{iTime}(:,5);
        
    nuc2nucMeans(iCon,iTime) = meannonan(R(R<filterHigh)); % find means of ratios less than filterHigh
    nuc2nucStd(iCon,iTime) = stdnonan(R(R<filterHigh)); % 
    nCells(iCon,iTime) = size(R(R<filterHigh),1);
    end
end

preLigand = find(analysisParam.plotX(:)<0);

controlCondition = analysisParam.controlCondition;

for iCon = 1:analysisParam.nCon;
normalizer = mean(nuc2nucMeans(iCon,preLigand));
nuc2nucMeans(iCon,:) = nuc2nucMeans(iCon,:)./normalizer;
end
control = nuc2nucMeans(controlCondition,:);
control = medfilt1(control,13); %preserve noise
% plot nuc2nucMeans
figure; clf; hold on;
for iCon = 1:analysisParam.nCon;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nuc2nucMeans(iCon,:)-control,'Color',colors(iCon,:));
end
legend(analysisParam.conNames,'Location','eastoutside');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc]);
title('[(mean signaling : preligand) - control]');
xlim([analysisParam.xMin analysisParam.xMax]);
set(gcf,'Position',[1180,500,525,525]);
savefig('figures/Gfp2Rfp2PreligandSubBaseline.fig');
end
%close;