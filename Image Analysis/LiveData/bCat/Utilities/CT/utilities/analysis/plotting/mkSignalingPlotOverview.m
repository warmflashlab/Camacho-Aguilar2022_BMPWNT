function mkSignalingPlotOverview(singleCells,plotX,plotError)
% call this script to generate most used plots.
setAnalysisParam_this;
addpath(genpath(cd),'-begin');

global analysisParam;
%%
hold on; 
set(gcf,'Position',[1922 421 1078 854])
subplot(2,2,1); hold on;
plotCountsV2(singleCells,plotX);
subplot(2,2,2); hold on;
singleCells2PlotChannelV2(singleCells,plotX,6,65000); %gfp
subplot(2,2,4); hold on;
singleCells2PlotChannelV2(singleCells,plotX,5,65000); %rfp
subplot(2,2,3);
plotGFP2RFPv2(singleCells,plotX);
l1 = legend(analysisParam.conNames,'Orientation','Horizontal');
p1 = get(l1,'Position');
p2 = [.015 .960 p1(3) p1(4)];
set(l1,'Position',p2);
savefig([analysisParam.figDir filesep 'overView.fig']);




