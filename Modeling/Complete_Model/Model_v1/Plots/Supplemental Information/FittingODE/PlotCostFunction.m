colorlinebif = 'k';
colorlineuns = 'r';
FontSizeMP = 30;



figure;
set(gcf,'Position',[10 10 800 600])

load('MCMC_results_TimeCourse_ODE_v1.mat')

plot(AllAcceptedCosts,'LineWidth',3)

grid on

xlabel('Number of accepted parameter')
ylabel('L(\theta)')

set(gca,'Color','w')
set(gca,'XColor','k')
set(gca,'YColor','k')
set(gca,'linewidth',2)


fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',FontSizeMP)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

fig = gcf;
    fig.Color = 'w';
    fig.InvertHardcopy = 'off';
saveas(fig,['figures/','PaperCostFunction_v1'],'svg')
saveas(fig,['figures/','PaperCostFunction_v1'],'fig')
saveas(fig,['figures/','PaperCostFunction_v1'],'png')

%%

MatAllAcceptedParametersModel = [AllAcceptedParameters.parammodel];

% histogram(MatAllAcceptedParametersModel(parfitnumbers(2),:))
% hold on
% histogram(MatAllAcceptedParametersModel(parfitnumbers(2),5000:end))
% histogram(MatAllAcceptedParametersModel(parfitnumbers(2),7000:end))

differencesparvalues = MatAllAcceptedParametersModel(parfitnumbers,1:(end-1))-MatAllAcceptedParametersModel(parfitnumbers,2:end);
normdifferencesparvalues = sqrt(sum(differencesparvalues.^2,1));

plot(normdifferencesparvalues)

%%

%%

tic

res2 = [];

res1 = [];

res3 = [];

res4 = [];

for jj=1:(nExp-2)
    
    aux = ExpDataStruct(jj).MatrixData;
    [maxv,indmaxv] = max(aux);
    
    if (indmaxv==1)&&(aux(1) == aux(2))
        res4 = [res4,jj];
    elseif (indmaxv==2)&&(aux(2) == aux(3))
        
        res4 = [res4,jj];
        
    elseif (indmaxv==1)&&(aux(1) == aux(3))
        
        res4 = [res4,jj];
        
    else
    
    
        if indmaxv==2
            res2 = [res2,jj];%[res2,sum((ExpDataStruct(jj).MatrixData - simulatedEndTrajs(:,jj)).^2)];

        elseif indmaxv==1

            res1 = [res1,jj];%[res1,sum((ExpDataStruct(jj).MatrixData - simulatedEndTrajs(:,jj)).^2)];

        elseif indmaxv==3

            res3 = [res3,jj];

        end
    end
    
end

res5 = [nExp-1,nExp];

toc

%%


AllSubdistances = zeros(length(AllAcceptedCosts),size(AllAcceptedSimulatedTrajs,2));

for tt=1:length(AllAcceptedCosts)
    
    for jj = (1:size(AllAcceptedSimulatedTrajs,2)-1)

AllSubdistances(tt,jj) = sum((ExpDataStruct(jj).MatrixData - AllAcceptedSimulatedTrajs(:,jj,tt)).^2);
    end
    AllSubdistances(tt,size(AllAcceptedSimulatedTrajs,2)) = sum((ExpDataStruct(end).MatrixData(2) - AllAcceptedSimulatedTrajs(2,end,tt)).^2);

end

% figure
% for jj=1:size(AllAcceptedSimulatedTrajs,2)
%     
%     plot(AllSubdistances(:,jj))
%     hold on
%     
%     
% end

%%

figure
subplot(1,5,1)

for jj=1:length(res1)
    
    plot(AllSubdistances(:,res1(jj)),'LineWidth',2)
    hold on
    legend([ExpDataStruct(res1(1:jj)).ConditionsNames]')
%     pause()
    
end
title('SOX2')



subplot(1,5,2)

for jj=1:length(res2)
    
    plot(AllSubdistances(:,res2(jj)),'LineWidth',2)
    hold on
    legend([ExpDataStruct(res2(1:jj)).ConditionsNames]')
%     pause()
    
end
legend([ExpDataStruct(res2).ConditionsNames]')

title('BRA')

subplot(1,5,3)

for jj=1:length(res3)
    
    plot(AllSubdistances(:,res3(jj)),'LineWidth',2)
    hold on
    legend([ExpDataStruct(res3(1:jj)).ConditionsNames]')
%     pause()
    
    
end
legend([ExpDataStruct(res3).ConditionsNames]')

title('CDX2')

subplot(1,5,4)

for jj=1:length(res4)
    
    plot(AllSubdistances(:,res4(jj)),'LineWidth',2)
    hold on
    legend([ExpDataStruct(res4(1:jj)).ConditionsNames]')
%     pause()
    
    
end
legend([ExpDataStruct(res4).ConditionsNames]')

title('Mixed')

subplot(1,5,5)

for jj=1:length(res5)
    
    plot(AllSubdistances(:,res5(jj)),'LineWidth',2)
    hold on
    legend([ExpDataStruct(res5(1:jj)).ConditionsNames]')
%     pause()
    
    
end
legend([ExpDataStruct(res5).ConditionsNames]')

title('Mixed')

%%

figure
% subplot(1,5,1)

% for jj=1:length(res1)
    
    plot(sum(AllSubdistances(:,res1)/length(res1),2),'LineWidth',2)
    hold on
    plot(sum(AllSubdistances(:,res2)/length(res2),2),'LineWidth',2)
    plot(sum(AllSubdistances(:,res3)/length(res3),2),'LineWidth',2)
    plot(sum(AllSubdistances(:,res4)/length(res4),2),'LineWidth',2)
    plot(sum(AllSubdistances(:,res5)/length(res5),2),'LineWidth',2)
    
    legend({'SOX2','BRA','CDX2','Mixed','Controls'})

