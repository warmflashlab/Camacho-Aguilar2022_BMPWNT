%% This works!!! <<<- (Parameter 3)
clear
load('MCMC_results_TimeCourse_ODE_v1.mat','AllAcceptedParameters','parfitnumbers','Istar')


%%
% figure
paramnames = {'gammap','deltap','betap','deltai','Noggin','tau','aSW','nSW','KSW','aWW','nWW','KWW','dW','aWb','nWb','KWb','db','IWP2','WEx','aWPWEx','aS','nCS','KCS','nBS','KBS','aSmS','nSmS','KSmS','dS','aB','abB','nSB','KSB','nCB','KCB','dB','aSmC','nSmC','KSmC',' aC','nSC','KSC','nBC','KBC','aCC','nCC','KCC','dC','KbB','nbB','r_b'};
parfitnumbers=[parfitnumbers(1:27),51];

AllAcceptedParameterValuesAll = [AllAcceptedParameters(1:end).parammodel;AllAcceptedParameters(1:end).mTesrBMPlevel];
AllAcceptedParameterValuesAll = AllAcceptedParameterValuesAll./mean(AllAcceptedParameterValuesAll')';
AllAcceptedParameterValuesEnd = [AllAcceptedParameters(1844:end).parammodel;AllAcceptedParameters(1844:end).mTesrBMPlevel];
AllAcceptedParameterValuesEnd = AllAcceptedParameterValuesEnd./mean(AllAcceptedParameterValuesEnd')';

varAll = var(AllAcceptedParameterValuesAll(parfitnumbers,:)');
varEnd = 2*std(AllAcceptedParameterValuesEnd(parfitnumbers,:)');

[val,idx] = sort(varEnd,'descend');

figure
set(gcf,'Position',[10 10 2000 500])

bar([varEnd(idx)]')
xticks(1:length(parfitnumbers))
xticklabels(paramnames(parfitnumbers(idx)))
xlabel('Parameters')
ylabel('2\sigma(\theta^i/avg(\theta^i)')

title('2*Std of normalized accepted parameters between \theta_3 and \theta_4')



fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',20)

saveas(fig,['figures/','PaperSTD_1844onwards'],'svg')
saveas(fig,['figures/','PaperSTD_1844onwards'],'fig')
saveas(fig,['figures/','PaperSTD_1844onwards'],'png')
