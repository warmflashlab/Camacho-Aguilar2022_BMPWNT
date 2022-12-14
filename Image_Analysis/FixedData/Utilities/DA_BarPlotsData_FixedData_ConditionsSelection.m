
function DA_BarPlotsData_FixedData_ConditionsSelection(ConditionsSelection,titleplottosave,varargin)


global analysisParam;

if ( length(varargin) == 1 )
    varargin = varargin{:};
end

raworclean = 0;
blackBG = 0;
stdmean = 1;
angleticks = 0;
uniformlimits = 1;
sepbarparam = 0.8;
windowdims = [10 10 1200 1000];

raworcleantitle = {'RAW','CLEAN'};

Title=[titleplottosave,' ', raworcleantitle{raworclean+1}];


channelnums = analysisParam.MapChannels.ChannelsCoordMatrix{ConditionsSelection(1,1),ConditionsSelection(2,1)};


while ~isempty(varargin)
    switch lower(varargin{1})
          case {'raworclean'}
              raworclean = varargin{2};   
          case {'blackbg'}
              blackBG = varargin{2};  
          case {'channels'}
              channelnums = varargin{2}; 
              ordercolors = 1:length(channelnums);
          case {'stdmean'}
              stdmean = varargin{2}; 
          case {'angleticks'}
              angleticks = varargin{2};  
          case {'title'}
              Title = [varargin{2}];  
          case {'uniformlimits'}
              uniformlimits = [varargin{2}]; 
          case {'ordercolors'}
              ordercolors = [varargin{2}]; 
              
        case {'sepbarparam'}
            sepbarparam = [varargin{2}];
            case {'windowdims'}
            windowdims = [varargin{2}];

    otherwise
        error(['Unexpected option: ' varargin{1}])
    end
      varargin(1:2) = [];
end

analysisParam.figDir = [analysisParam.pathnamesave filesep 'figures'];
mkdir(analysisParam.figDir)


%%

if raworclean
    load([analysisParam.savingpathforData filesep 'AllDataExperimentClean.mat'])
    
else
    load([analysisParam.savingpathforData filesep 'AllDataExperiment.mat'])
    
end

if blackBG
    
    colorbg = 'k';
    colorfont = 'w';
    colorbgplotname = 'BLACK';
    
else
    
    colorbg = 'w';
    colorfont = 'k';
    colorbgplotname = 'WHITE';
end
% analysisParam.NamesConditions=analysisParam.NamesConditions{1}
%% Check conditions contain the same channels
nCon = size(ConditionsSelection,2);
nChan = length(channelnums);

FindChannelsinConditions = zeros(nCon,nChan);

for ii = 1:nChan
    
    channelinterest = channelnums(ii);
    
    for jj = 1:nCon
        
        auxvar = find(channelinterest == analysisParam.MapChannels.ChannelsCoordMatrix{ConditionsSelection(1,jj),ConditionsSelection(2,jj)});
        
        if isempty(auxvar)
            error(['DA_BarPlotsData_FixedData_ConditionsSelection: Selected condition ',num2str(jj),' does not contain data for channel ',analysisParam.MapChannels.DifferentChannelsPresent{channelinterest}]);
        
        else
            FindChannelsinConditions(jj,ii) = auxvar;
            
        end
        
    end
    
end
    
        


%% Bar Plot
    
figure;
set(gcf,'Position',windowdims)

% colourclusters = {colorconvertorRGB([236,28,36]),colorconvertorRGB([249,236,49]),colorconvertorRGB([64,192,198])};
% colourclusters = {'g','r','b'};

if nChan<4
colourclusters = [colorconvertorRGB([64,192,198]);colorconvertorRGB([185,82,159]);colorconvertorRGB([249,236,49])];
% colourclusters = [colorconvertorRGB([185,82,159]);colorconvertorRGB([249,236,49])];
colourclusters = colourclusters(ordercolors,:);
% colourclusters = colourclusters(3,:);

else
    
    colourclusters = distinguishable_colors(nChan,{'w','k'});
    colourclusters = colourclusters(ordercolors,:);
    
