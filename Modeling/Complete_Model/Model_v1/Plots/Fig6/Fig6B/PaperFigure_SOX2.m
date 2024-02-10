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




NdrawsMCMC = 1;
Ndrawsperparameter = 1;
NExp=structtopass.nExp; 

nsimulations = 1

rng(20);

IntervalsExp = {[166,169,168,163,165]};



colorbg = 'w';
lineandtextcolor = 'k';
colors = [185,83,159;194,110,153;202,134,146;212,158,135;222,183,119;234,208,94;247,235,47;211,223,105;172,212,141;129,202,170;70,193,198]/255;
for jj = 1
    figure

x1=10;
y1=10;
width=3000;
height=2000;

set(gcf,'Position',[10 10 1000 700])
    
    colorsplotscatter = flip([colors([11,7,4,2],:);193/255,39/255,160/255],1);

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

[ttrajplot,ia,ic] = unique(ttrajplot);
tpointsplot = tpointsplot(ia);

if conditiontosimulateidx==1
    controlsoltraj = soltraj;
    controltpointsplot = tpointsplot;
end

plot(ttrajplot,squeeze(soltraj(6,tpointsplot)),'LineWidth',3,'Color',colorsplotscatter(conditiontosimulateidx,:))

xlim([ttrajplot(1),ttrajplot(end)])

hold on
title('SOX2','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 
    xticks(0:10:40)
    ylim([-0.2,1.2])
    yticks([-0.2:0.2:1.2])
grid on

  
    

    end
legend([ExpDataStruct(IntervalsExp{jj}).ConditionsNames],'Location','eastoutside')


grid on
ax = gca;
ax.FontSize = 12;
ax.FontName = 'Myriad Pro';
xticks(0:10:40)

set(gca, 'LineWidth', 3);
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
saveas(fig,['figures/','PaperFig2_SOX2_',nameMCMCresult,'_AllData_',num2str(jj)],'svg')
saveas(fig,['figures/','PaperFig2_SOX2_',nameMCMCresult,'_AllData_',num2str(jj)],'fig')
saveas(fig,['figures/','PaperFig2_SOX2_',nameMCMCresult,'_AllData_',num2str(jj)],'png')



end