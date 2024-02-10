
function ViolinPlotsData_FixedData(blackBG)


AnalysisParamScript

global analysisParam;

load(analysisParam.dataSegmentation)


%% Save data at times in timesaux for different conditions

% times = [1,5.5/0.25,5.5/0.25+20/0.25,5.5/0.25+30/0.25,5.5/0.25+40/0.25,5.5/0.25+48/0.25];
analysisParam.nCon=analysisParam.nCon{1};
times = 1:analysisParam.nCon;

AllDataConditions = {};


for condition = 1:analysisParam.nCon
 
        AllDataConditions{condition} = AllDataMatrixDAPInorm{analysisParam.ConditionOrder(condition)}(:,3+analysisParam.ChannelOrder);
        
end

Conditionsname = analysisParam.conNamesPlot{1};

%%

maxquantile = 0.9;
minquantile = 0.1;
if analysisParam.ChannelsLimsFile
    load(analysisParam.ChannelsLimsFile);
    
    maxlim = maxlim(3+analysisParam.ChannelOrder);
    minlim = minlim(3+analysisParam.ChannelOrder);
else

    maxlim = quantile(AllDataConditions{1},maxquantile);
    minlim = quantile(AllDataConditions{1},minquantile);

    for conditionnum=2:analysisParam.nCon

            DataPlot = AllDataConditions{conditionnum};

            maxlim = max([maxlim;quantile(DataPlot,maxquantile)]);
            minlim = min([minlim;quantile(DataPlot,minquantile)]);

    end
end

%% Violin plot


if blackBG
    
    figure;
set(gcf,'Position',[10 10 1200 1000])
colourclusters = {colorconvertorRGB([236,28,36]),colorconvertorRGB([249,236,49]),colorconvertorRGB([64,192,198])};
colors = distinguishable_colors(analysisParam.nCon,{'w','k'});

alinearrelation = 10;
blinearrelation = 5;

for channelnum = 1:analysisParam.nChannels

subplot(analysisParam.nChannels,1,channelnum)



celln = 0;
xticksnum = [];
daystickslabels = {};
plotshandle = [];
legendhandle = {};

    
    for daynum = 1:analysisParam.nCon

        %Set the interval in which the violin will spread
        daytickmin = alinearrelation*(times(daynum)-times(1));
        daytickmax = alinearrelation*(times(daynum)-times(1))+blinearrelation;
        daytick = (2*alinearrelation*(times(daynum)-times(1))+blinearrelation)/2;

        % Access the data:
%         DataPlot = ((AllDataConditions{conditionnum}{daynum}(:,2)./AllDataConditions{conditionnum}{daynum}(:,1))/normalizer(conditionnum))./(control(times(daynum)));
        DataPlot = AllDataConditions{daynum}(:,channelnum);
        
%         disp('Computing pdf.....')
        % Obtain the distribution of the data
        [pdf,y] = ksdensity(DataPlot);
        
        disp('Computed!.....')
        
        % Obtain higher accuracy so that the violin looks nicer:
        ymax = max(DataPlot);%max(y);
        ymin = min(DataPlot);%min(y);
        points = linspace(ymin,ymax,1000);
        
        disp('Evaluating pdf.....')
        %Repeat ksdensity
        [pdf,y] = ksdensity(DataPlot,points);
        disp('Evaluated!.....')
        
        %Now, for each point in y, we need to find a change of coordinates
        %between [pdfmin,pdfmax] and [daytickmin,daytickmax]
        
        pdfmax = max(pdf);
        pdfmin = min(pdf);
        
        Aright = (daytick-daytickmax)/(pdfmin-pdfmax);
        bright = daytickmax - Aright*pdfmax;
        
        Aleft = (daytick-daytickmin)/(pdfmin-pdfmax);
        bleft = daytickmin - Aleft*pdfmax;
        
        pdfright = Aright*pdf+bright;
        pdfleft = Aleft*pdf+bleft;
        


%         for ypoint = 1:length(y)
%             
% %             plot([pdfleft(ypoint),pdfright(ypoint)],[y(ypoint),y(ypoint)],'Color',colourclusters{1}{genenum},'LineWidth',1.5)
%             plot([pdfleft(ypoint),pdfright(ypoint)],[y(ypoint),y(ypoint)],'Color','w','LineWidth',1.5)
%             hold on
%             
%         end
        
        disp('Plotting....')
        

        plot(pdfright,y,'Color',colourclusters{channelnum},'LineWidth',2);
        hold on
        plot(pdfleft,y,'Color',colourclusters{channelnum},'LineWidth',2)

