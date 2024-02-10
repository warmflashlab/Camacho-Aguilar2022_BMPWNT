clear all

load('MCMC_results_TimeCourse_ODE_v1_ExploringMinimum_0','AllSampledParameters','AllSampledmTeSRBMPlevels','AllSampledCosts','parfitnumbers')
load('MCMC_results_TimeCourse_ODE_v1.mat','AllAcceptedParameters','AllAcceptedCosts')


%%
AllParameters = [AllSampledParameters; AllSampledmTeSRBMPlevels];
paramnames = {'gammap','deltap','betap','deltai','Noggin','tau','aSW','nSW','KSW','aWW','nWW','KWW','dW','aWb','nWb','KWb','db','IWP2','WEx','aWPWEx','aS','nCS','KCS','nBS','KBS','aSmS','nSmS','KSmS','dS','aB','abB','nSB','KSB','nCB','KCB','dB','aSmC','nSmC','KSmC',' aC','nSC','KSC','nBC','KBC','aCC','nCC','KCC','dC','KbB','nbB','r_b'};
parfitnumbers = [parfitnumbers(1:27),51];

BestParameter = [AllAcceptedParameters(end).parammodel];
BestParameter = [BestParameter(parfitnumbers(1:end-1));AllAcceptedParameters(end).mTesrBMPlevel];
%%
figure
nbins = 100;

AllParameters = AllParameters./BestParameter;
avgcost = zeros(size(AllParameters,1),nbins-1);
stdcost = zeros(size(AllParameters,1),nbins-1);
for ii =1:size(AllParameters,1)
    ii
    subplot(4,7,ii)
    [vals,idx] = sort(AllParameters(ii,:));
    
    bins = linspace(vals(1),vals(end),nbins);

    
    for jj = 1:(length(bins)-1)
        
        values = (AllParameters(ii,:)>=bins(jj))&(AllParameters(ii,:)<bins(jj+1));
    avgcost(ii,jj) = mean(AllSampledCosts(values));
    stdcost(ii,jj) = std(AllSampledCosts(values));
    
    end
    
%     scatter(AllParameters(ii,idx),AllSampledCosts(idx),'filled')

errorbar(bins(1:end-1),avgcost(ii,:),stdcost(ii,:)/2)
hold on
scatter(BestParameter(ii),AllAcceptedCosts(end),'filled','r')
ylim([0.05,0.3])
title(paramnames{parfitnumbers(ii)})
% scatter(AllParameters(ii,:)
    
    
    
end

%%

figure
CostDifferences = zeros(1,length(parfitnumbers));

for ii = 1:size(AllParameters,1)
    
   CostDifferences(ii) = max( avgcost(ii,10:(end-10)))-min(avgcost(10,5:(end-10)));
    
end
[valc,idxc] = sort(CostDifferences,'descend');

yvalues = paramnames(parfitnumbers(idxc));
h = heatmap('\Delta Cost',yvalues,CostDifferences(idxc)');
colormapPiYG = slanCM('PiYG',200);
colormap(colormapPiYG)
% caxis([-0.05,0.05])
title('Change in cost around minimum')


%%
figure
set(gcf,'Position',[10 10 1200 700])

startbinning = 20;
for ii =1:size(AllParameters,1)
    
    [vals,idx] = sort(AllParameters(ii,:));
    
    bins = linspace(vals(1),vals(end),nbins);

    ii
    subplot(4,7,ii)

errorbar(bins(startbinning:end-(startbinning+1)),avgcost(ii,startbinning:end-startbinning),stdcost(ii,startbinning:end-startbinning)/2)

hold on
[maxi,maxidx] = max( avgcost(ii,startbinning:(end-startbinning)));
[mini,minidx] = min( avgcost(ii,startbinning:(end-startbinning)));
% 
plot([bins(startbinning+maxidx),bins(startbinning+minidx)],[maxi,mini],'k','Linewidth',1)
scatter(bins(startbinning+maxidx),maxi,'filled','k')
scatter(bins(startbinning+minidx),mini,'filled','k')
xticks(round([],4))

ylim([min([min(min(avgcost(:,startbinning:(end-startbinning))-stdcost(:,startbinning:(end-startbinning))/2)),AllAcceptedCosts(end)]),max([max(max(avgcost(:,startbinning:(end-startbinning))+stdcost(:,startbinning:(end-startbinning))/2)),AllAcceptedCosts(end)])])
title(paramnames{parfitnumbers(ii)})
% scatter(AllParameters(ii,:)
    
    
    
end

fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',10)

saveas(fig,['figures/','PaperChangeParameterBinning'],'svg')
saveas(fig,['figures/','PaperChangeParameterBinning'],'fig')
saveas(fig,['figures/','PaperChangeParameterBinning'],'png')


%%

figure
set(gcf,'Position',[10 10 500 900])
startbinning = 20;
CostDifferences = zeros(1,length(parfitnumbers));

for ii = 1:size(AllParameters,1)
    
   CostDifferences(ii) = max( avgcost(ii,startbinning:(end-startbinning)))-min(avgcost(ii,startbinning:(end-startbinning)));
    
end
[valc,idxc] = sort(CostDifferences,'descend');
% idxc = 1:length(CostDifferences);
yvalues = paramnames(parfitnumbers(idxc));
h = heatmap('\Delta Cost',yvalues,CostDifferences(idxc)');
% colormapPiYG = slanCM('PiYG',200);
% colormap(colormapPiYG)
% caxis([-0.05,0.05])
title('Change in cost around minimum')
h.CellLabelFormat = '%.3d';

fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',20)

saveas(fig,['figures/','PaperDifferenceCostBinning_SN'],'svg')
saveas(fig,['figures/','PaperDifferenceCostBinning_SN'],'fig')
saveas(fig,['figures/','PaperDifferenceCostBinning_SN'],'png')
