
function DA_BarPlotsData_FixedData_ConditionsSelection_Exp77(ConditionsSelection,titleplottosave,varargin)

global analysisParam;

if ( length(varargin) == 1 )
    varargin = varargin{:};
end

blackBG = 0;
stdmean = 1;
angleticks = 0;
uniformlimits = 1;


Title=[titleplottosave];


channelnums = analysisParam.MapChannels.ChannelsCoordMatrix{ConditionsSelection(1,1),ConditionsSelection(2,1)};


while ~isempty(varargin)
    switch lower(varargin{1})  
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

    otherwise
        error(['Unexpected option: ' varargin{1}])
    end
      varargin(1:2) = [];
end

analysisParam.figDir = ['figures'];
mkdir(analysisParam.figDir)


%%

    load(['AllDataExperiment_77.mat'],'AllDataExperiment','limitsbars')

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
    
figure();
set(gcf,'Position',[100 100 700 500])

% colourclusters = {colorconvertorRGB([236,28,36]),colorconvertorRGB([249,236,49]),colorconvertorRGB([64,192,198])};
% colourclusters = {'g','r','b'};

if nChan<4
colourclusters = [colorconvertorRGB([64,192,198]);colorconvertorRGB([185,82,159]);colorconvertorRGB([249,236,49])];
colourclusters = colourclusters(ordercolors,:);

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
meanData
stdData
    barplotfc=bar((1:nCon)-1,meanData,0.8,'FaceColor',colourclusters(channelnum,:),'EdgeColor',colorfont);
    errorbar((1:nCon)-1,meanData,stdData/2,'.','Color',colorfont)
    
    
    ylabel(analysisParam.MapChannels.DifferentChannelsPresent{channelnums(channelnum)},'Color',colorfont);

    xticks((1:nCon)-1)
    
%    colourclusters = [187,187,187;170,68,153;153,153,51;136,34,85;68,170,153;204,102,119;136,204,238;51,34,136]/255;;
%   colourclusters =[187,187,187;170,68,153;136,34,85;204,102,119;221,204,119;17,119,51;136,204,238;51,34,136]/255;
% loadcolorschemes
% global colorschemes
% colors = colorschemes.Burd;
% colourclusters = colors([1 4 3 2 11 8 9 10],:); 
colourclusters = [49,77,161;121,195,237;238,230,50;240,78,73]/255;
    
% 11,2,10,3,9,4,8,1],:);
barplotfc.FaceColor = 'Flat'; 
for ii = 1:condnum
    
    barplotfc.CData(ii,:) = colourclusters(ii,:);
end
    
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
    set(gca,'FontName','Arial')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',colorfont)
    set(gca,'YColor',colorfont)  
    
end

box on

fig = gcf;
fig.Color = colorbg;
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
titleplottosave
saveas(fig,[analysisParam.figDir filesep 'DA_BoxPlots-',colorbgplotname,'-AllGenes-DAPINorm-', titleplottosave],'svg')
saveas(fig,[analysisParam.figDir filesep 'DA_BoxPlots-',colorbgplotname,'-AllGenes-DAPINorm-', titleplottosave],'fig')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,[analysisParam.figDir filesep 'DA_BoxPlots-',colorbgplotname,'-AllGenes-DAPINorm-', titleplottosave, '.pdf'],'pdf');
disp('end')
% save([analysisParam.figDir filesep 'DA_BoxPlots-',colorbgplotname,'-AllGenes-DAPINorm-', titleplottosave, '-DATA'])


