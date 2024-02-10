function plotCellClassificationFixedSingleTimePoint(blackbackground,plotlegend) 

AnalysisParamScript_CellClassification
global analysisParam

load([analysisParam.data_direc_OUT filesep 'singleCellsClassified.mat'])

if blackbackground
    lineandtextcolor = 'w';
    bgcolor = 'k';
    colornameplot = 'Black';
    BlackColor = [1,1,1];
    
else
    
    lineandtextcolor = 'k';
    bgcolor = 'w';
    colornameplot = 'White';
    BlackColor = [0,0,0];
    
end


%% Plot bar

figure('Position',[0 0 1200 900]);
% BlackColor = [0,0,0];
RedColor = [207,20,43]/255;
YellowColor = [254,221,0]/255;
CyanColor = [0 163 224]/255;
OrangeColor = (RedColor+YellowColor)/2;
GreenColor = (CyanColor+YellowColor)/2;
PurpleColor = (RedColor+CyanColor)/2;
GrayColor = [200 200 200]/255;

MatrixColors = [BlackColor;RedColor;OrangeColor; YellowColor;GreenColor;CyanColor;PurpleColor;GrayColor];



x=categorical(analysisParam.conNamesPlot);
x = reordercats(x,analysisParam.conNamesPlot);
H = bar(x,PropCellspercondition,'stacked');



 
if plotlegend
[~, hobj, ~, ~] =legend(analysisParam.ClassificationLabels,'Location','eastoutside','FontSize',18,'FontName','Myriad Pro','LineWidth',2,'TextColor',lineandtextcolor,'Color',bgcolor,'EdgeColor',lineandtextcolor);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',2,'Color',lineandtextcolor);
end


title('Classification of cells by marker expression','Color',lineandtextcolor);
ylabel('% of cells','Color',lineandtextcolor);
ylim([0,100])

ht = findobj(hobj,'type','text');
set(ht,'FontSize',18,'FontName','Myriad Pro','FontWeight','bold','Color',lineandtextcolor);


set(gca,'Color',bgcolor)
set(gca,'XColor',lineandtextcolor)
set(gca,'YColor',lineandtextcolor)



fig = gcf;
fig.Color = bgcolor;
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

for ii = 1:analysisParam.nCon
    H(ii).FaceColor = 'flat';
    H(ii).CData = MatrixColors(ii,:);
    H(ii).LineWidth = 1;
    H(ii).EdgeColor = bgcolor;%lineandtextcolor;
end

saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-BarPlotCellClassification'],'fig')
saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-BarPlotCellClassification'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-BarPlotCellClassification'],'pdf')
    
PropCellsperconditionTableNormalization
    