%% Plot each condition

clear all
setAnalysisParam_this
global analysisParam

%% Compute means and std

load('singlecells.mat')

meanNucIntensity = [];
meanCytIntensity = [];
meanNuc2CytIntensity = [];
stdNucIntensity = [];
stdCytIntensity = [];
stdNuc2CytIntensity = [];
ncellsCleanNuc = [];
ncellsCleanCyt=[];
ncellsCleanNucCyt=[];

for i=1:analysisParam.nCon %i = condition
   
    for j=1:length(singleCells{1}) %j = time
        
        singleCellClean = singleCells{i}{j};
        singleCellCleanNuc = singleCellClean(~isnan(singleCellClean(:,6))&~isinf(singleCellClean(:,6)),:);
        singleCellCleanCyt = singleCellClean(~isnan(singleCellClean(:,7))&~isinf(singleCellClean(:,7)),:);
        singleCellCleanNucCyt = singleCellClean((~isnan(singleCellClean(:,7)))&(~isnan(singleCellClean(:,6)))&(~isinf(singleCellClean(:,6)))&(~isinf(singleCellClean(:,7)))&(singleCellClean(:,7)>0),:);

        ncellsCleanNuc(i,j) = size(singleCellCleanNuc,1);
        ncellsCleanCyt(i,j) = size(singleCellCleanCyt,1);
        ncellsCleanNucCyt(i,j) = size(singleCellCleanNucCyt,1);
        
        meanNucIntensity(i,j) = mean(singleCellCleanNuc(:,6));
        meanCytIntensity(i,j) = mean(singleCellCleanCyt(:,7));
        meanNuc2CytIntensity(i,j) = mean(singleCellCleanNucCyt(:,6)./singleCellCleanNucCyt(:,7));
        stdNucIntensity(i,j) = std(singleCellCleanNuc(:,6));
        stdCytIntensity(i,j) = std(singleCellCleanCyt(:,7));
        stdNuc2CytIntensity(i,j) = std(singleCellCleanNucCyt(:,6)./singleCellCleanNucCyt(:,7));
        
    end
      
end

%%



%% Plot change in number of cells in time

colors = distinguishable_colors(analysisParam.nCon);

for i=1:analysisParam.nCon
    hold on
%    errorbar(meanNucIntensity(i,:),stdNucIntensity(i,:)/2,'LineWidth',2,'Color',colors(i,:))
    plot(meanNucIntensity(i,:),'LineWidth',2,'Color',colors(i,:))
end

legend(analysisParam.conNames,'Location','eastoutside');
title('Nuclear SMAD4 Intensity');
xlabel('Time (hours)')
ylabel('SMAD4 nuc intensity')


%% Plot Nuclear SMAD4 Intensity
colors = distinguishable_colors(analysisParam.nCon);

for i=1:analysisParam.nCon
    hold on
%    errorbar(meanNucIntensity(i,:),stdNucIntensity(i,:)/2,'LineWidth',2,'Color',colors(i,:))
    plot(meanNucIntensity(i,:),'LineWidth',2,'Color',colors(i,:))
end

legend(analysisParam.conNames,'Location','eastoutside');
title('Nuclear SMAD4 Intensity');
xlabel('Time (hours)')
ylabel('SMAD4 nuc intensity')

%%
colors = distinguishable_colors(analysisParam.nCon);

figure('Position',[100 100 1200 1000])


plotX = (0:(length(singleCells{i})-1))*analysisParam.nMinutesPerFrame./60-analysisParam.tLigandAdded;

for i=1:analysisParam.nCon
    hold on
%     errorbar(meanNucIntensity(i,:),stdNucIntensity(i,:))
    plot(plotX,meanNuc2CytIntensity(i,:),'LineWidth',2,'Color',colors(i,:))
end

lgd=legend(analysisParam.conNames,'Location','northeast');
title(lgd,'Conditions','Interpreter','latex')
% title('');
set(gca, 'LineWidth', 1);
fs = 14;
set(gca,'FontSize', fs)
set(gca,'FontWeight', 'bold')
set(gca,'TickLabelInterpreter','latex')
xlabel('\textbf{Time (hours)}','Interpreter','latex')
ylabel('\textbf{SMAD4 nuc:cyto}','Interpreter','latex')

xlim([min(plotX),max(plotX)])
ylim([0.5,1.3])

% print('Nuc2CytoSmad4_Exp8','-depsc')

%%

%% plotting detected cells

figure
hold on
% format time

%mkdir(analysisParam.figDir);
% get ratios
colors = distinguishable_colors(analysisParam.nCon);
filterHigh = 65000;
for iCon = 1:analysisParam.nCon;
    for iTime = find(~cellfun('isempty', singleCells{iCon}))
        R = singleCells{iCon}{iTime}(:,6)./singleCells{iCon}{iTime}(:,5);
        
    nuc2nucMeans(iCon,iTime) = meannonan(R(R<filterHigh)); % find means of ratios less than filterHigh
    nuc2nucStd(iCon,iTime) = stdnonan(R(R<filterHigh)); % 
    nCells(iCon,iTime) = size(R(R<filterHigh),1);
    end
end

preLigand = find(plotX(:)<0);

for iCon = 1:analysisParam.nCon;
plot(plotX(1:size(nuc2nucMeans,2)),nCells(iCon,:),'Color',colors(iCon,:));
end
%legend(analysisParam.conNames,'Location','eastoutside');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel('# of cells');
x = plotX(1:size(nuc2nucMeans,2));
xMin = x(1);
xMax = x(length(x));

analysisParam.xMin = x(1);
analysisParam.xMax = x(length(x));
xlim([xMin xMax]);
title('detected cells');


