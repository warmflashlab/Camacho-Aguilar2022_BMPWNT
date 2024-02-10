%% Plot simulation

%%
clear all

mkdir figures

nameMCMCresult = 'MCMC_results_TimeCourse_ODE_v1';
load('MCMC_results_TimeCourse_ODE_v1.mat')

initcond = structtopass.initcond;
parametersaux = AllAcceptedParameters(length(AllAcceptedCosts));


load('ExpData.mat')
structtopass = struct('ExpDataStruct',ExpDataStruct,'AllMatProp',AllMatProp,'nExp',nExp,'parfitnumbers',parfitnumbers,'parameters',parametersim,'initcond',initcond);

for ii = 1:length(ExpDataStruct)
ExpDataStruct(ii).MatrixData = ExpDataStruct(ii).MatrixSimpData;

end



%% Plot trajectory 2ng/ml

% Plot fate map
figure;
set(gcf,'Position',[10 10 800 700])
condname = '2ngml_0to48';

hold on

%Plot signaling
NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1

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

plot(squeeze(soltraj(2,tpointsplot2)),squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',[0.5 0.5 0.5])

scatter(squeeze(soltraj(2,tpointsplot)),squeeze(soltraj(5,tpointsplot)),40,'k','filled')

    end
    
end

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

saveas(fig,['figures/FateMap_NON-IntegerCoeff_',condname],'fig')
saveas(fig,['figures/FateMap_NON-IntegerCoeff_',condname],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures/FateMap_NON-IntegerCoeff_',condname],'pdf')

%% Plot trajectory 2ng/ml

% Plot fate map
figure;
set(gcf,'Position',[10 10 800 700])
conditiontosimulate = 169;
condname = 'BMP10_0-8_Noggin_8-48';

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

plot(squeeze(soltraj(2,tpointsplot2)),squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',[0.5 0.5 0.5])

scatter(squeeze(soltraj(2,tpointsplot)),squeeze(soltraj(5,tpointsplot)),40,'k','filled')

    end
    
end

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

saveas(fig,['figures/FateMap_NON-IntegerCoeff_',condname],'fig')
saveas(fig,['figures/FateMap_NON-IntegerCoeff_',condname],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures/FateMap_NON-IntegerCoeff_',condname],'pdf')

%% Plot trajectory 2ng/ml

% Plot fate map
figure;
set(gcf,'Position',[10 10 800 700])
conditiontosimulate = 165;
condname = 'BMP10_0-48';

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

plot(squeeze(soltraj(2,tpointsplot2)),squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',[0.5 0.5 0.5])

scatter(squeeze(soltraj(2,tpointsplot)),squeeze(soltraj(5,tpointsplot)),40,'k','filled')

    end
    
end

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

saveas(fig,['figures/FateMap_NON-IntegerCoeff_',condname],'fig')
saveas(fig,['figures/FateMap_NON-IntegerCoeff_',condname],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures/FateMap_NON-IntegerCoeff_',condname],'pdf')



%% Plot trajectory 2ng/ml

% Plot fate map
figure;
set(gcf,'Position',[10 10 800 700])
conditiontosimulate = 163;
condname = 'BMP10_0-16_mTeSR_16-48';

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

plot(squeeze(soltraj(2,tpointsplot2)),squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',[0.5 0.5 0.5])

scatter(squeeze(soltraj(2,tpointsplot)),squeeze(soltraj(5,tpointsplot)),40,'k','filled')

    end
    
end

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

saveas(fig,['figures/FateMap_NON-IntegerCoeff_',condname],'fig')
saveas(fig,['figures/FateMap_NON-IntegerCoeff_',condname],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures/FateMap_NON-IntegerCoeff_',condname],'pdf')







