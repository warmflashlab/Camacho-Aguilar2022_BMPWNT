%% Plot simulation

%%
clear all

mkdir figures

nameMCMCresult = 'MCMC_results_TimeCourse_ODE_v1';
load('MCMC_results_TimeCourse_ODE_v1.mat')

initcond = structtopass.initcond;
parametersaux = AllAcceptedParameters(length(AllAcceptedCosts));
% parametersaux.paramBMPfunc = [1,1,30];


load('DataToFitTCv7-DataSet21_TimeCourse_Concentrations_Controls.mat')
structtopass = struct('ExpDataStruct',ExpDataStruct,'AllMatProp',AllMatProp,'nExp',nExp,'parfitnumbers',parfitnumbers,'parameters',parametersim,'initcond',initcond);

for ii = 1:length(ExpDataStruct)
ExpDataStruct(ii).MatrixData = ExpDataStruct(ii).MatrixSimpData;

end




%%

% tic
NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1

rng(20);


%Fitted conditions
IntervalsExp = {[1:8],9:16,17:24,25:32,33:39,40:43,44:47,48:51,52:55,56:59,60:63,64,65};



colorbg = 'w';
lineandtextcolor = 'k';
linewidthplots = 3;
sizescatterpoint = 100;

for jj = 5%length(IntervalsExp)
    %1%:length(IntervalsExp)
    figure
    
    tiledlayout(length(IntervalsExp{jj}),5)


set(gcf,'Position',[10 10 2000 1500])
    
    colorsplotscatter = distinguishable_colors(length(IntervalsExp{jj}),{'w','k'});

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

nexttile
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

nexttile
% subplot(2,3,3)
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
nexttile
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
nexttile
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

% subplot(2,3,6)
nexttile
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
    legend([ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).ConditionsNames],'Location','bestoutside')
    ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).ConditionsNames

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

saveas(fig,['figures/','ErrorBarsSolutions_',nameMCMCresult,'_AllData_',num2str(jj)],'svg')
saveas(fig,['figures/','ErrorBarsSolutions_',nameMCMCresult,'_AllData_',num2str(jj)],'fig')
saveas(fig,['figures/','ErrorBarsSolutions_',nameMCMCresult,'_AllData_',num2str(jj)],'png')
% 
% 
% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperPosition', [1 1 28 19]);
% print(gcf, '-dpdf', ['figures/','ErrorBarsSolutions_MCMC_ODE_v3_AllData_',num2str(jj)]);

close

end
%%

colorbg = 'w';
lineandtextcolor = 'k';
linewidthplots = 3;
sizescatterpoint = 50;

figure
    
    tiledlayout(length(6:(length(IntervalsExp)-2)),5)
 colorsplotscatter = distinguishable_colors(length(6:(length(IntervalsExp)-2)),{'w','k'});
for jjaux = 1:length(6:(length(IntervalsExp)-2))
    jj = jjaux + 5;
    %1%:length(IntervalsExp)
    
% x1=10;
% y1=10;
% width=3000;
% height=2000;
% set(gcf,'position',[x1,y1,width,height])
set(gcf,'Position',[10 10 2000 1500])
    
   
nexttile
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

% nexttile
plot(ttrajplot2,squeeze(soltraj(2,tpointsplot2)),'LineWidth',linewidthplots,'Color',colorsplotscatter(jjaux,:))
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
    end

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

nexttile
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

% subplot(2,3,3)
plot(ttrajplot2,squeeze(soltraj(5,tpointsplot2)),'LineWidth',linewidthplots,'Color',colorsplotscatter(jjaux,:))
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
    end

% subplot(2,3,4)
nexttile
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

plot(ttrajplot,squeeze(soltraj(6,tpointsplot)),'LineWidth',linewidthplots,'Color',colorsplotscatter(jjaux,:))
xlim([ttrajplot(1),ttrajplot(end)])
ylim([0,1.1])
hold on
scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,DataMat(1),60,'MarkerFaceColor',colorsplotscatter(jjaux,:),'MarkerEdgeColor',colorsplotscatter(jjaux,:))
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
    end

% subplot(2,3,5)
nexttile
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
  
plot(ttrajplot,squeeze(soltraj(7,tpointsplot)),'LineWidth',linewidthplots,'Color',colorsplotscatter(jjaux,:))
xlim([ttrajplot(1),ttrajplot(end)])
% ylim([0,attractors(2,2)])
ylim([0,1.5])
hold on
scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,DataMat(2),60,'MarkerFaceColor',colorsplotscatter(jjaux,:),'MarkerEdgeColor',colorsplotscatter(jjaux,:))
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
    end
