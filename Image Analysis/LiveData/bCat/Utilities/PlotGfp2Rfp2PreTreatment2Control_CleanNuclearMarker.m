function PlotGfp2Rfp2PreTreatment2Control_CleanNuclearMarker(singleCells,plotError,plotlegend,newplot)

if newplot
figure;
set(gcf,'Position',[10 10 900 600])
end

global analysisParam;
global userParam;


controlCondition = analysisParam.controlCondition;
colors = distinguishable_colors(analysisParam.nCon);
filterHigh = 65000;
for iCon = 1:analysisParam.nCon;
    for iTime = find(~cellfun('isempty', singleCells{iCon}))
        R = singleCells{iCon}{iTime}(:,6)./singleCells{iCon}{iTime}(:,5);
        NArea = singleCells{iCon}{iTime}(:,3);

        goodpart = find((R<filterHigh)&(NArea>=userParam.nucAreaLo)&(NArea<=userParam.nucAreaHi));
        
    nuc2nucMeans(iCon,iTime) = meannonan(R(goodpart)); % find means of ratios less than filterHigh
    nuc2nucStd(iCon,iTime) = stdnonan(R(goodpart)); % 
    nCells(iCon,iTime) = size(R(goodpart),1);
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
        s = errorbar(analysisParam.plotX(1:size(nuc2nucMeans,2)),y,e,'LineWidth',2,'Color',colors(iCon,:));
    end
end



if plotlegend
[~, hobj, ~, ~] =legend(analysisParam.conNames,'Location','eastoutside','FontSize',14,'FontName','Arial','LineWidth',2);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',2);
end
% ht = findobj(hobj,'type','text')
% set(ht,'FontSize',10);
xlabel(['hours after ' analysisParam.ligandName ' added'],'FontSize',12,'FontName','Arial','FontWeight','bold');
%,'Interpreter','latex','FontWeight','bold');
ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc],'FontSize',12,'FontName','Arial','FontWeight','bold');
if ~newplot
title('GFP:RFP:PreTreatment:Control');
end
xlim([xMin xMax]);

ax = gca; 
ax.XTickMode = 'manual';
ax.YTickMode = 'manual';
ax.ZTickMode = 'manual';
ax.XLimMode = 'manual';
ax.YLimMode = 'manual';
ax.ZLimMode = 'manual';

fig = gcf;
saveas(fig,[analysisParam.figDir filesep 'GFP2RFP2Pre2Control-2Prueba-CleanNuclearMarker'],'fig')
saveas(fig,[analysisParam.figDir filesep 'GFP2RFP2Pre2Control-2Prueba-CleanNuclearMarker'],'svg')
end