end
    

tiledlayout(nChan,1,'TileSpacing','compact')

for channelnum = 1:nChan

nexttile


celln = 0;
xticksnum = [];
daystickslabels = {};
plotshandle = [];
legendhandle = {};
% MatrixToPlot=[];
% grp1=[];
meanData = [];
stdData = [];
    
    for condnum = 1:nCon
        
        if stdmean
            meanDataAux = zeros(1,AllDataExperiment{ConditionsSelection(1,condnum)}{ConditionsSelection(2,condnum)}(end,end));
            
            for posnum = 1:AllDataExperiment{ConditionsSelection(1,condnum)}{ConditionsSelection(2,condnum)}(end,end)
                
                indposnum = find(AllDataExperiment{ConditionsSelection(1,condnum)}{ConditionsSelection(2,condnum)}(:,end)==posnum);
                meanDataAux(posnum) = mean(AllDataExperiment{ConditionsSelection(1,condnum)}{ConditionsSelection(2,condnum)}(indposnum,2+FindChannelsinConditions(condnum,channelnum)));
            end
            
            meanData = [meanData,meannonan(meanDataAux)];
            stdData = [stdData,stdnonan(meanDataAux)/sqrt(AllDataExperiment{ConditionsSelection(1,condnum)}{ConditionsSelection(2,condnum)}(end,end))];
            
        else
                    
            meanData = [meanData,meannonan(AllDataExperiment{ConditionsSelection(1,condnum)}{ConditionsSelection(2,condnum)}(:,2+FindChannelsinConditions(condnum,channelnum)))];
            stdData = [stdData,stdnonan(AllDataExperiment{ConditionsSelection(1,condnum)}{ConditionsSelection(2,condnum)}(:,2+FindChannelsinConditions(condnum,channelnum)))];
            
        end
        

        daystickslabels{condnum} = analysisParam.NamesConditions{ConditionsSelection(1,condnum)}{ConditionsSelection(2,condnum)};
        
  
    end
    
    hold on

    barplotfc = bar(1:nCon,meanData,sepbarparam,'FaceColor',colourclusters(channelnum,:),'EdgeColor',colorfont);
    errorbar(1:nCon,meanData,stdData/2,'.','Color',colorfont)
    
% colourclusters = [49,77,161;121,195,237;240,78,73;238,230,50]/255;
% barplotfc.FaceColor = 'Flat'; 
% for ii = 1:condnum
%     
%     barplotfc.CData(ii,:) = colourclusters(ii,:);
% end
    
    ylabel(analysisParam.MapChannels.DifferentChannelsPresent{channelnums(channelnum)},'Color',colorfont);

    xticks(1:nCon)
    
    if uniformlimits
    if channelnums(channelnum)==1
            ylim([0,limitsbars(2,channelnums(channelnum))])
        else
            ylim([limitsbars(1,channelnums(channelnum)),limitsbars(2,channelnums(channelnum))])
        end
%     ylim([0,limitsbars(2,channelnums(channelnum))])
    end
    
    if channelnum<nChan
        xticklabels((cell(1,nCon)));
    else
        xticklabels((daystickslabels(1:nCon)));    
    end
    
    if channelnum==1
    title(Title,'Color','w')
    end
    
    xtickangle(angleticks)
    
    set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',colorfont)
    set(gca,'YColor',colorfont)  
    box on
    
end



fig = gcf;
fig.Color = colorbg;
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

saveas(fig,[analysisParam.figDir filesep 'DA_BoxPlots-',colorbgplotname,'-AllGenes-DAPINorm-', titleplottosave, '-', raworcleantitle{raworclean+1}],'svg')
saveas(fig,[analysisParam.figDir filesep 'DA_BoxPlots-',colorbgplotname,'-AllGenes-DAPINorm-', titleplottosave, '-', raworcleantitle{raworclean+1}],'fig')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep 'DA_BoxPlots-',colorbgplotname,'-AllGenes-DAPINorm-', titleplottosave, '-', raworcleantitle{raworclean+1}, '.pdf'],'pdf');



