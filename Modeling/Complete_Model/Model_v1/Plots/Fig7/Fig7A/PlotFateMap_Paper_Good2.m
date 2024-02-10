load('StabilityAnalysis_Real_NON-INTEGERCOEFFITIENTS_v1_SensitivityGood2_Parameters_Method4_findcriticalpointsv4_tF1000')


%% Clean cellstability & only save stable points

BMPvalues = [0:0.005:1.5];
WNTvalues = [0:0.005:1.5];

cellstabilityclean = cell(length(BMPvalues),length(WNTvalues));
nstablepointsmatrixclean = zeros(length(BMPvalues),length(WNTvalues));
Ntrialsallclean = cell(length(BMPvalues),length(WNTvalues));
stabilityclean = cell(length(BMPvalues),length(WNTvalues));

for BMPii = 1:length(BMPvalues)
    BMPvalues(BMPii)
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
            end
            
        end
        
        [stabilityclean{BMPii,WNTii},indaux] = sort(stabilitycleanaux);
        
           cellstabilityclean{BMPii,WNTii} = critpointsaux(:,indaux);
           Ntrialsallclean{BMPii,WNTii} = Ntrialscritpointsaux(indaux);
           nstablepointsmatrixclean(BMPii,WNTii) = size(critpointsaux,2);
           stabilityclean{BMPii,WNTii} = stabilitycleanaux;
            

            
    end
    
end

% eltime = toc

%%


figure
pcolor(nstablepointsmatrixclean')
colorbar

%%
clear max
simplecellstabilityclean = {}
simplenstablepointsmatrixclean = [];

for BMPii = 1:length(BMPvalues)
    BMPvalues(BMPii)
    for WNTii = 1:length(WNTvalues)
        allattractors = cellstabilityclean{BMPii,WNTii};
        cleanattractors = [];
        
        identityattractors = [0 0 0];
        
        for ii = 1:size(allattractors,2)
            
            auxatt = allattractors(:,ii);
            [maxvalue,indaux] = max(auxatt);
            
            if identityattractors(indaux) == 0
                cleanattractors = [cleanattractors,auxatt];
                identityattractors(indaux) = 1;
            end
        end
        simplecellstabilityclean{BMPii,WNTii} = cleanattractors;
        
        simplenstablepointsmatrixclean(BMPii,WNTii) = size(cleanattractors,2);
        
        
    end
end

%%
figure;
set(gcf,'Position',[10 10 800 700])

[B,W] = meshgrid(BMPvalues,WNTvalues);
pcolor(B,W,simplenstablepointsmatrixclean')
% colorbar
xlim([0,1.5])
ylim([0,1.2])

xlabel('SMAD4')
ylabel('bCat')


fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)

% set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')
saveas(fig,['FateMap_NON-IntegerCoeff_Good2'],'fig')
saveas(fig,['FateMap_NON-IntegerCoeff_Good2'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['FateMap_NON-IntegerCoeff_Good2'],'pdf')



