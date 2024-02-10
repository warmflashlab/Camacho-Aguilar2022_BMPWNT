function plotCounts_black(singleCells,blackbackground)

plotlegend=0;
%% plotting detected cells
global analysisParam;
% format time

%mkdir(analysisParam.figDir);
% get ratios
colors = distinguishable_colors(analysisParam.nCon,{'w','k'});
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

for iCon = 1:analysisParam.nCon;
    hold on
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nCells(iCon,:),'Color',colors(iCon,:));
end
%legend(analysisParam.conNames,'Location','eastoutside');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel('# of cells');
x = analysisParam.plotX(1:size(nuc2nucMeans,2));
xMin = x(1);
xMax = x(length(x));

analysisParam.xMin = x(1);
analysisParam.xMax = x(length(x));
xlim([xMin xMax]);
title('detected cells');
%savefig('figures/#cells.fig');
xlim([xMin 48]);
ylim([0 6000])

if blackbackground 

if plotlegend
[~, hobj, ~, ~] =legend(analysisParam.conNames,'Location','eastoutside','FontSize',18,'FontName','Arial','LineWidth',2,'TextColor','w','Color','k','EdgeColor','w');
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',2,'Color','w');
end
% ht = findobj(hobj,'type','text')
% set(ht,'FontSize',10);
% xlabel(['hours after ' analysisParam.ligandName ' added'],'FontSize',18,'FontName','Arial','FontWeight','bold','Color','w');
%,'Interpreter','latex','FontWeight','bold');
% ylabel([analysisParam.yMolecule ':Pretreatment:Control'],'FontSize',18,'FontName','Arial','FontWeight','bold','Color','w');
% if ~newplot
% title('GFP:PreTreatment:Control','Color','w');
% end


ax = gca; 
% ax.XTickMode = 'manual';
% ax.YTickMode = 'manual';
% ax.ZTickMode = 'manual';
% ax.XLimMode = 'manual';
% ax.YLimMode = 'manual';
% ax.ZLimMode = 'manual';

set(gca,'Color','k')
set(gca,'XColor','w')
set(gca,'YColor','w')




fig = gcf;
fig.Color = 'k';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

saveas(fig,[analysisParam.figDir filesep 'Black-CellCount'],'fig')
saveas(fig,[analysisParam.figDir filesep 'Black-CellCount'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep 'Black-CellCount'],'pdf')
    
    
    
    
else


if plotlegend
[~, hobj, ~, ~] =legend(analysisParam.conNames,'Location','eastoutside','FontSize',18,'FontName','Arial','LineWidth',2);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',2);
end
% ht = findobj(hobj,'type','text')
% set(ht,'FontSize',10);
% xlabel(['hours after ' analysisParam.ligandName ' added'],'FontSize',18,'FontName','Arial','FontWeight','bold');
% %,'Interpreter','latex','FontWeight','bold');
% ylabel([analysisParam.yMolecule ':Pretreatment:Control'],'FontSize',18,'FontName','Arial','FontWeight','bold');
% % if ~newplot
% % title('GFP:PreTreatment:Control');
% % end
% xlim([xMin xMax]);

ax = gca; 
% ax.XTickMode = 'manual';
% ax.YTickMode = 'manual';
% ax.ZTickMode = 'manual';
% ax.XLimMode = 'manual';
% ax.YLimMode = 'manual';
% ax.ZLimMode = 'manual';




fig = gcf;

set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

saveas(fig,[analysisParam.figDir filesep 'CellCount'],'fig')
saveas(fig,[analysisParam.figDir filesep 'CellCount'],'svg')


set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep 'CellCount'],'pdf')
    
end