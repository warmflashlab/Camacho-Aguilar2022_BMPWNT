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

%%
colorbg = 'w';
lineandtextcolor = 'k';

% figure

x1=10;
y1=10;
% width=3000;
% height=2000;
width=2500;
height=300;
set(gcf,'position',[x1,y1,width,height])
for distanceschanges = 1:length(significantchangesdistances)
    
mTesrBMPlevel = AllAcceptedParameters(significantchangesdistances(distanceschanges)).mTesrBMPlevel;
basalBMPlevel = AllAcceptedParameters(significantchangesdistances(distanceschanges)).basalBMPlevel;
paramBMPfunc = AllAcceptedParameters(significantchangesdistances(distanceschanges)).paramBMPfunc;
parameter = AllAcceptedParameters(significantchangesdistances(distanceschanges)).parammodel;
    
cellstability = Allcellstability{distanceschanges};
Ntrialsall = AllNtrialsall{distanceschanges};
nstablepointsmatrix = Allnstablepointsmatrix{distanceschanges} ;
stability = Allstabilityall{distanceschanges};
    
 BMPvalues = [0:0.05:1.5];
WNTvalues = [0:0.05:1.5];

cellstabilityclean = cell(length(BMPvalues),length(WNTvalues));
nstablepointsmatrixclean = zeros(length(BMPvalues),length(WNTvalues));
Ntrialsallclean = cell(length(BMPvalues),length(WNTvalues));
stabilityclean = cell(length(BMPvalues),length(WNTvalues));

for BMPii = 1:length(BMPvalues)
    BMPvalues(BMPii);
    for WNTii = 1:length(WNTvalues)
        
SMAD40 = BMPvalues(BMPii);
bCat0 = WNTvalues(WNTii);
paramattractors = parameter;
paramattractors(1) = SMAD40;
paramattractors(2) = bCat0;

criticalpoints = cellstability{BMPii,WNTii};
critpointsaux = [];
Ntrialscritpointsaux = [];
stabilitycleanaux = [];

        for ii = 1:size(criticalpoints,2)
            
            root = criticalpoints(:,ii);
            stabilityaux = computestability(root,paramattractors);
            
            if stabilityaux == 1
                            if isempty(critpointsaux)
                                critpointsaux = [critpointsaux,root];
                                Ntrialscritpointsaux =[Ntrialscritpointsaux,Ntrialsall{BMPii,WNTii}(ii)];
                                stabilitycleanaux = [stabilitycleanaux,computestability(root,paramattractors)];
                            else
                                
                                flagexistingcp = 1;
                                ncritpoints = size(critpointsaux,2)+1;
                                counter = 1;
                                while (flagexistingcp)&&(counter<ncritpoints)
                                    dis2critpoint = norm(root-critpointsaux(:,counter),2);
                                    
                                    if dis2critpoint<2*1.0e-2
                                        flagexistingcp=0;
                                    end
                                    counter=counter+1;
                                end
                                
                                if flagexistingcp
                                    critpointsaux = [critpointsaux,root];
                                    Ntrialscritpointsaux =[Ntrialscritpointsaux,Ntrialsall{BMPii,WNTii}(ii)];
                                    stabilitycleanaux = [stabilitycleanaux,computestability(root,paramattractors)];
                                end
                                
                                
                            end
            else
%                 distanceschanges
%                 SMAD40
%                 bCat0
%                 criticalpoints
%                 root
%                 stabilityaux
%                 
%                 pause()
            end
            
        end
        
        [stabilityclean{BMPii,WNTii},indaux] = sort(stabilitycleanaux);
        
           cellstabilityclean{BMPii,WNTii} = critpointsaux(:,indaux);
           Ntrialsallclean{BMPii,WNTii} = Ntrialscritpointsaux(indaux);
           nstablepointsmatrixclean(BMPii,WNTii) = size(critpointsaux,2);
           stabilityclean{BMPii,WNTii} = stabilitycleanaux;
            

            
    end
    
end
Allcellstabilityclean{distanceschanges} = cellstabilityclean;
AllNtrialsallclean{distanceschanges} = Ntrialsallclean;
Allnstablepointsmatrixclean{distanceschanges} =nstablepointsmatrixclean;
Allstabilityallclean{distanceschanges} = stabilityclean;


subplot(1,5,distanceschanges)
distanceschanges
[B,W] = meshgrid(BMPvalues,WNTvalues);
pcolor(B,W,nstablepointsmatrixclean')
% pcolor(nstablepointsmatrixclean')
xlabel('BMP','FontWeight', 'bold')
ylabel('WNT','FontWeight', 'bold')
% colorbar
xlim([0,1.5])
ylim([0,1.2])
% 
cbar = colorbar;
caxis([1,4])
ylabel(cbar,'# stable states');

title(['Distance = ',num2str(AllAcceptedCosts(significantchangesdistances(distanceschanges)))])
set(gca, 'LineWidth', 3);
%     set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Arial')
    set(gca,'FontSize',20)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 
    
end

subplot(1,5,5)

plot(AllAcceptedCosts,'LineWidth',2)
hold on
scatter(significantchangesdistances,AllAcceptedCosts(significantchangesdistances),100,'filled')
xlabel('Accepted parameter number')
ylabel('L$(\theta)$','Interpreter','latex')

set(gca, 'LineWidth', 3);
%     set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Arial')
    set(gca,'FontSize',20)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 
    
    fig = gcf;
fig.Color = colorbg;
fig.InvertHardcopy = 'off';

% 
% saveas(fig,['figures/','PlotEvolutionFatemaps_Paper'],'svg')
% saveas(fig,['figures/','PlotEvolutionFatemaps_Paper'],'fig')
% saveas(fig,['figures/','PlotEvolutionFatemaps_Paper'],'png')


