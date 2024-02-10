%% Plot simulation

%%
clear all

mkdir figures

nameMCMCresult = 'MCMC_results_TimeCourse_ODE_v1';
load('MCMC_results_TimeCourse_ODE_v1.mat')

initcond = structtopass.initcond;
parametersaux = AllAcceptedParameters(length(AllAcceptedCosts));
% parametersaux.paramBMPfunc = [1,1,30];


load('ExpData.mat')
structtopass = struct('ExpDataStruct',ExpDataStruct,'AllMatProp',AllMatProp,'nExp',nExp,'parfitnumbers',parfitnumbers,'parameters',parametersim,'initcond',initcond);

for ii = 1:length(ExpDataStruct)
ExpDataStruct(ii).MatrixData = ExpDataStruct(ii).MatrixSimpData;

end
matdataaux = cell(169,2);
matdataaux(:,2)=[ExpDataStruct.ConditionsNames]';
matdataaux(:,1) = num2cell(1:169);


%%

% tic
NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1

rng(20);


%Fitted conditions
IntervalsExp = {[1,48,16,80,112],[1,11,12,13,16],[1,20,21,22,24],[1,3,4,5,6,8]};





% IntervalsExp = {}; %v4

colorbg = 'w';
lineandtextcolor = 'k';
linewidthplots = 3;
sizescatterpoint = 100;

for jj = 1:3%length(IntervalsExp)
    %1%:length(IntervalsExp)
    figure
    
%     tiledlayout(length(IntervalsExp{jj}),5)

% x1=10;
% y1=10;
% width=3000;
% height=2000;
% set(gcf,'position',[x1,y1,width,height])
set(gcf,'Position',[10 10 2000 250])
    
%     colorsplotscatter = [187,187,187;170,68,153;136,34,85;204,102,119;221,204,119;17,119,51;136,204,238;51,34,136]/255;%distinguishable_colors(length(IntervalsExp{jj}),{'w','k'});
colorsplotscatter = flip([49,77,161;121,195,237;240,78,73;239,174,30;238,230,50]/255,1)
% colorsplotscatter =distinguishable_colors(length(IntervalsExp{jj}),{'w','k'});
    for conditiontosimulateidx = 1:length(IntervalsExp{jj})
        conditiontosimulate = IntervalsExp{jj}(conditiontosimulateidx);

[soltraj,ttraj,attractors] = functiontofit_ODE_plot(conditiontosimulate,parametersaux,structtopass);

DataMat = ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).MatrixData;


%% Plot Mean trajectories

c=ismember(ttraj/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot = find(c);
ttrajplot = ttraj(tpointsplot)/1.5;

c2=ismember(ttraj/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot2 = find(c2);
ttrajplot2 = ttraj(tpointsplot2)/1.5;

subplot(1,5,1)
plot(ttrajplot2,squeeze(soltraj(2,tpointsplot2)),'LineWidth',linewidthplots,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot2(1),ttrajplot2(end)])
ylim([0,1.5])
hold on
if conditiontosimulateidx==1
title('SMAD4','Color',lineandtextcolor)
end
if conditiontosimulateidx==length(IntervalsExp{jj})
xlabel('t','Color',lineandtextcolor)
end
% ylabel(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).ConditionsNames)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

% subplot(2,3,2)
% plot(ttrajplot2,squeeze(soltraj(4,tpointsplot2)),'LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx,:))
% xlim([ttrajplot2(1),ttrajplot2(end)])
% ylim([0,2.5])
% hold on
% title('WNTP','Color',lineandtextcolor)
% set(gca, 'LineWidth', 2);
%     set(gca,'FontWeight', 'bold')
%     set(gca,'FontName','Myriad Pro')
%     set(gca,'FontSize',18)
%     set(gca,'Color',colorbg)
%     set(gca,'Color',colorbg)
%     set(gca,'XColor',lineandtextcolor)
%     set(gca,'YColor',lineandtextcolor) 

% nexttile
subplot(1,5,2)
plot(ttrajplot2,squeeze(soltraj(5,tpointsplot2)),'LineWidth',linewidthplots,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot2(1),ttrajplot2(end)])
ylim([0,1.5])
hold on
if conditiontosimulateidx==1
title('bCat','Color',lineandtextcolor)
end
if conditiontosimulateidx==length(IntervalsExp{jj})
xlabel('t','Color',lineandtextcolor)
end
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

