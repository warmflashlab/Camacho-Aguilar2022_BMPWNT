function PlotGfp2Rfp2PT2Ct(singleCells,plotError)
%% this is not complete as of 4/6/18 -- low priority
%% this version normalizes conditions to a best fit of the control condition as opposed to a median filtered control condition
global analysisParam;
controlCondition = analysisParam.controlCondition;
colors = distinguishable_colors(analysisParam.nCon);
filterHigh = 65000;
for iCon = 1:analysisParam.nCon;
    for iTime = find(~cellfun('isempty', singleCells{iCon}))
        R = singleCells{iCon}{iTime}(:,6)./singleCells{iCon}{iTime}(:,5);
        
    nuc2nucMeans(iCon,iTime) = meannonan(R(R<filterHigh)); % find means of ratios less than filterHigh
    nuc2nucStd(iCon,iTime) = stdnonan(R(R<filterHigh)); % 
    nCells(iCon,iTime) = size(R(R<filterHigh),1);
    end
end


preLigand = find(analysisParam.plotX(:)<0);

x = analysisParam.plotX(1:size(nuc2nucMeans,2));

xMin = x(1);
xMax = x(length(x));

for iCon = 1:analysisParam.nCon;
normalizer = mean(nuc2nucMeans(iCon,preLigand));
yy = std(nuc2nucMeans(iCon,preLigand));
x = nuc2nucMeans(iCon,:);
nuc2nucMeans(iCon,:) = x./normalizer;
xx=nuc2nucStd(iCon,:);
nuc2nucStd(iCon,:) = QuotientError(x,normalizer,xx,yy);
end
% plot 
hold on;

control = nuc2nucMeans(controlCondition,:);
control = medfilt1(control,13);
controlSigma = nuc2nucStd(controlCondition,:);

for iCon = 1:analysisParam.nCon;
    y = nuc2nucMeans(iCon,:)./control;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),y,'Color',colors(iCon,:));
end

if plotError == 1
    for iCon = 1:analysisParam.nCon;
        y = nuc2nucMeans(iCon,:)./control;
        e = QuotientError(nuc2nucMeans(iCon,:),control,nuc2nucStd(iCon,:),controlSigma)./sqrt(nCells(iCon,:));        
        s = errorbar(analysisParam.plotX(1:size(nuc2nucMeans,2)),y,e,'LineWidth',.1,'Color',colors(iCon,:));
    end
end


legend(analysisParam.conNames,'Location','eastoutside');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc]);
title('GFP:RFP:PreTreatment:Control');
xlim([xMin xMax]);
end