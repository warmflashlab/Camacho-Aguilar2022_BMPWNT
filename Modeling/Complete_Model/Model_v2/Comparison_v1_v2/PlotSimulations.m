%% Plot simulation

%%
clear all

mkdir figures


load('MCMC_results_TimeCourse_ODE_v1.mat')

initcond = structtopass.initcond;
parametersaux = AllAcceptedParameters(length(AllAcceptedCosts));
% parametersaux.paramBMPfunc = [1,1,30];


load('ExpData.mat')
structtopass = struct('ExpDataStruct',ExpDataStruct,'AllMatProp',AllMatProp,'nExp',nExp,'parfitnumbers',parfitnumbers,'parameters',parametersim,'initcond',initcond);

for ii = 1:length(ExpDataStruct)
ExpDataStruct(ii).MatrixData = ExpDataStruct(ii).MatrixSimpData;

end




%%

% tic
NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1%4000;
                 % Noise intensity

% expcov = [0.0848 0.0072 0.0011;
%     0.0072 0.001 0.0002;
%     0.0011 0.0002 0.0004];

% expcov = [1 0 0;
%     0 1 0;
%     0 0 1];

% x0 = AllAcceptedParameters(end-1,:);
% D = AllAcceptedParameters(end,end);

rng(20);

%First step MCMC
% IntervalsExp = {[1:5],7:11,12:17,18:23,24:28,29:33,34:38,39:42,43:45,46:49,50:53,54:59,60:63,64:65};

% IntervalsExp = {1:8};
% IntervalsExp = {1:4,8:4:36}; %Datav8
% IntervalsExp = {1:8,9:16,17:24,25:32,33:40,41:48,49:56,57:64,65:72,73:80,81:88,89:96,97:104,105:112,[113,114,115,116,117,120,118,119],121:127,128:131,132:135,136:139,140:143,144:147,148:151,152:155,156:159}; %v4
IntervalsExp = {1:8,9:16,17:24,25:32,33:40,41:48,49:56,57:64,65:72,89:96,97:104,105:112,[113,114,115,116,117,120,118,119],121:127,128:131,132:135,136:139,140:143,144:147,148:151,152:155,156:159,[127,131,135,139,143,147,151,155,159],160,161,162:169}; %v4

IntervalsExp = {161};


% IntervalsExp = {}; %v4

colorbg = 'w';
lineandtextcolor = 'k';

for jj = 1:length(IntervalsExp)
    %1%:length(IntervalsExp)
    figure

x1=10;
y1=10;
width=1200;
height=900;
set(gcf,'position',[x1,y1,width,height])
    
    colorsplotscatter = distinguishable_colors(2,{'w','k'});

    for conditiontosimulateidx = 1:length(IntervalsExp{jj})
        conditiontosimulate = IntervalsExp{jj}(conditiontosimulateidx);

    [soltraj,ttraj,attractors] = functiontofit_ODE_plot(conditiontosimulate,parametersaux,structtopass);
    
    parametersaux.parammodel(20) = 0.8;
[soltraj2,ttraj2,attractors2] = functiontofit_ODE_plot_v9(conditiontosimulate,parametersaux,structtopass);

DataMat = ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).MatrixData;


%% Plot Mean trajectories

c=ismember(ttraj/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot = find(c);
ttrajplot = ttraj(tpointsplot)/1.5;

c2=ismember(ttraj/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot1 = find(c2);
ttrajplot1 = ttraj(tpointsplot1)/1.5;

c2=ismember(ttraj2/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot2 = find(c2);
ttrajplot2 = ttraj(tpointsplot2)/1.5;

subplot(2,3,1)
plot(ttrajplot1,squeeze(soltraj(2,tpointsplot1)),'LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx,:))
hold on
plot(ttrajplot2,squeeze(soltraj2(2,tpointsplot2)),'--','LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot1(1),ttrajplot1(end)])
ylim([0,1.5])
hold on
title('SMAD4','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

subplot(2,3,2)
plot(ttrajplot1,squeeze(soltraj(4,tpointsplot1)),'LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx,:))
hold on
plot(ttrajplot2,squeeze(soltraj2(4,tpointsplot2)),'--','LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx+1,:))
xlim([ttrajplot1(1),ttrajplot1(end)])
% ylim([0,2.5])
hold on
title('WNTP','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

subplot(2,3,3)
plot(ttrajplot1,squeeze(soltraj(5,tpointsplot1)),'LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx,:))
hold on
plot(ttrajplot2,squeeze(soltraj2(5,tpointsplot2)),'--','LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx+1,:))
xlim([ttrajplot1(1),ttrajplot1(end)])
% ylim([0,1.5])
hold on
title('bCat','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

subplot(2,3,4)
plot(ttrajplot,squeeze(soltraj(6,tpointsplot)),'LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx,:))
hold on
plot(ttrajplot2,squeeze(soltraj2(6,tpointsplot2)),'--','LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx+1,:))
xlim([ttrajplot(1),ttrajplot(end)])
% ylim([0,attractors(1,1)])
hold on
scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,0,60,'MarkerFaceColor',colorsplotscatter(conditiontosimulateidx,:),'MarkerEdgeColor',colorsplotscatter(conditiontosimulateidx,:),'HandleVisibility','off')
title('SOX2','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

subplot(2,3,5)
plot(ttrajplot,squeeze(soltraj(7,tpointsplot)),'LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx,:))
hold on
plot(ttrajplot2,squeeze(soltraj2(7,tpointsplot2)),'--','LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx+1,:))
xlim([ttrajplot(1),ttrajplot(end)])
% ylim([0,attractors(2,2)])
ylim([0,1])
hold on
scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,1,60,'MarkerFaceColor',colorsplotscatter(conditiontosimulateidx,:),'MarkerEdgeColor',colorsplotscatter(conditiontosimulateidx,:),'HandleVisibility','off')
title('BRA','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

subplot(2,3,6)
plot(ttrajplot,squeeze(soltraj(8,tpointsplot)),'LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx,:))
hold on
plot(ttrajplot2,squeeze(soltraj2(8,tpointsplot2)),'--','LineWidth',2,'Color',colorsplotscatter(conditiontosimulateidx+1,:))
xlim([ttrajplot(1),ttrajplot(end)])
ylim([0,attractors(3,3)])
hold on
scatter(ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux,0,60,'MarkerFaceColor',colorsplotscatter(conditiontosimulateidx,:),'MarkerEdgeColor',colorsplotscatter(conditiontosimulateidx,:),'HandleVisibility','off')
title('CDX2','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor)  
    
    

    end
% legend([ExpDataStruct(IntervalsExp{jj}).ConditionsNames],'Location','northwest')
legend({'CHIR in WNT eq. (a_C_\beta = 0.15)','CHIR in bCat eq. (a_C_\beta = 0.8)'})
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
saveas(fig,['figures/','DifferenceCHIRmodel'],'svg')
saveas(fig,['figures/','DifferenceCHIRmodel'],'fig')
saveas(fig,['figures/','DifferenceCHIRmodel'],'png')


% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperPosition', [1 1 28 19]);
% print(gcf, '-dpdf', ['figures/','DifferenceCHIRmodel']);

% close

end