%         plot(pdfright,y,'Color',colors(conditionnum,:),'LineWidth',2);
%         hold on
%         plot(pdfleft,y,'Color',colors(conditionnum,:),'LineWidth',2)
        
%         scatter(daytick, quantile(DataPlot,0.05),10,'filled','<','MarkerEdgeColor','k','MarkerFaceColor','w','LineWidth',0.1)
%         scatter(daytick, quantile(DataPlot,0.95),10,'filled','<','MarkerEdgeColor','k','MarkerFaceColor','w','LineWidth',0.1)
%         plot([daytickmin,daytickmax], mean(DataPlot)*ones(1,2),'Color',colourclusters{channelnum},'LineWidth',1.5)
%         plot([daytickmin,daytickmax], median(DataPlot)*ones(1,2),'b','LineWidth',1.5)
%         scatter(daytick, mean(DataPlot),10,'filled','MarkerEdgeColor',colourclusters{channelnum},'MarkerFaceColor',colourclusters{channelnum},'LineWidth',0.1)
                errorbar(daytick, mean(DataPlot),stdnonan(DataPlot)/sqrt(length(DataPlot)),'LineWidth',2,'Color',colourclusters{channelnum});

        
        
        % Set appearance of plot:
        xticksnum = [xticksnum, daytick];
        daystickslabels{daynum} = Conditionsname{daynum};
        
        
%             legendhandle{daynum} = ['(',num2str(ids(daynum)),') ',mutregimes{daynum},' D',num2str(days{daynum}),' ', CHIRcond, ' ',LGKcond];
%         if daynum >1
%            plot([daytickaux,daytick], [meanaux,mean(DataPlot)],'Color',colors(conditionnum,:),'LineWidth',1.5) 
%         end
        
        meanaux = mean(DataPlot);
        daytickaux = daytick;
        
        
        
    end
    
    
%         xlabel('Hours post treatment')
        ylabel(analysisParam.Channels{analysisParam.ChannelOrder(channelnum)},'Color','w');

    
%     title([genesnames{1}{genenum},' dynamics'],'fontsize',10)

    ylim(1.2*[minlim(channelnum),maxlim(channelnum)])

    xlim([0,max(xticksnum)+blinearrelation])
    [xticksordered,indicesxticks] = sort(xticksnum);
    xticks(unique(xticksordered))
    if channelnum<analysisParam.nChannels
        xticklabels((cell(1,analysisParam.nCon)));
    else
    xticklabels((daystickslabels(analysisParam.ConditionOrder)));
    
    end
%     title(Conditionsname{conditionnum})
if channelnum==1
    title(analysisParam.Title,'Color','w')
end
xtickangle(analysisParam.angleticks)
    
    set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color','k')
    set(gca,'Color','k')
    set(gca,'XColor','w')
    set(gca,'YColor','w')  
    
end



fig = gcf;
fig.Color = 'k';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

