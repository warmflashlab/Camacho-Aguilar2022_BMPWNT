function plotCellClassificationFixedSingleTimePointv2_CMYK_Exp77_CHIR15(samplenumber,blackbackground,plotlegend) 

AnalysisParamScript_v2
global analysisParamCellClassification

CellClassifParamScript
global CellClassifParam

load([CellClassifParam.data_direc_OUT filesep 'singleCellsClassified.mat'])

samplestoplot = [1,4,3];
analysisParamCellClassification.ConditionOrder = 1:3;
singleCellsClassified = singleCellsClassified{samplenumber}(samplestoplot);
PropCellspercondition = PropCellspercondition{samplenumber}(samplestoplot,:);
analysisParamCellClassification = analysisParamCellClassification(samplenumber);
FontNameChoice = 'Myriad Pro';
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
GrayColorText = [1 1 1]/255;
MatrixColors = [BlackColor;RedColor;OrangeColor; YellowColor;GreenColor;CyanColor;PurpleColor;GrayColor];
MatrixColorsText = [GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText];


x=categorical(analysisParamCellClassification.conNamesPlot(samplestoplot));
x = reordercats(x,analysisParamCellClassification.conNamesPlot(samplestoplot));
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
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')
heightsofar = zeros(1,size(PropCellspercondition,1));

for ii = 1:CellClassifParam.nLabels
    H(ii).FaceColor = 'flat';
    H(ii).CData = MatrixColors(ii,:);
    H(ii).LineWidth = 1;
    H(ii).EdgeColor = [100 100 100]/255;% bgcolor;%lineandtextcolor;
    
    heightH = H(ii).YData(analysisParamCellClassification.ConditionOrder)
    

    
    for jj=1:size(PropCellspercondition,1)

        if ii==1
            
            if heightH(jj)>11
            
                if size(PropCellspercondition,1)>2
                    if round(heightH(jj),2)==100
                        starttext = 0.85;
                    else
                        starttext = 0.85;
                    end
                    text((jj-1)+starttext,heightH(jj)/2,num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
                else
                    if round(heightH(jj),2)==100
                        starttext = 0.85;
                    else
                        starttext = 0.85;
                    end
                text((jj-1)+starttext,heightH(jj)/2,num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
            
                end
            end
        else
            
            if heightH(jj)>11
            
                if size(PropCellspercondition,1)>2
                    if round(heightH(jj),2)==100
                        starttext = 0.85;
                    else
                        starttext = 0.85;
                    end
            text((jj-1)+starttext,(heightH(jj)/2)+heightsofar(jj),num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
                else
                    if round(heightH(jj),2)==100
                        starttext = 0.85;
                    else
                        starttext = 0.85;
                    end
            text((jj-1)+starttext,(heightH(jj)/2)+heightsofar(jj),num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
            
                end
            end
            
        end
        
        
        
    end
    heightsofar = heightsofar + heightH;
end

saveas(fig,[analysisParamCellClassification.figDir filesep colornameplot '-' analysisParamCellClassification.ExperimentName '-BarPlotCellClassification-CYM-C15'],'fig')
saveas(fig,[analysisParamCellClassification.figDir filesep colornameplot '-' analysisParamCellClassification.ExperimentName '-BarPlotCellClassification-CYM-C15'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParamCellClassification.figDir filesep colornameplot '-' analysisParamCellClassification.ExperimentName '-BarPlotCellClassification-CYM-C15'],'pdf')
    
array2table(PropCellspercondition(analysisParamCellClassification.ConditionOrder,:),'VariableNames',CellClassifParam.ClassificationLabels,'RowNames',analysisParamCellClassification.conNamesPlot(analysisParamCellClassification.ConditionOrder))
    