function ScatterCellClassificationFixedSingleTimePointv2(samplenumber,blackbackground) 


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

%%

minlim = minvalues;
maxlim = maxvalues;

%% Plot Scatter


RedColor = [207,20,43]/255;
YellowColor = [254,221,0]/255;
CyanColor = [0 163 224]/255;
OrangeColor = (RedColor+YellowColor)/2;
GreenColor = (CyanColor+YellowColor)/2;
PurpleColor = (RedColor+CyanColor)/2;
GrayColor = [200 200 200]/255;
MatrixColors = [BlackColor;RedColor;OrangeColor; YellowColor;GreenColor;CyanColor;PurpleColor;GrayColor];

figure;
set(gcf,'Position',[10 10 1400 800])
% set(gcf,'Position',[10 10 1600 400])


    for conditionnum = 1:analysisParam.nCon

%         subplot(1,4,conditionnum)
        if conditionnum<5
            subplot(2,4,conditionnum)
        else
            subplot(2,4,13-conditionnum)
        end

        DataPlot = singleCellsClassified{analysisParam.ConditionOrder(conditionnum)}(:,7+analysisParam.ChannelOrder3D);

        ndimensions = size(DataPlot,2);

        pointsize=10;

        % figure('Position',[100 100 1700 1700])
        disp('Plotting')

        if ndimensions == 3

            scatter3(DataPlot(:,1),DataPlot(:,2),DataPlot(:,3),pointsize,MatrixColors(singleCellsClassified{analysisParam.ConditionOrder(conditionnum)}(:,end),:),'filled','MarkerEdgeAlpha',1,'MarkerFaceAlpha',1)

            xlabel(analysisParam.Channels{analysisParam.ChannelOrder3D(1)},'Color',lineandtextcolor);
            ylabel(analysisParam.Channels{analysisParam.ChannelOrder3D(2)},'Color',lineandtextcolor);
            zlabel(analysisParam.Channels{analysisParam.ChannelOrder3D(3)},'Color',lineandtextcolor);
            xlim([minlim(1),maxlim(1)])
            ylim([minlim(2),maxlim(2)])
            zlim([minlim(3),maxlim(3)])
            
            set(gca, 'LineWidth', 2);
            set(gca,'FontWeight', 'bold')
            set(gca,'FontName','Arial')
            set(gca,'FontSize',18)
            set(gca,'Color',bgcolor)
            
            set(gca,'XColor',lineandtextcolor)
            set(gca,'YColor',lineandtextcolor) 
            set(gca,'ZColor',lineandtextcolor)
            
%             if conditionnum==5
%                 colorbar
%             end

        else

            scatter(DataPlot(:,1),DataPlot(:,2),pointsize,MatrixColors(singleCellsClassified{analysisParam.ConditionOrder(conditionnum)}(:,end),:),'MarkerEdgeAlpha',1)
            xlabel(analysisParam.Channels{analysisParam.ChannelOrder3D(1)},'Color',lineandtextcolor);
            ylabel(analysisParam.Channels{analysisParam.ChannelOrder3D(2)},'Color',lineandtextcolor);
            xlim([minlim(1),maxlim(1)])
            ylim([minlim(2),maxlim(2)])
            
            set(gca, 'LineWidth', 2);
            set(gca,'FontWeight', 'bold')
            set(gca,'FontName','Arial')
            set(gca,'FontSize',18)
            set(gca,'Color',bgcolor)
            
            set(gca,'XColor',lineandtextcolor)
            set(gca,'YColor',lineandtextcolor) 


        end
        
        title(analysisParam.conNamesPlot(analysisParam.ConditionOrder(conditionnum)),'FontWeight', 'bold','FontName','Arial','FontSize',18,'Color',lineandtextcolor)

    end
array2table(PropCellspercondition(analysisParam.ConditionOrder,:),'VariableNames',CellClassifParam.ClassificationLabels,'RowNames',analysisParam.conNamesPlot(analysisParam.ConditionOrder))
    
    fig = gcf;
    fig.Color = bgcolor;
    fig.InvertHardcopy = 'off';
    set(findall(fig,'-property','FontSize'),'FontSize',18)
    set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
    
    
    saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-Class-HS'],'fig')
    saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-Class-HS'],'svg')

    set(fig,'Units','Inches');
    pos = get(fig,'Position');
    set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(fig,'filename','-dpdf','-r0')

    saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-Class-HS'],'pdf')

    

    