clear;
setAnalysisParam_this;
mkdir('membrane figures');
addpath(genpath(cd),'-begin');
global analysisParam;
colors = distinguishable_colors(analysisParam.nCon);

allPeaks = getAllPeaks;
singleCells = allPeaks2singleCells(allPeaks);
norm2preTreat = 0;
allMembranes = getAllMembranesV2(norm2preTreat); %mxn matrix, m is position, n is condition

for iCon = 1:analysisParam.nCon;
    %for each position
    for iPos = 1:analysisParam.nPosPerCon;
            if iPos == 1;
            allMembranes2{iCon}=allMembranes{iCon,iPos};
            else
                allMembranes2{iCon}=[allMembranes2{iCon};allMembranes{iCon,iPos}];
            end
        end
end




% allMembranes2 = cellArray2OneDim(allMembranes');
for ii = 1:1:analysisParam.nCon
    meanMembranes(:,ii) = meannonan(allMembranes2{ii});
    stdMembranes(:,ii) =stdnonan(allMembranes2{ii});
end
figure; hold on;
for ii = 1:1:analysisParam.nCon
plot(analysisParam.plotX,meanMembranes(:,ii),'color',colors(ii,:));
end
legend(analysisParam.conNames,'Location','Best')
title('Membrane (mean pixel intensities)');
savefig('membrane figures/pixel means.fig');
norm2preTreat = 1;
allMembranes = getAllMembranesV2(norm2preTreat); %mxn matrix, m is position, n is condition
allMembranes2 = cellArray2OneDim(allMembranes');
for ii = 1:1:analysisParam.nCon
    meanMembranes(:,ii) = meannonan(allMembranes2{ii});
    stdMembranes(:,ii) =stdnonan(allMembranes2{ii});
end
figure; hold on;
for ii = 1:1:analysisParam.nCon
plot(analysisParam.plotX,meanMembranes(:,ii),'color',colors(ii,:));
end
legend(analysisParam.conNames,'Location','Best')
title('Membrane:preLigand');
%savefig('membrane figures/mem2preTreat.fig');

for ii = 1:1:analysisParam.nCon
    meanMembranes(:,ii) = meannonan(allMembranes2{ii});
    stdMembranes(:,ii) =stdnonan(allMembranes2{ii});
end
figure; hold on;
for ii = 1:1:analysisParam.nCon
plot(analysisParam.plotX,meanMembranes(:,ii)./meanMembranes(:,analysisParam.controlCondition),'color',colors(ii,:));
end
legend(analysisParam.conNames,'Location','Best')
title('Membrane:preLigand:control');
%savefig('membrane figures/mem2preTreat2control.fig');






