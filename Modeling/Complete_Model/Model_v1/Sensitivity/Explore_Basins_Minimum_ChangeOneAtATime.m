clear all

load('MCMC_results_TimeCourse_ODE_v1_ExploringOneParameterAtATime','allprops','parameters','AllSampledCosts','parfitnumbers')
load('MCMC_results_TimeCourse_ODE_v1.mat','AllAcceptedParameters','AllAcceptedCosts')


%%
parfitnumbers=parfitnumbers(1:27);
paramaux = [parameters.parammodel(parfitnumbers),parameters.mTesrBMPlevel];

AllParameters = paramaux'*allprops;
% AllParameters = [AllSampledParameters; AllSampledmTeSRBMPlevels];
paramnames = {'gammap','deltap','betap','deltai','Noggin','tau','aSW','nSW','KSW','aWW','nWW','KWW','dW','aWb','nWb','KWb','db','IWP2','WEx','aWPWEx','aS','nCS','KCS','nBS','KBS','aSmS','nSmS','KSmS','dS','aB','abB','nSB','KSB','nCB','KCB','dB','aSmC','nSmC','KSmC',' aC','nSC','KSC','nBC','KBC','aCC','nCC','KCC','dC','KbB','nbB','r_b'};
parfitnumbers = [parfitnumbers(1:27),51];

StartingParameter = [AllAcceptedParameters(1).parammodel];
StartingParameter = [StartingParameter(parfitnumbers(1:end-1));AllAcceptedParameters(1).mTesrBMPlevel];

BestParameter = [AllAcceptedParameters(end).parammodel];
BestParameter = [BestParameter(parfitnumbers(1:end-1));AllAcceptedParameters(end).mTesrBMPlevel];
%%
figure
set(gcf,'Position',[10 10 1000 700])
% nbins = 100;
% 
% avgcost = zeros(size(AllParameters,1),length(bins)-1);
% stdcost = zeros(size(AllParameters,1),length(bins)-1);
for ii =1:size(AllParameters,1)
    ii
    subplot(4,7,ii)
%     [vals,idx] = sort(AllParameters(ii,:));
    
%     bins = linspace(vals(1),vals(end),nbins);

    
%     for jj = 1:(length(bins)-1)
%         
%         values = (AllParameters(ii,:)>=bins(jj))&(AllParameters(ii,:)<bins(jj+1));
%     avgcost(ii,jj) = mean(AllSampledCosts(values));
%     stdcost(ii,jj) = std(AllSampledCosts(values));
%     
%     end
    
    scatter(AllParameters(ii,:)./BestParameter(ii),AllSampledCosts(ii,:),'filled')

% errorbar(bins(1:end-1),avgcost(ii,:),stdcost(ii,:)/2)
hold on
scatter(BestParameter(ii)./BestParameter(ii),AllAcceptedCosts(end),'filled','r')
% scatter(StartingParameter(ii),AllAcceptedCosts(end),'filled','k')
ylim([0,6.5])
title(paramnames{parfitnumbers(ii)})
% scatter(AllParameters(ii,:)
    box on
    grid on
    
    
end


fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',20)

saveas(fig,['figures/','PaperChangeParameterOneAtATime'],'svg')
saveas(fig,['figures/','PaperChangeParameterOneAtATime'],'fig')
saveas(fig,['figures/','PaperChangeParameterOneAtATime'],'png')

%%
for ii =1:size(AllParameters,1)
    ii
    subplot(4,7,ii)

errorbar(bins(1:end-1),avgcost(ii,:),stdcost(ii,:)/2)

hold on
scatter(BestParameter(ii),AllAcceptedCosts(end),'filled','r')

ylim([min([min(min(avgcost-stdcost/2)),AllAcceptedCosts(end)]),max([max(max(avgcost+stdcost/2)),AllAcceptedCosts(end)])])
title(paramnames{parfitnumbers(ii)})
% scatter(AllParameters(ii,:)
    
    
    
end


%%

figure
CostDifferences = zeros(1,length(parfitnumbers));

for ii = 1:size(AllParameters,1)
    
   CostDifferences(ii) = max( avgcost(ii,5:(end-10)))-min(avgcost(ii,5:(end-10)));
    
end
[valc,idxc] = sort(CostDifferences,'descend');

yvalues = paramnames(parfitnumbers(idxc));
h = heatmap('\Delta Cost',yvalues,CostDifferences(idxc)');
colormapPiYG = slanCM('PiYG',200);
colormap(colormapPiYG)
% caxis([-0.05,0.05])
title('Change in cost around minimum')
