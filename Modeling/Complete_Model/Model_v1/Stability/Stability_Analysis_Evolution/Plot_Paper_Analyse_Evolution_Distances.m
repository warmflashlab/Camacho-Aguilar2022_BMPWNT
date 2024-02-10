clear all
%%
load('StabilityAnalysis_Real_NON-INTEGERCOEFFITIENTS_v1_SensitivityAllGood2_Parameters_Method4_findcriticalpointsv4_tF1000');

significantchangesdistances1 = significantchangesdistances;
Allcellstability1= Allcellstability;
AllNtrialsall1 = AllNtrialsall;
Allnstablepointsmatrix1 =Allnstablepointsmatrix;
Allstabilityall1 = Allstabilityall;

load('StabilityAnalysis_Real_NON-INTEGERCOEFFITIENTS_v1_MCMC_results_TimeCourse_ODE_v1_Parameters_Method4_findcriticalpointsv4_tF1000')

significantchangesdistances2 = significantchangesdistances;
Allcellstability2= Allcellstability;
AllNtrialsall2 = AllNtrialsall;
Allnstablepointsmatrix2 =Allnstablepointsmatrix;
Allstabilityall2 = Allstabilityall;

%%

significantchangesdistances = [significantchangesdistances1([1,30]),significantchangesdistances2([4,end])];
Allcellstability = [Allcellstability1([1,30]),Allcellstability2([4,end])];
AllNtrialsall = [AllNtrialsall1([1,30]),AllNtrialsall2([4,end])];
Allnstablepointsmatrix =[Allnstablepointsmatrix1([1,30]),Allnstablepointsmatrix1([4,end])];
Allstabilityall = [Allstabilityall1([1,30]),Allstabilityall2([4,end])];

%% Understand which subdistances are getting better
load('MCMC_results_TimeCourse_ODE_v1.mat','AllAcceptedSimulatedTrajs','ExpDataStruct')

%%
AllSubdistances = zeros(length(significantchangesdistances),size(AllAcceptedSimulatedTrajs,2));

ExpDataStruct(65).MatrixData = [0;1;0];

for ii = 1:length(significantchangesdistances)
    for jj = 1:size(AllAcceptedSimulatedTrajs,2)

        AllSubdistances(ii,jj) = sqrt(sum((ExpDataStruct(jj).MatrixData - AllAcceptedSimulatedTrajs(:,jj,significantchangesdistances(ii))).^2));
        
    end
    
end

%%
colorbg = 'w';
lineandtextcolor = 'k';

figure
x1=10;
y1=10;
% width=3000;
% height=2000;
width=1000;
height=1200;
set(gcf,'position',[x1,y1,width,height])


ExpConds = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18:24,26,27,29,30:38,40:46,48:50,52:58,60:62,64,65];
[values,idx] = sort(AllSubdistances(1,ExpConds),'descend');
cdata = AllSubdistances(:,ExpConds(idx));
xvalues = AllAcceptedCosts(significantchangesdistances);
yvalues = [ExpDataStruct(ExpConds(idx)).ConditionsNames];

h = heatmap(cdata');

h.YDisplayLabels = yvalues;
h.XDisplayLabels = xvalues;
ylabel('Experimental condition')
xlabel('L$(\theta)$')

% set(gca, 'LineWidth', 3);
%     set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Arial')
    set(gca,'FontSize',15)
%     set(gca,'Color',colorbg)
%     set(gca,'Color',colorbg)
%     set(gca,'XColor',lineandtextcolor)
%     set(gca,'YColor',lineandtextcolor) 
    
    fig = gcf;
fig.Color = colorbg;
fig.InvertHardcopy = 'off';

saveas(fig,['figures/','PlotEvolutionDistances_Paper'],'svg')
saveas(fig,['figures/','PlotEvolutionDistances_Paper'],'fig')
saveas(fig,['figures/','PlotEvolutionDistances_Paper'],'png')

%%
colorbg = 'w';
lineandtextcolor = 'k';

figure
x1=10;
y1=10;
% width=3000;
% height=2000;
width=1000;
height=1200;
set(gcf,'position',[x1,y1,width,height])


ExpConds = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18:24,26,27,29,30:38,40:46,48:50,52:58,60:62,64,65];
cdata = AllSubdistances(:,ExpConds);
xvalues = AllAcceptedCosts(significantchangesdistances);
yvalues = [ExpDataStruct(ExpConds).ConditionsNames];

h = heatmap(cdata');

h.YDisplayLabels = yvalues;
h.XDisplayLabels = xvalues;
ylabel('Experimental condition')
xlabel('L$(\theta)$')

% set(gca, 'LineWidth', 3);
%     set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Arial')
    set(gca,'FontSize',15)
%     set(gca,'Color',colorbg)
%     set(gca,'Color',colorbg)
%     set(gca,'XColor',lineandtextcolor)
%     set(gca,'YColor',lineandtextcolor) 
    
    fig = gcf;
fig.Color = colorbg;
fig.InvertHardcopy = 'off';

