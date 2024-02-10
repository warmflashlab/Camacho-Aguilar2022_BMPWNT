function [] = allPeaks2AreaPlots(allPeaks,plotX)
global analysisParam;
%% plot median cell area and sigma
clear y;
clear yMeans;
ii = 1;
for iCon = 1:8
    for iPos = 1:8
        
%errorbar(plotX,cellfun(@(x) mean(x(:,3)),allPeaks{iCon,iPos}),cellfun(@(x) std(x(:,3)),allPeaks{iCon,iPos}),'LineWidth',0.1)
y(:,iPos) = cellfun(@(x) median(x(:,3)),allPeaks{iCon,iPos});
%plot(plotX,cellfun(@(x) median(x(:,3)),allPeaks{iCon,iPos}))

%ylim([0 650]);
% if ii == 1
% ax = axT;
% else
%     ax = [ax,axT];
% end
% ii = ii+1;
    end
    
    
    yMeans(iCon,:) = mean(y');
    %% for plotting by position, uncomment below through linkaxes:
 %figure;  hold on;       
%     ax(iCon) = subplot(ceil( analysisParam.nCon./4),4,iCon); hold on;
%     plot(plotX,y);
%     plot(plotX,mean(y'));
%     title(analysisParam.conNames(iCon) );
%     if iCon == 1 || iCon == 5
%         ylabel('Median cell area');
%     end
end
% linkaxes(ax,'xy');
%subtitle('Median cell area');
%% convert area from pixels to um2


yMeans = yMeans';
yMeans = yMeans.*.617;

%yMeans = medfilt1(yMeans,6);


%% plot means together
%%

figure;
plot(plotX(2:end),yMeans(2:end,:));
%plot(plotX,yMeans);
legend(analysisParam.conNames,'Location','best');
ylabel('Median cell area (micrometers squared)');
xlabel('time');
savefig('figures/cellArea.fig');
end

