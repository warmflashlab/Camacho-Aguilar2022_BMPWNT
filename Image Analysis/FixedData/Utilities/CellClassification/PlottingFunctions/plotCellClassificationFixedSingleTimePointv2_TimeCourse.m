function plotCellClassificationFixedSingleTimePointv2_TimeCourse(blackbackground,plotlegend) 

CellClassifParamScript
global CellClassifParam






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

set(gcf,'Position',[10 10 1400 800/2]);
% BlackColor = [0,0,0];
RedColor = [207,20,43]/255;
YellowColor = [254,221,0]/255;
CyanColor = [0 163 224]/255;
OrangeColor = (RedColor+YellowColor)/2;
GreenColor = (CyanColor+YellowColor)/2;
PurpleColor = (RedColor+CyanColor)/2;
GrayColor = [200 200 200]/255;

MatrixColors = [BlackColor;RedColor;OrangeColor; YellowColor;GreenColor;CyanColor;PurpleColor;GrayColor];

samplenumberorder =[2,3,4,1]


for samplenumber = 1:4
    
    AnalysisParamScript_v2
global analysisParam

load([CellClassifParam.data_direc_OUT filesep 'singleCellsClassified.mat'])

singleCellsClassified = singleCellsClassified{samplenumber};
PropCellspercondition = PropCellspercondition{samplenumber};

analysisParam = analysisParam(samplenumber);

subplot(1,4,samplenumberorder(samplenumber))

x=categorical(analysisParam.conNamesPlot);
x = reordercats(x,analysisParam.conNamesPlot(analysisParam.ConditionOrder));
H = bar(x,PropCellspercondition,'stacked');



 
if plotlegend
[~, hobj, ~, ~] =legend(CellClassifParam.ClassificationLabels,'Location','eastoutside','FontSize',18,'FontName','Myriad Pro','LineWidth',2,'TextColor',lineandtextcolor,'Color',bgcolor,'EdgeColor',lineandtextcolor);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',2,'Color',lineandtextcolor);

ht = findobj(hobj,'type','text');
set(ht,'FontSize',18,'FontName','Myriad Pro','FontWeight','bold','Color',lineandtextcolor);
end


title(NamesSubexperiments{samplenumber},'Color',lineandtextcolor);
ylabel('% of cells','Color',lineandtextcolor);
ylim([0,100])

xlabel('time after treatment','Color',lineandtextcolor)


set(gca,'Color',bgcolor)
set(gca,'XColor',lineandtextcolor)
set(gca,'YColor',lineandtextcolor)



fig = gcf;
fig.Color = bgcolor;
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

for ii = 1:CellClassifParam.nLabels
    H(ii).FaceColor = 'flat';
    H(ii).CData = MatrixColors(ii,:);
    H(ii).LineWidth = 1;
    H(ii).EdgeColor = bgcolor;%lineandtextcolor;
end

end

saveas(fig,[analysisParam.figDir filesep colornameplot '-' 'AllExp4-BarPlotCellClassification'],'fig')
saveas(fig,[analysisParam.figDir filesep colornameplot '-' 'AllExp4-BarPlotCellClassification'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep colornameplot '-' 'AllExp4-BarPlotCellClassification'],'pdf')
    
array2table(PropCellspercondition(analysisParam.ConditionOrder,:),'VariableNames',CellClassifParam.ClassificationLabels,'RowNames',analysisParam.conNamesPlot(analysisParam.ConditionOrder))
    