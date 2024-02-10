%% Plot simulation

%%
clear all

mkdir figures

%load('FateMap_Workspace.mat')

nameMCMCresult = 'MCMC_results_TimeCourse_ODE_v1';
load('/MCMC_results_TimeCourse_ODE_v1.mat')

initcond = structtopass.initcond;
parametersaux = AllAcceptedParameters(length(AllAcceptedCosts));
% parametersaux.paramBMPfunc = [1,1,30];


load('ExpData.mat')
structtopass = struct('ExpDataStruct',ExpDataStruct,'AllMatProp',AllMatProp,'nExp',nExp,'parfitnumbers',parfitnumbers,'parameters',parametersim,'initcond',initcond);

for ii = 1:length(ExpDataStruct)
ExpDataStruct(ii).MatrixData = ExpDataStruct(ii).MatrixSimpData;

end


IntervalsExp = {169,165,163,116};

condnames = {'BMP10_0-8_Noggin_8-48','BMP10_0-48','BMP10_0-16_mTeSR_16-48','2ngml_0to48'};

Allsoltraj = cell(1,1);
Allttraj = cell(1,1);

maxCDX2 = 0;
minCDX2 = 0;

for jj = 1:length(IntervalsExp)
    
    for conditiontosimulateidx = 1:length(IntervalsExp{jj})
        
        conditiontosimulate = IntervalsExp{jj}(conditiontosimulateidx);

[soltraj,ttraj,attractors] = functiontofit_ODE_plot(conditiontosimulate,parametersaux,structtopass);

Allsoltraj{jj} = soltraj;
Allttraj{jj} = ttraj;

if jj==1
    maxCDX2 = max(soltraj(end,:));
minCDX2 = min(soltraj(end,:));
else

maxCDX2 = max(maxCDX2,max(soltraj(end,:)));
minCDX2 = min(minCDX2,min(soltraj(end,:)));
end

    end
end
    


%% Plot trajectory 2ng/ml

% Plot fate map
figure;
set(gcf,'Position',[10 10 800 700])
condname = '2ngml_0to48';

% [B,W] = meshgrid(BMPvalues,WNTvalues);
% pcolor(B,W,simplenstablepointsmatrixclean')
% colorbar
% xlim([0,1.5])
% ylim([0,1.2])
hold on

%Plot signaling
NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1

% IntervalsExp ={4};
IntervalsExp ={116};
[ExpDataStruct(IntervalsExp{1}).ConditionsNames]
colorsplotscatter = flip([49,77,161;0,117,181;121,195,237;240,78,73;239,174,30;238,230,50]/255,1);

for jj = 1:length(IntervalsExp)
    
    for conditiontosimulateidx = 1:length(IntervalsExp{jj})
        
        conditiontosimulate = IntervalsExp{jj}(conditiontosimulateidx);

[soltraj,ttraj,attractors] = functiontofit_ODE_plot(conditiontosimulate,parametersaux,structtopass);

DataMat = ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).MatrixData;


%% Plot Mean trajectories

c=ismember(ttraj/1.5,[0,8,24,30,48]);
tpointsplot = find(c);
ttrajplot = ttraj(tpointsplot)/1.5;

c2=ismember(ttraj/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot2 = find(c2);
ttrajplot2 = ttraj(tpointsplot2)/1.5;

% plot(squeeze(soltraj(2,tpointsplot2)),squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',[0.5 0.5 0.5])

scatter(soltraj(2,:),soltraj(5,:),40,soltraj(end,:),'filled')

% scatter(squeeze(soltraj(2,tpointsplot)),squeeze(soltraj(5,tpointsplot)),40,'k','filled')

    end
    
end

colorbar
caxis([minCDX2,maxCDX2])

xlim([0,1.5])
ylim([0,1.2])

xlabel('SMAD4')
ylabel('bCat')
colorbarplot=colorbar;
% ylabel(colorbarplot,'CDX2','FontSize',16,'Rotation',90);
% hColourbar.Label.Position(1) = 20;
grid on


fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_',condname],'fig')
saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_',condname],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_',condname],'pdf')

%% Plot trajectory 10ng/ml 0-8h, Noggin8-48

% Plot fate map
figure;
set(gcf,'Position',[10 10 800 700])
conditiontosimulate = 169;
condname = 'BMP10_0-8_Noggin_8-48';

