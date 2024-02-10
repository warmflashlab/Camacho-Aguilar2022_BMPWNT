function [] = singleCells2AreaPlots(singleCells,plotX)
global analysisParam;
%% plot median cell area and sigma
clear y;
clear yMeans;
clear ySTD;
clear ySE;
ii = 1;
for iCon = 1:8
   
y(iCon,:) = cellfun(@(x) mean(x(:,3)),singleCells{iCon});
ySTD(iCon,:) = cellfun(@(x) std(x(:,3)),singleCells{iCon});
ySE(iCon,:) = cellfun(@(x) std(x(:,3))./sqrt(size(x,1)),singleCells{iCon});
end
% linkaxes(ax,'xy');
%subtitle('Median cell area');
%% convert area from pixels to um2


y = y';
ySTD = ySTD';
ySE = ySE';
y = y.*.617;
ySTD = ySTD.*.617;
ySE = ySE.*.617;
%yMeans = medfilt1(yMeans,6);


%% plot means together
%%

figure;

plot(plotX,y);
errorbar(repmat(plotX,analysisParam.nCon,1)',y,ySE);
%plot(plotX,yMeans);
legend(analysisParam.conNames,'Location','best');
ylabel('Median cell area (micrometers squared)');
xlabel('time');
savefig('figures/cellArea.fig');
end

