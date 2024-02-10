function HeatScatter3D_FixedData(blackBG)


AnalysisParamScript

global analysisParam;

load(analysisParam.dataSegmentation)

%%

DataPlot = [];

for conditionnum=2:analysisParam.nCon
        
        DataPlot = [DataPlot;AllDataMatrixDAPInorm{analysisParam.ConditionOrder(conditionnum)}(:,3+analysisParam.ChannelOrder3D)];

end

if analysisParam.ChannelsLimsFile
    load(analysisParam.ChannelsLimsFile);
    
    maxlim = maxlim(3+analysisParam.ChannelOrder);
    minlim = minlim(3+analysisParam.ChannelOrder);
else
minlim = quantile(DataPlot,0.0005);
maxlim = quantile(DataPlot,0.9995);
end

%%

figure;
set(gcf,'Position',[10 10 1400 800])

x=parula;

if blackBG
    
    
    for conditionnum = 1:analysisParam.nCon

        
        if conditionnum<5
            subplot(2,4,conditionnum)
        else
            subplot(2,4,13-conditionnum)
        end

        DataPlot = AllDataMatrixDAPInorm{analysisParam.ConditionOrder(conditionnum)}(:,3+analysisParam.ChannelOrder3D);

        ndimensions = size(DataPlot,2);

        pointsize=5;

        % figure('Position',[100 100 1700 1700])
        disp('Plotting')

        if ndimensions == 3

            scatter3(DataPlot(:,1),DataPlot(:,2),DataPlot(:,3),pointsize,assignnumberneighbours3(DataPlot(:,1),DataPlot(:,2),DataPlot(:,3),analysisParam.distance),'filled','MarkerEdgeAlpha',1)
            
            colormap(x(50:end,:))
            
            xlabel(analysisParam.Channels{analysisParam.ChannelOrder3D(1)},'Color','w');
            ylabel(analysisParam.Channels{analysisParam.ChannelOrder3D(2)},'Color','w');
            zlabel(analysisParam.Channels{analysisParam.ChannelOrder3D(3)},'Color','w');
            xlim([minlim(1),maxlim(1)])
            ylim([minlim(2),maxlim(2)])
            zlim([minlim(3),maxlim(3)])
            
            set(gca, 'LineWidth', 2);
            set(gca,'FontWeight', 'bold')
            set(gca,'FontName','Myriad Pro')
            set(gca,'FontSize',18)
            set(gca,'Color','k')
            
            set(gca,'XColor','w')
            set(gca,'YColor','w') 
            set(gca,'ZColor','w')
            
%             if conditionnum==5
%                 colorbar
%             end

        else

            scatter(DataPlot(:,1),DataPlot(:,2),pointsize,assignnumberneighbours2(DataPlot(:,1),DataPlot(:,2),analysisParam.distance),'MarkerEdgeAlpha',1)
            xlabel(analysisParam.Channels{analysisParam.ChannelOrder3D(1)},'Color','w');
            ylabel(analysisParam.Channels{analysisParam.ChannelOrder3D(2)},'Color','w');
            xlim([minlim(1),maxlim(1)])
            ylim([minlim(2),maxlim(2)])
            
            set(gca, 'LineWidth', 2);
            set(gca,'FontWeight', 'bold')
            set(gca,'FontName','Myriad Pro')
            set(gca,'FontSize',18)
            set(gca,'Color','k')
            
            set(gca,'XColor','w')
            set(gca,'YColor','w') 


        end
        
        title(analysisParam.conNamesPlot(analysisParam.ConditionOrder(conditionnum)),'FontWeight', 'bold','FontName','Myriad Pro','FontSize',18,'Color','w')

    end
    
    fig = gcf;
    fig.Color = 'k';
    fig.InvertHardcopy = 'off';
    set(findall(fig,'-property','FontSize'),'FontSize',18)
    set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
    
    saveas(fig,[analysisParam.figDir filesep 'HeatScatter-Black-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4)],'svg')
    saveas(fig,[analysisParam.figDir filesep 'HeatScatter-Black-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4)],'fig')

    set(fig,'Units','Inches');
    pos = get(fig,'Position');
    set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(fig,'filename','-dpdf','-r0')

    saveas(fig,[analysisParam.figDir filesep 'HeatScatter-Black-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4) '.pdf'],'pdf');

    
    
    
else
    
        for conditionnum = 1:analysisParam.nCon

        subplot(2,4,conditionnum)

        DataPlot = AllDataMatrixDAPInorm{analysisParam.ConditionOrder(conditionnum)}(:,3+analysisParam.ChannelOrder3D);

        ndimensions = size(DataPlot,2);

        pointsize=5;

        % figure('Position',[100 100 1700 1700])
        disp('Plotting')

        if ndimensions == 3

            scatter3(DataPlot(:,1),DataPlot(:,2),DataPlot(:,3),pointsize,assignnumberneighbours3(DataPlot(:,1),DataPlot(:,2),DataPlot(:,3),analysisParam.distance),'filled','MarkerEdgeAlpha',1)
            xlabel(analysisParam.Channels{analysisParam.ChannelOrder3D(1)});
            ylabel(analysisParam.Channels{analysisParam.ChannelOrder3D(2)});
            zlabel(analysisParam.Channels{analysisParam.ChannelOrder3D(3)});
            xlim([minlim(1),maxlim(1)])
            ylim([minlim(2),maxlim(2)])
            zlim([minlim(3),maxlim(3)])
            
            set(gca, 'LineWidth', 2);
            set(gca,'FontWeight', 'bold')
            set(gca,'FontName','Myriad Pro')
            set(gca,'FontSize',18)
            

        else

            scatter(DataPlot(:,1),DataPlot(:,2),pointsize,assignnumberneighbours2(DataPlot(:,1),DataPlot(:,2),analysisParam.distance),'MarkerEdgeAlpha',1)
            xlabel(analysisParam.Channels{analysisParam.ChannelOrder(1)});
            ylabel(analysisParam.Channels{analysisParam.ChannelOrder(2)});
            xlim([minlim(1),maxlim(1)])
            ylim([minlim(2),maxlim(2)])
            
            set(gca, 'LineWidth', 2);
            set(gca,'FontWeight', 'bold')
            set(gca,'FontName','Myriad Pro')
            set(gca,'FontSize',18)



        end

        end
        
        fig = gcf;

    set(findall(fig,'-property','FontSize'),'FontSize',18)
    set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
    
    saveas(fig,[analysisParam.figDir filesep 'HeatScatter-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4)],'svg')
    saveas(fig,[analysisParam.figDir filesep 'HeatScatter-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4)],'fig')

    set(fig,'Units','Inches');
    pos = get(fig,'Position');
    set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(fig,'filename','-dpdf','-r0')

    saveas(fig,[analysisParam.figDir filesep 'HeatScatter-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4) '.pdf'],'pdf');


    
end