% [B,W] = meshgrid(BMPvalues,WNTvalues);
% pcolor(B,W,simplenstablepointsmatrixclean')
% colorbar
% xlim([0,1.5])
% ylim([0,1.2])
hold on

%Plot signaling
NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1

% IntervalsExp ={4};
IntervalsExp ={conditiontosimulate};
[ExpDataStruct(IntervalsExp{1}).ConditionsNames]
colorsplotscatter = flip([49,77,161;0,117,181;121,195,237;240,78,73;239,174,30;238,230,50]/255,1);

for jj = 1:length(IntervalsExp)
    
    for conditiontosimulateidx = 1:length(IntervalsExp{jj})
        
        conditiontosimulate = IntervalsExp{jj}(conditiontosimulateidx);

[soltraj,ttraj,attractors] = functiontofit_ODE_plot(conditiontosimulate,parametersaux,structtopass);

DataMat = ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).MatrixData;


%% Plot Mean trajectories

c=ismember(ttraj/1.5,[0,8,24,30,48]);
tpointsplot = find(c);
ttrajplot = ttraj(tpointsplot)/1.5;

c2=ismember(ttraj/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot2 = find(c2);
ttrajplot2 = ttraj(tpointsplot2)/1.5;

% plot(squeeze(soltraj(2,tpointsplot2)),squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',[0.5 0.5 0.5])

scatter(soltraj(2,:),soltraj(5,:),40,soltraj(end,:),'filled')

% scatter(squeeze(soltraj(2,tpointsplot)),squeeze(soltraj(5,tpointsplot)),40,'k','filled')

    end
    
end

colorbar
caxis([minCDX2,maxCDX2])

xlim([0,1.5])
ylim([0,1.2])

xlabel('SMAD4')
ylabel('bCat')
grid on


fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_',condname],'fig')
saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_',condname],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_',condname],'pdf')

%% Plot trajectory 10ng/ml 0-48h

% Plot fate map
figure;
set(gcf,'Position',[10 10 800 700])
conditiontosimulate = 165;
condname = 'BMP10_0-48';

% [B,W] = meshgrid(BMPvalues,WNTvalues);
% pcolor(B,W,simplenstablepointsmatrixclean')
% colorbar
% xlim([0,1.5])
% ylim([0,1.2])
hold on

%Plot signaling
NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1

% IntervalsExp ={4};
IntervalsExp ={conditiontosimulate};
[ExpDataStruct(IntervalsExp{1}).ConditionsNames]
colorsplotscatter = flip([49,77,161;0,117,181;121,195,237;240,78,73;239,174,30;238,230,50]/255,1);

for jj = 1:length(IntervalsExp)
    
    for conditiontosimulateidx = 1:length(IntervalsExp{jj})
        
        conditiontosimulate = IntervalsExp{jj}(conditiontosimulateidx);

[soltraj,ttraj,attractors] = functiontofit_ODE_plot(conditiontosimulate,parametersaux,structtopass);

DataMat = ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).MatrixData;


%% Plot Mean trajectories

c=ismember(ttraj/1.5,[0,8,24,30,48]);
tpointsplot = find(c);
ttrajplot = ttraj(tpointsplot)/1.5;

c2=ismember(ttraj/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot2 = find(c2);
ttrajplot2 = ttraj(tpointsplot2)/1.5;

% plot(squeeze(soltraj(2,tpointsplot2)),squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',[0.5 0.5 0.5])

scatter(soltraj(2,:),soltraj(5,:),40,soltraj(end,:),'filled')

% scatter(squeeze(soltraj(2,tpointsplot)),squeeze(soltraj(5,tpointsplot)),40,'k','filled')

    end
    
end

colorbar
caxis([minCDX2,maxCDX2])

xlim([0,1.5])
ylim([0,1.2])

xlabel('SMAD4')
ylabel('bCat')
grid on


fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_',condname],'fig')
saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_',condname],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_',condname],'pdf')



%% Plot trajectory 10ng/ml 0-16, mtesr 16-48

% Plot fate map
figure;
set(gcf,'Position',[10 10 800 700])
conditiontosimulate = 163;
condname = 'BMP10_0-16_mTeSR_16-48';

% [B,W] = meshgrid(BMPvalues,WNTvalues);
% pcolor(B,W,simplenstablepointsmatrixclean')
% colorbar
% xlim([0,1.5])
% ylim([0,1.2])
hold on

%Plot signaling
NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1

% IntervalsExp ={4};
IntervalsExp ={conditiontosimulate};
[ExpDataStruct(IntervalsExp{1}).ConditionsNames]
colorsplotscatter = flip([49,77,161;0,117,181;121,195,237;240,78,73;239,174,30;238,230,50]/255,1);

for jj = 1:length(IntervalsExp)
    
    for conditiontosimulateidx = 1:length(IntervalsExp{jj})
        
        conditiontosimulate = IntervalsExp{jj}(conditiontosimulateidx);

[soltraj,ttraj,attractors] = functiontofit_ODE_plot(conditiontosimulate,parametersaux,structtopass);

DataMat = ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).MatrixData;


