function ScatterCellClassificationFixedSingleTimePointv2_CMYK_1Condition(samplenumber,conditionnum,blackbackground,bigplot) 


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


RedColor = [185,82,159]/255;
YellowColor = [248,235,48]/255;
CyanColor = [68 192 198]/255;
OrangeColor = (RedColor+YellowColor)/2;
GreenColor = (CyanColor+YellowColor)/2;
PurpleColor = (RedColor+CyanColor)/2;
GrayColor = [200 200 200]/255;
MatrixColors = [BlackColor;RedColor;OrangeColor; YellowColor;GreenColor;CyanColor;PurpleColor;GrayColor];

figure;
if bigplot
set(gcf,'Position',[00 00 240 200])
else
    set(gcf,'Position',[00 00 120 100])

end

% set(gcf,'Position',[10 10 1600 400])



%     for conditionnum = 1:analysisParam.nCon

%         subplot(1,4,conditionnum)
%         if conditionnum<5
%             subplot(2,4,conditionnum)
%         else
%             subplot(2,4,13-conditionnum)
%         end

        DataPlot = singleCellsClassified{analysisParam.ConditionOrder(conditionnum)}(:,6+analysisParam.ChannelOrder3D);

   
        ndimensions = size(DataPlot,2);
        

        if bigplot
        pointsize=15;
        else
            pointsize=2;
        end

        % figure('Position',[100 100 1700 1700])
        disp('Plotting')

        if ndimensions == 3

            scatter3(DataPlot(:,1),DataPlot(:,2),DataPlot(:,3),pointsize,MatrixColors(singleCellsClassified{analysisParam.ConditionOrder(conditionnum)}(:,end),:),'filled','MarkerEdgeAlpha',0.5,'MarkerFaceAlpha',0.5)
            
            xlabel(analysisParam.Channels{analysisParam.ChannelOrder3D(1)},'Color',lineandtextcolor);
            ylabel(analysisParam.Channels{analysisParam.ChannelOrder3D(2)},'Color',lineandtextcolor);
            zlabel(analysisParam.Channels{analysisParam.ChannelOrder3D(3)},'Color',lineandtextcolor);
            xlim([minlim(1),maxlim(1)])
            ylim([minlim(2),maxlim(2)])
            zlim([minlim(3),maxlim(3)])
            
            xticks(round(linspace(minlim(1),maxlim(1),4),1))
            yticks(round(linspace(minlim(2),maxlim(2),4),1))
            zticks(round(linspace(minlim(3),maxlim(3),4),1))
            
            set(gca, 'LineWidth', 2);
            set(gca,'FontWeight', 'bold')
            set(gca,'FontName','Arial')
            set(gca,'FontSize',6)
            set(gca,'Color',bgcolor)
            
            set(gca,'XColor',lineandtextcolor)
            set(gca,'YColor',lineandtextcolor) 
            set(gca,'ZColor',lineandtextcolor)
            
%             v = [1 1 1];
%             [caz,cel] = view(v)
            
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
            set(gca,'FontName','Myriad Pro')
            set(gca,'FontSize',6)
            set(gca,'Color',bgcolor)
            
            set(gca,'XColor',lineandtextcolor)
            set(gca,'YColor',lineandtextcolor) 


        end

        
        fig = gcf;
        fig.Color = bgcolor;
        fig.InvertHardcopy = 'off';
        if bigplot
            set(findall(fig,'-property','FontSize'),'FontSize',10)
%         set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
        else
           
        set(findall(fig,'-property','FontSize'),'FontSize',8)
%         set(findall(gcf,'-property','LineWidth'),'LineWidth',1)
        end


        if bigplot
        saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-Class-HS-CMYK-BIG-Condition' num2str(conditionnum)],'fig')
        saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-Class-HS-CMYK-BIG-Condition' num2str(conditionnum)],'svg')

        set(fig,'Units','Inches');
        pos = get(fig,'Position');
        set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
        print(fig,'filename','-dpdf','-r0')

        saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-Class-HS-CMYK-BIG-Condition' num2str(conditionnum)],'pdf')

        else
            saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-Class-HS-CMYK-Condition' num2str(conditionnum)],'fig')
        saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-Class-HS-CMYK-Condition' num2str(conditionnum)],'svg')

        set(fig,'Units','Inches');
        pos = get(fig,'Position');
        set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
        print(fig,'filename','-dpdf','-r0')

        saveas(fig,[analysisParam.figDir filesep colornameplot '-' analysisParam.ExperimentName '-Class-HS-CMYK-Condition' num2str(conditionnum)],'pdf')

        end
%         title(analysisParam.conNamesPlot(analysisParam.ConditionOrder(conditionnum)),'FontWeight', 'bold','FontName','Arial','FontSize',18,'Color',lineandtextcolor)

%     end
array2table(PropCellspercondition(analysisParam.ConditionOrder,:),'VariableNames',CellClassifParam.ClassificationLabels,'RowNames',analysisParam.conNamesPlot(analysisParam.ConditionOrder))
    
    
    

    