% subplot(2,3,4)
subplot(1,5,3)
plot(ttrajplot,squeeze(soltraj(6,tpointsplot)),'LineWidth',linewidthplots,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot(1),ttrajplot(end)])
ylim([0,1.1])
hold on
scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,DataMat(1),sizescatterpoint,'MarkerFaceColor',colorsplotscatter(conditiontosimulateidx,:),'MarkerEdgeColor',colorsplotscatter(conditiontosimulateidx,:))
if conditiontosimulateidx==1
title('SOX2','Color',lineandtextcolor)
end
if conditiontosimulateidx==length(IntervalsExp{jj})
xlabel('t','Color',lineandtextcolor)
end
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

% subplot(2,3,5)
subplot(1,5,4)
plot(ttrajplot,squeeze(soltraj(7,tpointsplot)),'LineWidth',linewidthplots,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot(1),ttrajplot(end)])
% ylim([0,attractors(2,2)])
ylim([0,1.5])
hold on
scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,DataMat(2),sizescatterpoint,'MarkerFaceColor',colorsplotscatter(conditiontosimulateidx,:),'MarkerEdgeColor',colorsplotscatter(conditiontosimulateidx,:))
if conditiontosimulateidx==1
title('BRA','Color',lineandtextcolor)
end
if conditiontosimulateidx==length(IntervalsExp{jj})
xlabel('t','Color',lineandtextcolor)
end
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

subplot(1,5,5)
plot(ttrajplot,squeeze(soltraj(8,tpointsplot)),'LineWidth',linewidthplots,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot(1),ttrajplot(end)])
ylim([0,1.5])
hold on
scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,DataMat(3),sizescatterpoint,'MarkerFaceColor',colorsplotscatter(conditiontosimulateidx,:),'MarkerEdgeColor',colorsplotscatter(conditiontosimulateidx,:),'HandleVisibility','off')
if conditiontosimulateidx==1
title('CDX2','Color',lineandtextcolor)
end
if conditiontosimulateidx==length(IntervalsExp{jj})
xlabel('t','Color',lineandtextcolor)
end
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor)  
    
    squeeze(soltraj(6:8,end))
%     legend([ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).ConditionsNames],'Location','bestoutside')
%     ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).ConditionsNames
    end



% l1 = legend([ExpDataStruct(IntervalsExp{jj}).ConditionsNames],'Orientation','Horizontal');
% p1 = get(l1,'Position');
% p2 = [.015 .960 p1(3) p1(4)];
% set(l1,'Position',p2);

ax = gca;
ax.FontSize = 12;
ax.FontName = 'Arial';

set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 



fig = gcf;
    fig.Color = colorbg;
    fig.InvertHardcopy = 'off';
    FontSizeMP = 25;
    fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',FontSizeMP)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

fig = gcf;
    fig.Color = 'w';
    fig.InvertHardcopy = 'off';

saveas(fig,['figures/','ErrorBarsSolutions_',nameMCMCresult,'_AllData_Validations_',num2str(jj)],'svg')
saveas(fig,['figures/','ErrorBarsSolutions_',nameMCMCresult,'_AllData_Validations_',num2str(jj)],'fig')
saveas(fig,['figures/','ErrorBarsSolutions_',nameMCMCresult,'_AllData_Validations_',num2str(jj)],'png')
% 
% 
% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperPosition', [1 1 28 19]);
% print(gcf, '-dpdf', ['figures/','ErrorBarsSolutions_MCMC_ODE_v3_AllData_',num2str(jj)]);

close

end