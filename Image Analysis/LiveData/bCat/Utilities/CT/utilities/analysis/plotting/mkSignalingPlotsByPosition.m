function mkSignalingPlotsByPosition(allPeaks,plotX)
global analysisParam;




%% plot counts
figure; ii=1; hold on;

for iCon = 1:8
    for iPos = 1:8
        axT = subplot(8,8,ii);  hold on;
plot(plotX,cellfun('size',allPeaks{iCon,iPos},1))
%ylim([0 550]);

title(['con ' int2str(iCon) ' pos ' int2str(iPos)]);
if ii == 1
ax = axT;
else
    ax = [ax,axT];
end
ii = ii+1;
    end
end
linkaxes(ax,'xy');
subtitle('#cells');




%% plot GFP2RFP
figure;  hold on;
ii = 1;
for iCon = 1:8
    for iPos = 1:8
        axT = subplot(8,8,ii);  hold on;
plot(plotX,cellfun(@getGFP2RFP,allPeaks{iCon,iPos}))
%ylim([0.2 2.5]);
title(['con ' int2str(iCon) ' pos ' int2str(iPos)]);
if ii == 1
ax = axT;
else
    ax = [ax,axT];
end
ii = ii+1;
    end
end
linkaxes(ax,'xy');
subtitle('GFP2RFP');
%% plot median cell area and sigma
figure;  hold on;
ii = 1;
for iCon = 1:8
    for iPos = 1:8
        axT = subplot(8,8,ii); hold on;
%errorbar(plotX,cellfun(@(x) mean(x(:,3)),allPeaks{iCon,iPos}),cellfun(@(x) std(x(:,3)),allPeaks{iCon,iPos}),'LineWidth',0.1)
plot(plotX,cellfun(@(x) median(x(:,3)),allPeaks{iCon,iPos}))
title(['con ' int2str(iCon) ' pos ' int2str(iPos)]);
%ylim([0 650]);
if ii == 1
ax = axT;
else
    ax = [ax,axT];
end
ii = ii+1;
    end
end
linkaxes(ax,'xy');
subtitle('Median cell area');

%% plot each condition by single cells
singleCells = allPeaks2singleCells(allPeaks);

figure;  hold on;
ii = 1;
for iCon = 1:8
    
        axT = subplot(2,4,ii); hold on;
plot(plotX,cellfun('size',singleCells{iCon},1))
if ii == 1
ax = axT;
else
    ax = [ax,axT];
end
ii = ii+1;
    
end
subtitle('total cells per con');
linkaxes(ax,'xy');
figure;  hold on;
ii = 1;
for iCon = 1:8
    
        axT = subplot(2,4,ii); hold on;
plot(plotX,cellfun(@getGFP2RFP,singleCells{iCon}))
%ylim([0.5 2.5]);
if ii == 1
ax = axT;
else
    ax = [ax,axT];
end
ii = ii+1;
    %title(['condition ' int2str(iCon)]);
end
subtitle('mean gfp2rfp per condition');
linkaxes(ax,'xy');
figure;  hold on;
ii = 1;
for iCon = 1:8
    
        axT = subplot(2,4,ii); hold on;
plot(plotX,cellfun(@(x) median(x(:,3)),singleCells{iCon}))
%ylim([0 650]);
if ii == 1
ax = axT;
else
    ax = [ax,axT];
end
ii = ii+1;
   %title(['condition ' int2str(iCon)]); 
end
subtitle('median cell area of each condition');
linkaxes(ax,'xy');
end