% subplot(2,3,6)
nexttile
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

plot(ttrajplot,squeeze(soltraj(8,tpointsplot)),'LineWidth',linewidthplots,'Color',colorsplotscatter(jjaux,:))
xlim([ttrajplot(1),ttrajplot(end)])
ylim([0,1.5])
hold on
scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,DataMat(3),60,'MarkerFaceColor',colorsplotscatter(jjaux,:),'MarkerEdgeColor',colorsplotscatter(jjaux,:),'HandleVisibility','off')
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
    end
    squeeze(soltraj(6:8,end))
    legend([ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).ConditionsNames],'Location','bestoutside')
    ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).ConditionsNames



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

% saveas(fig,['figures/','ErrorBarsSolutions_',nameMCMCresult,'_AllData_',num2str(jj)],'svg')
% saveas(fig,['figures/','ErrorBarsSolutions_',nameMCMCresult,'_AllData_',num2str(jj)],'fig')
% saveas(fig,['figures/','ErrorBarsSolutions_',nameMCMCresult,'_AllData_',num2str(jj)],'png')
% 
% 
% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperPosition', [1 1 28 19]);
% print(gcf, '-dpdf', ['figures/','ErrorBarsSolutions_MCMC_ODE_v3_AllData_',num2str(jj)]);

% close

end

 saveas(fig,['figures/','ErrorBarsSolutions_Timecourse'],'svg')
saveas(fig,['figures/','ErrorBarsSolutions_Timecourse'],'fig')
saveas(fig,['figures/','ErrorBarsSolutions_Timecourse'],'png')
% 
% 
% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperPosition', [1 1 28 19]);
% print(gcf, '-dpdf', ['figures/','ErrorBarsSolutions_MCMC_ODE_v3_AllData_',num2str(jj)]);

close

%% Control conditions

for jjaux = 1:2%length(IntervalsExp)
    %1%:length(IntervalsExp)
    jj = 11+jjaux;
    figure
    
    tiledlayout(length(IntervalsExp{jj}),5)

% x1=10;
% y1=10;
% width=3000;
% height=2000;
% set(gcf,'position',[x1,y1,width,height])
set(gcf,'Position',[10 10 2000 200])
    
    colorsplotscatter = distinguishable_colors(length(IntervalsExp{jj}),{'w','k'});

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

nexttile
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

nexttile
% subplot(2,3,3)
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
nexttile
plot(ttrajplot,squeeze(soltraj(6,tpointsplot)),'LineWidth',linewidthplots,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot(1),ttrajplot(end)])
ylim([0,1.1])
hold on
if jj==13
    scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,0,60,'MarkerFaceColor',colorsplotscatter(conditiontosimulateidx,:),'MarkerEdgeColor',colorsplotscatter(conditiontosimulateidx,:))

else
scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,DataMat(1),60,'MarkerFaceColor',colorsplotscatter(conditiontosimulateidx,:),'MarkerEdgeColor',colorsplotscatter(conditiontosimulateidx,:))
end
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
nexttile
plot(ttrajplot,squeeze(soltraj(7,tpointsplot)),'LineWidth',linewidthplots,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot(1),ttrajplot(end)])
% ylim([0,attractors(2,2)])
ylim([0,1.5])
hold on
scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,DataMat(2),60,'MarkerFaceColor',colorsplotscatter(conditiontosimulateidx,:),'MarkerEdgeColor',colorsplotscatter(conditiontosimulateidx,:))
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

% subplot(2,3,6)
nexttile
plot(ttrajplot,squeeze(soltraj(8,tpointsplot)),'LineWidth',linewidthplots,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot(1),ttrajplot(end)])
ylim([0,1.5])
hold on
scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,DataMat(3),60,'MarkerFaceColor',colorsplotscatter(conditiontosimulateidx,:),'MarkerEdgeColor',colorsplotscatter(conditiontosimulateidx,:),'HandleVisibility','off')
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
    legend([ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).ConditionsNames],'Location','bestoutside')
    ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).ConditionsNames

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

saveas(fig,['figures/','ErrorBarsSolutions_',nameMCMCresult,'_AllData_',num2str(jj)],'svg')
saveas(fig,['figures/','ErrorBarsSolutions_',nameMCMCresult,'_AllData_',num2str(jj)],'fig')
saveas(fig,['figures/','ErrorBarsSolutions_',nameMCMCresult,'_AllData_',num2str(jj)],'png')
% 
% 
% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperPosition', [1 1 28 19]);
% print(gcf, '-dpdf', ['figures/','ErrorBarsSolutions_MCMC_ODE_v3_AllData_',num2str(jj)]);

close

end