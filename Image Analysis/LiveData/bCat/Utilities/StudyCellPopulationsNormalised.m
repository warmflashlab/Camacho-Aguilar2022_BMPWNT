function StudyCellPopulationsNormalised(singleCells,plotError,plotlegend)
figure;
set(gcf,'Position',[10 10 900 600])


setUserParamForECA_ESI017_20x1024
setAnalysisParam_this;
global analysisParam;
global userParam;

analysisParam.figDir = 'figuresV2';

%%
controlCondition = analysisParam.controlCondition;
colors = distinguishable_colors(analysisParam.nCon);
filterHigh = 65000;
maxR = 0;
AllR = [];
AllRNuc = [];
AllRGene = [];
nuclim = analysisParam.nucminlevel; %There are two peaks on the 
for iCon = 1:analysisParam.nCon;
    for iTime = find(~cellfun('isempty', singleCells{iCon}))
        nuccond = find(singleCells{iCon}{iTime}(:,5)>nuclim);
        R = singleCells{iCon}{iTime}(nuccond,6)./singleCells{iCon}{iTime}(nuccond,5);
        maxRaux = max(R);
        
        if maxRaux>maxR
            maxR=maxRaux;
        end
        AllR = [AllR;R];
        AllRNuc = [AllRNuc;singleCells{iCon}{iTime}(nuccond,5)];
        AllRGene = [AllRGene;singleCells{iCon}{iTime}(nuccond,6)];
        
    nuc2nucMeans(iCon,iTime) = meannonan(R); % find means of ratios where the nuclear marker was higher than nuclim
    nuc2nucStd(iCon,iTime) = stdnonan(R); % 
    nCells(iCon,iTime) = size(R,1);
    end
end

%%
preLigand = find(analysisParam.plotX(:)<0);
size(nuc2nucMeans,2)
x = analysisParam.plotX(1:size(nuc2nucMeans,2));
xMin = x(1);
xMax = x(length(x));

for iCon = 1:analysisParam.nCon;
normalizer = mean(nuc2nucMeans(iCon,preLigand));
yy = std(nuc2nucMeans(iCon,preLigand));
x = nuc2nucMeans(iCon,:);
nuc2nucMeans(iCon,:) = x./normalizer;
xx=nuc2nucStd(iCon,:);
nuc2nucStd(iCon,:) = QuotientError(x,normalizer,xx,yy);
end
% plot 
hold on;

control = nuc2nucMeans(controlCondition,:);
control = medfilt1(control,13);
controlSigma = nuc2nucStd(controlCondition,:);

for iCon = 1:analysisParam.nCon;
    y = nuc2nucMeans(iCon,:)./control;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),y,'Color',colors(iCon,:));
end

if plotError == 1
    for iCon = 1:analysisParam.nCon;
        y = nuc2nucMeans(iCon,:)./control;
        e = QuotientError(nuc2nucMeans(iCon,:),control,nuc2nucStd(iCon,:),controlSigma)./sqrt(nCells(iCon,:));        
        s = errorbar(analysisParam.plotX(1:size(nuc2nucMeans,2)),y,e,'LineWidth',2,'Color',colors(iCon,:));
    end
end


if plotlegend
[~, hobj, ~, ~] =legend(analysisParam.conNames,'Location','eastoutside','FontSize',14,'FontName','Arial');
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',1.5);
end
% ht = findobj(hobj,'type','text')
% set(ht,'FontSize',10);
xlabel(['hours after ' analysisParam.ligandName ' added'],'FontSize',12,'FontName','Arial','FontWeight','bold');
%,'Interpreter','latex','FontWeight','bold');
ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc],'FontSize',12,'FontName','Arial','FontWeight','bold');
% title('GFP:RFP:PreTreatment:Control');
xlim([xMin xMax]);

ax = gca; 
ax.XTickMode = 'manual';
ax.YTickMode = 'manual';
ax.ZTickMode = 'manual';
ax.XLimMode = 'manual';
ax.YLimMode = 'manual';
ax.ZLimMode = 'manual';

fig = gcf;

saveas(fig,[analysisParam.figDir filesep 'GFP2RFP2Pre2Control-CleanNucLevel-legendOFF'],'svg')

%%

