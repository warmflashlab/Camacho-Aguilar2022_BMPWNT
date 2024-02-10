
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),MeanDataPlot(1,:))

MedFilter = medfilt1(MeanDataPlot(1,:),13);

hold on

plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),MedFilter)

%%

plot(analysisParam.plotX(1:size(nuc2nucMeans,2)-1),(MeanDataPlot(1,2:end)-MeanDataPlot(1,1:(end-1)))./(analysisParam.plotX(2:size(nuc2nucMeans,2))-analysisParam.plotX(1:size(nuc2nucMeans,2)-1)))
hold on
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)-1),(MedFilter(2:end)-MedFilter(1:end-1))./(analysisParam.plotX(2:size(nuc2nucMeans,2))-analysisParam.plotX(1:size(nuc2nucMeans,2)-1)))

%%
colors = distinguishable_colors(analysisParam.nCon,{'w','k'});
iConorder = [2,3,4,8,1,6,5,7];

figure;
set(gcf,'Position',[10 10 1500 600])

subplot(1,2,1)

for iConaux = 1:analysisParam.nCon
    iCon = iConorder(iConaux);
    
    MedFilter = medfilt1(MeanDataPlot(iCon,:),5);
    hold on
        errorbar(analysisParam.plotX(1:size(nuc2nucMeans,2)),MeanDataPlot(iCon,:),ErrorDataPlot(iCon,:),'LineWidth',2,'Color',colors(iConaux,:));

%     plot(analysisParam.plotX(1:size(nuc2nucMeans,2)-1),(MedFilter(2:end)-MedFilter(1:end-1))./(analysisParam.plotX(2:size(nuc2nucMeans,2))-analysisParam.plotX(1:size(nuc2nucMeans,2)-1)),'LineWidth',2,'Color',colors(iCon,:));
%     plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),MedFilter,'LineWidth',2,'Color',colors(iCon,:));

end
xlim([analysisParam.plotX(1),analysisParam.plotX(end)])
title('SOX2 dynamics')
ylabel([analysisParam.yMolecule ':Pretreatment:Control'],'FontSize',18,'FontName','Arial','FontWeight','bold','Color','w');
xlabel('hours after BMP added','FontSize',18,'FontName','Arial','FontWeight','bold','Color','w');
set(gca,'Color','k')
set(gca,'XColor','w')
set(gca,'YColor','w')

subplot(1,2,2)

for iConaux = 1:analysisParam.nCon
        iCon = iConorder(iConaux);

    MedFilter = medfilt1(MeanDataPlot(iCon,:),5);

    hold on
    DerivativeMedFilter = (MedFilter(2:end)-MedFilter(1:end-1))./(analysisParam.plotX(2:size(nuc2nucMeans,2))-analysisParam.plotX(1:size(nuc2nucMeans,2)-1));

    MedFilterDerivative = medfilt1(DerivativeMedFilter,10);
    
        plot(analysisParam.plotX(1:size(nuc2nucMeans,2)-1),MedFilterDerivative,'LineWidth',2,'Color',colors(iConaux,:));

%     plot(analysisParam.plotX(1:size(nuc2nucMeans,2)-1),(MedFilter(2:end)-MedFilter(1:end-1))./(analysisParam.plotX(2:size(nuc2nucMeans,2))-analysisParam.plotX(1:size(nuc2nucMeans,2)-1)),'LineWidth',2,'Color',colors(iCon,:));
%     plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),MedFilter,'LineWidth',2,'Color',colors(iCon,:));

end
xlim([analysisParam.plotX(1),analysisParam.plotX(end)])
% title('SOX2 dynamics')
ylabel(['med filter SOX2 slope'],'FontSize',18,'FontName','Arial','FontWeight','bold','Color','w');
xlabel('hours after BMP added','FontSize',18,'FontName','Arial','FontWeight','bold','Color','w');
set(gca,'Color','k')
set(gca,'XColor','w')
set(gca,'YColor','w')


fig = gcf;
fig.Color = 'k';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

saveas(fig,[analysisParam.figDir filesep 'Black-SOX2Derivative-GFP2RFP2Pre2Control-NoNuclearMarkerNorm'],'fig')
saveas(fig,[analysisParam.figDir filesep 'Black-SOX2Derivative-GFP2RFP2Pre2Control-NoNuclearMarkerNorm'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep 'Black-SOX2Derivative-GFP2RFP2Pre2Control-NoNuclearMarkerNorm'],'pdf')
    
    

%%

figure;
set(gcf,'Position',[10 10 800 600])


for iConaux = 1:analysisParam.nCon
        iCon = iConorder(iConaux);

    MedFilter = medfilt1(MeanDataPlot(iCon,:),5);

    hold on
    DerivativeMedFilter = (MedFilter(2:end)-MedFilter(1:end-1))./(analysisParam.plotX(2:size(nuc2nucMeans,2))-analysisParam.plotX(1:size(nuc2nucMeans,2)-1));

    MedFilterDerivative = medfilt1(DerivativeMedFilter,10);
    
        plot(analysisParam.plotX(1:size(nuc2nucMeans,2)-1),-MedFilterDerivative,'LineWidth',2,'Color',colors(iConaux,:));

%     plot(analysisParam.plotX(1:size(nuc2nucMeans,2)-1),(MedFilter(2:end)-MedFilter(1:end-1))./(analysisParam.plotX(2:size(nuc2nucMeans,2))-analysisParam.plotX(1:size(nuc2nucMeans,2)-1)),'LineWidth',2,'Color',colors(iCon,:));
%     plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),MedFilter,'LineWidth',2,'Color',colors(iCon,:));

end
xlim([analysisParam.plotX(1),analysisParam.plotX(end)])
% title('SOX2 dynamics')
ylabel(['flipped med filter SOX2 slope'],'FontSize',18,'FontName','Arial','FontWeight','bold','Color','w');
xlabel('hours after BMP added','FontSize',18,'FontName','Arial','FontWeight','bold','Color','w');
set(gca,'Color','k')
set(gca,'XColor','w')
set(gca,'YColor','w')


fig = gcf;
fig.Color = 'k';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

saveas(fig,[analysisParam.figDir filesep 'Black-MinusSOX2Derivative-GFP2RFP2Pre2Control-NoNuclearMarkerNorm'],'fig')
saveas(fig,[analysisParam.figDir filesep 'Black-MinusSOX2Derivative-GFP2RFP2Pre2Control-NoNuclearMarkerNorm'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep 'Black-MinusSOX2Derivative-GFP2RFP2Pre2Control-NoNuclearMarkerNorm'],'pdf')
    



