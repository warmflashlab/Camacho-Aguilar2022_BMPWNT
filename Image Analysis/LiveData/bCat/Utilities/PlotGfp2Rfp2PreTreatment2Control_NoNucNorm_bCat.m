function PlotGfp2Rfp2PreTreatment2Control_NoNucNorm_bCat(data_direc_OUT,plotError,plotlegend,newplot,blackbackground)

load([data_direc_OUT filesep 'singlecells.mat'])
if newplot
figure;
set(gcf,'Position',[10 10 1200 700])
end

% setAnalysisParam_this
global analysisParam;
controlCondition = analysisParam.controlCondition;
colors = distinguishable_colors(analysisParam.nCon,{'w','k'});
% colors([3,5,6],:) = 0;


filterHigh = 65000;
nucmin=0;

% nconditionsplot = [1:4,7];
% nconditionsplot = [12:-1:9,7];
% nconditionsplot = [13:16,7];
% nconditionsplot = [5,8,17,6,7];
% nconditionsplot = [4,9,16,6,7];
% nconditionsplot = [1,12,13,5,7];
% nconditionsplot = [1:4,12:-1:9,13:16,5,8,17,6,7];
nconditionsplot = [1:8]

for iCon = 1:analysisParam.nCon;
    for iTime = find(~cellfun('isempty', singleCells{iCon}))
        R = singleCells{iCon}{iTime}(:,6);%./singleCells{iCon}{iTime}(:,5);
        
    nuc2nucMeans(iCon,iTime) = meannonan(R((R<filterHigh)&(singleCells{iCon}{iTime}(:,5)>nucmin))); % find means of ratios less than filterHigh
    nuc2nucStd(iCon,iTime) = stdnonan(R((R<filterHigh)&(singleCells{iCon}{iTime}(:,5)>nucmin))); % 
    nCells(iCon,iTime) = size(R((R<filterHigh)&(singleCells{iCon}{iTime}(:,5)>nucmin)),1);
    nCells(iCon,iTime)
    end
end
size(nuc2nucMeans)
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
    for iCon = 1:analysisParam.nCon; %[3,5,6,1,2,4,7,8]%
        y = nuc2nucMeans(iCon,:)./control;
        e = QuotientError(nuc2nucMeans(iCon,:),control,nuc2nucStd(iCon,:),controlSigma)./sqrt(nCells(iCon,:));        
        s = errorbar(analysisParam.plotX(1:size(nuc2nucMeans,2)),y,e,'LineWidth',2,'Color',colors(iCon,:));
    end
end



if blackbackground 

if plotlegend
[~, hobj, ~, ~] =legend(analysisParam.conNames{nconditionsplot},'Location','eastoutside','FontSize',18,'FontName','Myriad Pro','LineWidth',2,'TextColor','w','Color','k','EdgeColor','w');
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',2,'Color','w');
end
% ht = findobj(hobj,'type','text')
% set(ht,'FontSize',10);
xlabel(['hours after ' analysisParam.ligandName ' added'],'FontSize',18,'FontName','Myriad Pro','FontWeight','bold','Color','w');
%,'Interpreter','latex','FontWeight','bold');
ylabel([analysisParam.yMolecule ':Pretreatment:Control'],'FontSize',18,'FontName','Myriad Pro','FontWeight','bold','Color','w');
if ~newplot
title('GFP:PreTreatment:Control','Color','w');
end
xlim([xMin xMax]);

ax = gca; 
ax.XTickMode = 'manual';
ax.YTickMode = 'manual';
ax.ZTickMode = 'manual';
ax.XLimMode = 'manual';
ax.YLimMode = 'manual';
ax.ZLimMode = 'manual';

set(gca,'Color','k')
set(gca,'XColor','w')
set(gca,'YColor','w')




fig = gcf;
fig.Color = 'k';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

saveas(fig,[analysisParam.figDir filesep 'Black-GFP2Pre2Control-bCat-All'],'fig')
saveas(fig,[analysisParam.figDir filesep 'Black-GFP2Pre2Control-bCat-All'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep 'Black-GFP2Pre2Control-bCat-All'],'pdf')
    
    
    
    
else


if plotlegend
[~, hobj, ~, ~] =legend(analysisParam.conNames,'Location','eastoutside','FontSize',18,'FontName','Arial','LineWidth',2);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',2);
end
% ht = findobj(hobj,'type','text')
% set(ht,'FontSize',10);
xlabel(['hours after ' analysisParam.ligandName ' added'],'FontSize',18,'FontName','Arial','FontWeight','bold');
%,'Interpreter','latex','FontWeight','bold');
ylabel([analysisParam.yMolecule ':Pretreatment:Control'],'FontSize',18,'FontName','Arial','FontWeight','bold');
if ~newplot
title('GFP:PreTreatment:Control');
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

set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

saveas(fig,[analysisParam.figDir filesep 'GFP2Pre2Control-bCat'],'fig')
saveas(fig,[analysisParam.figDir filesep 'GFP2Pre2Control-bCat'],'svg')


set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep 'Black-GFP2Pre2Control-bCat'],'pdf')
    
end