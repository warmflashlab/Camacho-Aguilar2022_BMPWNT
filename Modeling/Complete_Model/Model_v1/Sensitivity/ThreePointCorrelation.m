clear all

load('MCMC_results_TimeCourse_ODE_v1_ExploringMinimum_0','AllSampledParameters','AllSampledmTeSRBMPlevels','AllSampledCosts','parfitnumbers')

%%
AllParameters = [AllSampledParameters; AllSampledmTeSRBMPlevels];
paramnames = {'gammap','deltap','betap','deltai','Noggin','tau','aSW','nSW','KSW','aWW','nWW','KWW','dW','aWb','nWb','KWb','db','IWP2','WEx','aWPWEx','aS','nCS','KCS','nBS','KBS','aSmS','nSmS','KSmS','dS','aB','abB','nSB','KSB','nCB','KCB','dB','aSmC','nSmC','KSmC',' aC','nSC','KSC','nBC','KBC','aCC','nCC','KCC','dC','KbB','nbB','r_b'};
parfitnumbers = [parfitnumbers,51];

%% Compute three way correlation matrix

ThreePointCor = zeros(size(AllParameters,1),size(AllParameters,1));

Z = AllSampledCosts-mean(AllSampledCosts);

for ii = 1:size(AllParameters,1)
    for jj = 1:size(AllParameters,1)
        
        X = AllParameters(ii,:) - mean(AllParameters(ii,:));
        Y = AllParameters(jj,:) - mean(AllParameters(jj,:));
        
        Denominator = (mean((X.^2).*(Y.^2))*mean((X.^2).*(Z.^2))*mean((Y.^2).*(Z.^2))*mean((X.^2))*mean((Y.^2))*mean((Z.^2)))^(1/6);
        
        ThreePointCor(ii,jj) = mean(X.*Y.*Z)/Denominator;
       
        
    end
    
end

%% Plot three point correlation matrix
figure
set(gcf,'Position',[10 10 800 700])

[val,idxsorted] = sort(diag(ThreePointCor),'descend');
orderidxsorted = [1,5,4,6,7,2,3,8:length(idxsorted)];

cdata = ThreePointCor(idxsorted(orderidxsorted),idxsorted(orderidxsorted));
xvalues = paramnames(parfitnumbers(idxsorted(orderidxsorted)));
yvalues = paramnames(parfitnumbers(idxsorted(orderidxsorted)));
% figure
h = heatmap(yvalues,xvalues,cdata);
colormapPiYG = slanCM('PiYG',200);
colormap(colormapPiYG)
caxis([-0.1,0.1])
title('Three-point correlation: parameter correlations vs cost function')

fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',20)

saveas(fig,['figures/','PaperThreePointCorrelationsParams'],'svg')
saveas(fig,['figures/','PaperThreePointCorrelationsParams'],'fig')
saveas(fig,['figures/','PaperThreePointCorrelationsParams'],'png')

