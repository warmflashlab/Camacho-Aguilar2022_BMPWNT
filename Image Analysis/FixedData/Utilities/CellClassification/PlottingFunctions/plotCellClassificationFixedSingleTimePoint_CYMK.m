function plotCellClassificationFixedSingleTimePoint_CYMK(blackbackground,plotlegend) 

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

figure('Position',[0 0 1200 200]);
% BlackColor = [0,0,0];
RedColor = [185,82,159]/255;
YellowColor = [248,235,48]/255;
CyanColor = [68 192 198]/255;
OrangeColor = (RedColor+YellowColor)/2;
GreenColor = (CyanColor+YellowColor)/2;
PurpleColor = (RedColor+CyanColor)/2;
GrayColor = [200 200 200]/255;

MatrixColors = [BlackColor;RedColor;OrangeColor; YellowColor;GreenColor;CyanColor;PurpleColor;GrayColor];


% x=categorical({'a0','P5.p1','P6.p1','a1','P5.p2','P6.p2','a2','P5.p3','P6.p3','a3','P5.p4','P6.p4','a4','P5.p5','P6.p5','a5','P5.p6','P6.p6'});
% x = reordercats(x,{'a0','P5.p1','P6.p1','a1','P5.p2','P6.p2','a2','P5.p3','P6.p3','a3','P5.p4','P6.p4','a4','P5.p5','P6.p5','a5','P5.p6','P6.p6'});
% H = bar(x,DataToPlot,'stacked');
% 
% xticklabels({'','P5.p','P6.p','','P5.p','P6.p','','P5.p','P6.p','','P5.p','P6.p','','P5.p','P6.p','','P5.p','P6.p'});

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

saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-BarPlotCellClassification-CYM'],'fig')
saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-BarPlotCellClassification-CYM'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-BarPlotCellClassification-CYM'],'pdf')
    
PropCellsperconditionTableNormalization
    