saveas(fig,[analysisParam.figDir filesep 'ViolinPlots-Black-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4)],'svg')
saveas(fig,[analysisParam.figDir filesep 'ViolinPlots-Black-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4)],'fig')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep 'ViolinPlots-Black-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4) '.pdf'],'pdf');




    
    
else
figure;
set(gcf,'Position',[10 10 1200 800])
colourclusters = {colorconvertorRGB([236,28,36]),colorconvertorRGB([249,236,49]),colorconvertorRGB([64,192,198])};
colors = distinguishable_colors(analysisParam.nCon,{'w','k'});

alinearrelation = 10;
blinearrelation = 5;

for channelnum = 1:analysisParam.nChannels

subplot(analysisParam.nChannels,1,channelnum)
if channelnum==1
    title(analysisParam.Title)
end


celln = 0;
xticksnum = [];
daystickslabels = {};
plotshandle = [];
legendhandle = {};

    
    for daynum = 1:analysisParam.nCon

        %Set the interval in which the violin will spread
        daytickmin = alinearrelation*(times(daynum)-times(1));
        daytickmax = alinearrelation*(times(daynum)-times(1))+blinearrelation;
        daytick = (2*alinearrelation*(times(daynum)-times(1))+blinearrelation)/2;

        % Access the data:
%         DataPlot = ((AllDataConditions{conditionnum}{daynum}(:,2)./AllDataConditions{conditionnum}{daynum}(:,1))/normalizer(conditionnum))./(control(times(daynum)));
        DataPlot = AllDataConditions{daynum}(:,channelnum);
        
%         disp('Computing pdf.....')
        % Obtain the distribution of the data
        [pdf,y] = ksdensity(DataPlot);
        
        disp('Computed!.....')
        
        % Obtain higher accuracy so that the violin looks nicer:
        ymax = max(DataPlot);%max(y);
        ymin = min(DataPlot);%min(y);
        points = linspace(ymin,ymax,1000);
        
        disp('Evaluating pdf.....')
        %Repeat ksdensity
        [pdf,y] = ksdensity(DataPlot,points);
        disp('Evaluated!.....')
        
        %Now, for each point in y, we need to find a change of coordinates
        %between [pdfmin,pdfmax] and [daytickmin,daytickmax]
        
        pdfmax = max(pdf);
        pdfmin = min(pdf);
        
        Aright = (daytick-daytickmax)/(pdfmin-pdfmax);
        bright = daytickmax - Aright*pdfmax;
        
        Aleft = (daytick-daytickmin)/(pdfmin-pdfmax);
        bleft = daytickmin - Aleft*pdfmax;
        
        pdfright = Aright*pdf+bright;
        pdfleft = Aleft*pdf+bleft;
        


%         for ypoint = 1:length(y)
%             
% %             plot([pdfleft(ypoint),pdfright(ypoint)],[y(ypoint),y(ypoint)],'Color',colourclusters{1}{genenum},'LineWidth',1.5)
%             plot([pdfleft(ypoint),pdfright(ypoint)],[y(ypoint),y(ypoint)],'Color','w','LineWidth',1.5)
%             hold on
%             
%         end
        
        disp('Plotting....')
        

               plot(pdfright,y,'Color',colourclusters{channelnum},'LineWidth',2);
        hold on
        plot(pdfleft,y,'Color',colourclusters{channelnum},'LineWidth',2)

%         plot(pdfright,y,'Color',colors(conditionnum,:),'LineWidth',2);
%         hold on
%         plot(pdfleft,y,'Color',colors(conditionnum,:),'LineWidth',2)
        
%         scatter(daytick, quantile(DataPlot,0.05),10,'filled','<','MarkerEdgeColor','k','MarkerFaceColor','w','LineWidth',0.1)
%         scatter(daytick, quantile(DataPlot,0.95),10,'filled','<','MarkerEdgeColor','k','MarkerFaceColor','w','LineWidth',0.1)
%         plot([daytickmin,daytickmax], mean(DataPlot)*ones(1,2),'Color',colourclusters{channelnum},'LineWidth',1.5)
%         plot([daytickmin,daytickmax], median(DataPlot)*ones(1,2),'b','LineWidth',1.5)
%         scatter(daytick, mean(DataPlot),10,'filled','MarkerEdgeColor',colourclusters{channelnum},'MarkerFaceColor',colourclusters{channelnum},'LineWidth',0.1)
                errorbar(daytick, mean(DataPlot),stdnonan(DataPlot)/sqrt(length(DataPlot)),'LineWidth',2,'Color',colourclusters{channelnum});


        % Set appearance of plot:
        xticksnum = [xticksnum, daytick];
        daystickslabels{daynum} = Conditionsname{daynum};
        
        
        
%             legendhandle{daynum} = ['(',num2str(ids(daynum)),') ',mutregimes{daynum},' D',num2str(days{daynum}),' ', CHIRcond, ' ',LGKcond];
%         if daynum >1
%            plot([daytickaux,daytick], [meanaux,mean(DataPlot)],'Color',colors(conditionnum,:),'LineWidth',1.5) 
%         end
        
        meanaux = mean(DataPlot);
        daytickaux = daytick;
        
        
        
    end
    
    
%         xlabel('Hours post treatment')
        ylabel(analysisParam.Channels{analysisParam.ChannelOrder(channelnum)})

    
%     title([genesnames{1}{genenum},' dynamics'],'fontsize',10)
    set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    ylim(1.2*[minlim(channelnum),maxlim(channelnum)])

        xlim([0,max(xticksnum)+blinearrelation])
    [xticksordered,indicesxticks] = sort(xticksnum);
    xticks(unique(xticksordered))
    if channelnum<analysisParam.nChannels
        xticklabels((cell(1,analysisParam.nCon)));
    else
    xticklabels((daystickslabels(analysisParam.ConditionOrder)));
    
    end
%     title(Conditionsname{conditionnum})

xtickangle(analysisParam.angleticks)
       
    
end

fig = gcf;
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

saveas(fig,[analysisParam.figDir filesep 'ViolinPlots-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4)],'svg')
saveas(fig,[analysisParam.figDir filesep 'ViolinPlots-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4)],'fig')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep 'ViolinPlots-AllGenes-DAPINorm-' analysisParam.dataSegmentation(1:end-4) '.pdf'],'pdf');

end

