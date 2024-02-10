function mkSignalingPlots_nCells(singleCells,plotError,nAllCells)
% call this script to generate most used plots.
%setAnalysisParam_this;
addpath(genpath(cd),'-begin');

global analysisParam;
%%
figure; 
set(gcf,'Position',[1922 421 1078 854])
subplot(2,3,1); hold on;
plotCounts(singleCells)%,nAllCells);
subplot(2,3,2); hold on;
singleCells2PlotChannel(singleCells,6,65000);
subplot(2,3,3); hold on;
singleCells2PlotChannel(singleCells,5,65000);
subplot(2,3,4);
plotGFP2RFP(singleCells);
l1 = legend(analysisParam.conNames,'Orientation','Horizontal');
p1 = get(l1,'Position');
p2 = [.015 .960 p1(3) p1(4)];
set(l1,'Position',p2);
savefig([analysisParam.figDir filesep 'overView.fig']);
subplot(2,3,5);
PlotGfp2Rfp2PreTreatment(singleCells,0);
%  yl = ylim;
%  y2 = [yl(1)*1.8 yl(2)*0.85];
%  ylim(y2);

legend('off');
subplot(2,3,6);
PlotGfp2Rfp2PreTreatment2Control_Elena(singleCells,0,1,0);
legend('off');
fig = gcf;

set(findall(fig,'-property','FontSize'),'FontSize',12)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
savefig([analysisParam.figDir filesep 'overView.fig']);
figure;
PlotGfp2Rfp2PreTreatment2Control_Elena(singleCells,plotError,1,1);
% savefig([analysisParam.figDir filesep 'GFP2RFP2Pre2Control.fig']);

%  yl = ylim;
%  y2 = [yl(1)*1.8 yl(2)*0.85];
%  ylim(y2);



