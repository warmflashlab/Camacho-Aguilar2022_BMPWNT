function plotCellClassificationFixedSingleTimePointv2_CMYK(samplenumber,blackbackground,plotlegend) 

AnalysisParamScript_v2
global analysisParam

CellClassifParamScript
global CellClassifParam

load([CellClassifParam.data_direc_OUT filesep 'singleCellsClassified.mat'])

singleCellsClassified = singleCellsClassified{samplenumber};
PropCellspercondition = PropCellspercondition{samplenumber};
analysisParam = analysisParam(samplenumber);

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

figure('Position',[0 0 1000 200]);
% BlackColor = [0,0,0];
RedColor = [185,82,159]/255;
YellowColor = [248,235,48]/255;
CyanColor = [68 192 198]/255;
OrangeColor = (RedColor+YellowColor)/2;
GreenColor = (CyanColor+YellowColor)/2;
PurpleColor = (RedColor+CyanColor)/2;
GrayColor = [200 200 200]/255;

MatrixColors = [BlackColor;RedColor;OrangeColor; YellowColor;GreenColor;CyanColor;PurpleColor;GrayColor];


x=categorical(analysisParam.conNamesPlot);
x = reordercats(x,analysisParam.conNamesPlot(analysisParam.ConditionOrder));
H = bar(x,PropCellspercondition,0.4,'stacked');

xticklabels([])
 

 
if plotlegend
[~, hobj, ~, ~] =legend(CellClassifParam.ClassificationLabels,'Location','eastoutside','FontSize',18,'FontName','Arial','LineWidth',2,'TextColor',lineandtextcolor,'Color',bgcolor,'EdgeColor',lineandtextcolor);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',2,'Color',lineandtextcolor);
end


title('Classification of cells by marker expression','Color',lineandtextcolor);
ylabel('% of cells','Color',lineandtextcolor);
ylim([0,100])

% ht = findobj(hobj,'type','text');
% set(ht,'FontSize',18,'FontName','Arial','FontWeight','bold','Color',lineandtextcolor);


set(gca,'Color',bgcolor)
set(gca,'XColor',lineandtextcolor)
set(gca,'YColor',lineandtextcolor)



fig = gcf;
fig.Color = bgcolor;
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
set(findall(fig,'-property','FontName'),'FontName','Arial')

for ii = 1:CellClassifParam.nLabels
    H(ii).FaceColor = 'flat';
    H(ii).CData = MatrixColors(ii,:);
    H(ii).LineWidth = 1;
    H(ii).EdgeColor = [100 100 100]/255;% bgcolor;%lineandtextcolor;
end

saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-BarPlotCellClassification-CYM'],'fig')
saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-BarPlotCellClassification-CYM'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-BarPlotCellClassification-CYM'],'pdf')
    
array2table(PropCellspercondition(analysisParam.ConditionOrder,:),'VariableNames',CellClassifParam.ClassificationLabels,'RowNames',analysisParam.conNamesPlot(analysisParam.ConditionOrder))
    