%% Plot Mean trajectories

c=ismember(ttraj/1.5,[0,8,24,30,48]);
tpointsplot = find(c);
ttrajplot = ttraj(tpointsplot)/1.5;

c2=ismember(ttraj/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot2 = find(c2);
ttrajplot2 = ttraj(tpointsplot2)/1.5;

% plot(squeeze(soltraj(2,tpointsplot2)),squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',[0.5 0.5 0.5])

scatter(soltraj(2,:),soltraj(5,:),40,soltraj(end,:),'filled')

% scatter(squeeze(soltraj(2,tpointsplot)),squeeze(soltraj(5,tpointsplot)),40,'k','filled')

    end
    
end

colorbar
caxis([minCDX2,maxCDX2])

xlim([0,1.5])
ylim([0,1.2])

xlabel('SMAD4')
ylabel('bCat')
grid on


fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_',condname],'fig')
saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_',condname],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_',condname],'pdf')


%% All together

cmapname = 'parula';
% Plot trajectory 10ng/ml 0-8h, Noggin8-48

% Plot fate map
figure
set(gcf,'Position',[10 10 2200 500])
% set(gcf,'Position',[10 10 800 700])
tiledlayout(1,4)

nexttile
conditiontosimulate = 169;
condname = 'BMP10_0-8_Noggin_8-48';

% [B,W] = meshgrid(BMPvalues,WNTvalues);
% pcolor(B,W,simplenstablepointsmatrixclean')
% colorbar
% xlim([0,1.5])
% ylim([0,1.2])
hold on

%Plot signaling
NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1

% IntervalsExp ={4};
IntervalsExp ={conditiontosimulate};
[ExpDataStruct(IntervalsExp{1}).ConditionsNames]
colorsplotscatter = flip([49,77,161;0,117,181;121,195,237;240,78,73;239,174,30;238,230,50]/255,1);

for jj = 1:length(IntervalsExp)
    
    for conditiontosimulateidx = 1:length(IntervalsExp{jj})
        
        conditiontosimulate = IntervalsExp{jj}(conditiontosimulateidx);

[soltraj,ttraj,attractors] = functiontofit_ODE_plot(conditiontosimulate,parametersaux,structtopass);

DataMat = ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).MatrixData;


% Plot Mean trajectories

c=ismember(ttraj/1.5,[0,8,24,30,48]);
tpointsplot = find(c);
ttrajplot = ttraj(tpointsplot)/1.5;

c2=ismember(ttraj/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot2 = find(c2);
ttrajplot2 = ttraj(tpointsplot2)/1.5;

% plot(squeeze(soltraj(2,tpointsplot2)),squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',[0.5 0.5 0.5])

scatter(soltraj(2,:),soltraj(5,:),40,soltraj(end,:),'filled')

% scatter(squeeze(soltraj(2,tpointsplot)),squeeze(soltraj(5,tpointsplot)),40,'k','filled')

    end
    
end

colorbar
caxis([minCDX2,maxCDX2])
colormap(cmapname)

xlim([0,1.5])
ylim([0,1.2])

xlabel('SMAD4')
ylabel('bCat')
grid on


fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')



nexttile
conditiontosimulate = 163;
condname = 'BMP10_0-16_mTeSR_16-48';

% [B,W] = meshgrid(BMPvalues,WNTvalues);
% pcolor(B,W,simplenstablepointsmatrixclean')
% colorbar
% xlim([0,1.5])
% ylim([0,1.2])
hold on

%Plot signaling
NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1

% IntervalsExp ={4};
IntervalsExp ={conditiontosimulate};
[ExpDataStruct(IntervalsExp{1}).ConditionsNames]
colorsplotscatter = flip([49,77,161;0,117,181;121,195,237;240,78,73;239,174,30;238,230,50]/255,1);

for jj = 1:length(IntervalsExp)
    
    for conditiontosimulateidx = 1:length(IntervalsExp{jj})
        
        conditiontosimulate = IntervalsExp{jj}(conditiontosimulateidx);

[soltraj,ttraj,attractors] = functiontofit_ODE_plot(conditiontosimulate,parametersaux,structtopass);

DataMat = ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).MatrixData;


%% Plot Mean trajectories

c=ismember(ttraj/1.5,[0,8,24,30,48]);
tpointsplot = find(c);
ttrajplot = ttraj(tpointsplot)/1.5;

c2=ismember(ttraj/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot2 = find(c2);
ttrajplot2 = ttraj(tpointsplot2)/1.5;

% plot(squeeze(soltraj(2,tpointsplot2)),squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',[0.5 0.5 0.5])

scatter(soltraj(2,:),soltraj(5,:),40,soltraj(end,:),'filled')

% scatter(squeeze(soltraj(2,tpointsplot)),squeeze(soltraj(5,tpointsplot)),40,'k','filled')

    end
    
end

colorbar
caxis([minCDX2,maxCDX2])
colormap(cmapname)

xlim([0,1.5])
ylim([0,1.2])

xlabel('SMAD4')
ylabel('bCat')
grid on


fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')



nexttile
conditiontosimulate = 165;
condname = 'BMP10_0-48';

% [B,W] = meshgrid(BMPvalues,WNTvalues);
% pcolor(B,W,simplenstablepointsmatrixclean')
% colorbar
% xlim([0,1.5])
% ylim([0,1.2])
hold on

%Plot signaling
NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1

% IntervalsExp ={4};
IntervalsExp ={conditiontosimulate};
[ExpDataStruct(IntervalsExp{1}).ConditionsNames]
colorsplotscatter = flip([49,77,161;0,117,181;121,195,237;240,78,73;239,174,30;238,230,50]/255,1);

for jj = 1:length(IntervalsExp)
    
    for conditiontosimulateidx = 1:length(IntervalsExp{jj})
        
        conditiontosimulate = IntervalsExp{jj}(conditiontosimulateidx);

[soltraj,ttraj,attractors] = functiontofit_ODE_plot(conditiontosimulate,parametersaux,structtopass);

DataMat = ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).MatrixData;


%% Plot Mean trajectories

c=ismember(ttraj/1.5,[0,8,24,30,48]);
tpointsplot = find(c);
ttrajplot = ttraj(tpointsplot)/1.5;

c2=ismember(ttraj/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot2 = find(c2);
ttrajplot2 = ttraj(tpointsplot2)/1.5;

% plot(squeeze(soltraj(2,tpointsplot2)),squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',[0.5 0.5 0.5])

scatter(soltraj(2,:),soltraj(5,:),40,soltraj(end,:),'filled')

% scatter(squeeze(soltraj(2,tpointsplot)),squeeze(soltraj(5,tpointsplot)),40,'k','filled')

    end
    
end

colorbar
caxis([minCDX2,maxCDX2])
colormap(cmapname)

xlim([0,1.5])
ylim([0,1.2])

xlabel('SMAD4')
ylabel('bCat')
grid on


fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')




nexttile

condname = '2ngml_0to48';

% [B,W] = meshgrid(BMPvalues,WNTvalues);
% pcolor(B,W,simplenstablepointsmatrixclean')
% colorbar
% xlim([0,1.5])
% ylim([0,1.2])
hold on

%Plot signaling
NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1

% IntervalsExp ={4};
IntervalsExp ={116};
[ExpDataStruct(IntervalsExp{1}).ConditionsNames]
colorsplotscatter = flip([49,77,161;0,117,181;121,195,237;240,78,73;239,174,30;238,230,50]/255,1);

for jj = 1:length(IntervalsExp)
    
    for conditiontosimulateidx = 1:length(IntervalsExp{jj})
        
        conditiontosimulate = IntervalsExp{jj}(conditiontosimulateidx);

[soltraj,ttraj,attractors] = functiontofit_ODE_plot(conditiontosimulate,parametersaux,structtopass);

DataMat = ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).MatrixData;


%% Plot Mean trajectories

c=ismember(ttraj/1.5,[0,8,24,30,48]);
tpointsplot = find(c);
ttrajplot = ttraj(tpointsplot)/1.5;

c2=ismember(ttraj/1.5,[0:1:ExpDataStruct(IntervalsExp{jj}(conditiontosimulateidx)).TimeFixedaux]);
tpointsplot2 = find(c2);
ttrajplot2 = ttraj(tpointsplot2)/1.5;

% plot(squeeze(soltraj(2,tpointsplot2)),squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',[0.5 0.5 0.5])

scatter(soltraj(2,:),soltraj(5,:),40,soltraj(end,:),'filled')

% scatter(squeeze(soltraj(2,tpointsplot)),squeeze(soltraj(5,tpointsplot)),40,'k','filled')

    end
    
end

colorbar
caxis([minCDX2,maxCDX2])
colormap(cmapname)

xlim([0,1.5])
ylim([0,1.2])

xlabel('SMAD4')
ylabel('bCat')
colorbarplot=colorbar;
% ylabel(colorbarplot,'CDX2','FontSize',16,'Rotation',90);
% hColourbar.Label.Position(1) = 20;
grid on


fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',30)
set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_ALL'],'fig')
saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_ALL'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures/FateMap_NON-IntegerCoeff-CDX2Colorcoded_ALL'],'pdf')

