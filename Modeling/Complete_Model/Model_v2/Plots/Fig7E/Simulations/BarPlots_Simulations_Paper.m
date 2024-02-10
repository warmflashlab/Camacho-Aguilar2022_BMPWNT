%% Barplots
%%
load('MCMC_results_TimeCourse_SDE_ODEControls_v3_AllSimulations.mat')

RedColor = [185,82,159]/255;
YellowColor = [248,235,48]/255;
CyanColor = [68 192 198]/255;
OrangeColor = (RedColor+YellowColor)/2;
GreenColor = (CyanColor+YellowColor)/2;
PurpleColor = (RedColor+CyanColor)/2;
GrayColor = [200 200 200]/255;
BlackColor = [0 0 0];
GrayColorText = [50 50 50]/255;

MatrixColors = [BlackColor;RedColor; YellowColor;CyanColor;GrayColor];
MatrixColorsText = [GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText];

%%
 parameters.parammodel(20) = 0.8;

conditiontosimulate = 1;
[soltrajall,ttrajall,attractorsall,fatesvector,propsfates] = functionplotscatter_SDE_fit_plot_v9(conditiontosimulate,parameters,structtopass,nsimulations,AllAcceptedNoises(end),AllAcceptedExpVar(end)*expcov,[AllAcceptedInitCond(end),0,0]);

AllEndTrajs{1} = squeeze(soltrajall(6:8,:,end));


conditiontosimulate = 163;
[soltrajall,ttrajall,attractorsall,fatesvector,propsfates] = functionplotscatter_SDE_fit_plot_v9(conditiontosimulate,parameters,structtopass,nsimulations,AllAcceptedNoises(end),AllAcceptedExpVar(end)*expcov,[AllAcceptedInitCond(end),0,0]);

AllEndTrajs{2} = squeeze(soltrajall(6:8,:,end));

ExpDataStruct(170).MatrixProp = zeros(1,8);
ExpDataStruct(170).Signals = [0 1 2;...%BMP
                              0 0 0;...%Noggin in the media
                              1 1 1;...%IWP2 in the media
                              0 2 2];  %Exogenous WNT in the media
ExpDataStruct(170).TimeFixedaux = 48;
ExpDataStruct(170).BMPlevelraw = 10;
ExpDataStruct(170).tCH1raw = 4;
ExpDataStruct(170).tCH2raw = 24;
ExpDataStruct(170).ConditionsNames = {'@48h, B+I 0-4, C+I 4-48'};
ExpDataStruct(170).MatrixData= [];
ExpDataStruct(170).MatrixStdMean = [];
ExpDataStruct(170).MatrixSimpData = [];
conditiontosimulate = 170;
structtopass = struct('ExpDataStruct',ExpDataStruct,'AllMatProp',AllMatProp,'nExp',nExp,'parfitnumbers',parfitnumbers,'parameters',parametersim,'initcond',initcond);

for ii = 1:length(ExpDataStruct)
ExpDataStruct(ii).MatrixData = ExpDataStruct(ii).MatrixSimpData;

end

[soltrajall,ttrajall,attractorsall,fatesvector,propsfates] = functionplotscatter_SDE_fit_plot_v9(conditiontosimulate,parameters,structtopass,nsimulations,AllAcceptedNoises(end),AllAcceptedExpVar(end)*expcov,[AllAcceptedInitCond(end),0,0]);

ttraj = ttrajall;
soltraj = soltrajall;
attractors = attractorsall;

AllAcceptedSimulatedTrajs(170,:) = propsfates;

AllEndTrajs{3} = squeeze(soltrajall(6:8,:,end));

IntervalsExp = {[8,170]};


ExpDataStruct(171).MatrixProp = zeros(1,8);
ExpDataStruct(171).Signals = [0,0,0;... %BMP in the media
                                0,0,0;...   %Noggin in the media
                                0,0,0;...   %IWP2 in the media
                                2,2,2];     %Exogenous WNT in the media
ExpDataStruct(171).TimeFixedaux = 48;
ExpDataStruct(171).BMPlevelraw = 0;
ExpDataStruct(171).tCH1raw = 24;
ExpDataStruct(171).tCH2raw = 48;
ExpDataStruct(171).ConditionsNames = {'@48h, CHIR 0-48'};
ExpDataStruct(171).MatrixData= [];
ExpDataStruct(171).MatrixStdMean = [];
ExpDataStruct(171).MatrixSimpData = [];
conditiontosimulate = 171;
structtopass = struct('ExpDataStruct',ExpDataStruct,'AllMatProp',AllMatProp,'nExp',nExp,'parfitnumbers',parfitnumbers,'parameters',parametersim,'initcond',initcond);

for ii = 1:length(ExpDataStruct)
ExpDataStruct(ii).MatrixData = ExpDataStruct(ii).MatrixSimpData;

end

[soltrajall,ttrajall,attractorsall,fatesvector,propsfates] = functionplotscatter_SDE_fit_plot_v9(conditiontosimulate,parameters,structtopass,nsimulations,AllAcceptedNoises(end),AllAcceptedExpVar(end)*expcov,[AllAcceptedInitCond(end),0,0]);

AllEndTrajs{4} = squeeze(soltrajall(6:8,:,end));
ttraj = ttrajall;
soltraj = soltrajall;
attractors = attractorsall;

AllAcceptedSimulatedTrajs(171,:) = propsfates;

IntervalsExp = {[1,171,170]};

%%

ExperimentName = 'MCMC_results_TimeCourse_SDE_ODEControls_v3_Predictions';
blackbackground=0;
plotlegend=0;

if blackbackground
    lineandtextcolor = 'w';
    bgcolor = 'k';
    colornameplot = 'Black';
    BlackColor = [1,1,1];
    
else
    
    lineandtextcolor = 'k';
    bgcolor = 'w';
    colornameplot = 'White';
    BlackColor = [0,0,0];
    
end

FontNameChoice = 'Arial';
% Plot bar



ClassificationLabels = {'AllLow','S+','B+','C+','Mix'};
nLabels = length(ClassificationLabels);

for intplot = 1:length(IntervalsExp)

figure('Position',[0 0 1000 200]);

GrayColorText = [1 1 1]/255;

RedColor = [185,82,159]/255;
YellowColor = [248,235,48]/255;
CyanColor = [68 192 198]/255;
OrangeColor = (RedColor+YellowColor)/2;
GreenColor = (CyanColor+YellowColor)/2;
PurpleColor = (RedColor+CyanColor)/2;
GrayColor = [200 200 200]/255;


MatrixColors = [BlackColor;RedColor; YellowColor;CyanColor;GrayColor];
MatrixColorsText = [GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText];


heightpar = 10;

conNamesPlot = [ExpDataStruct(IntervalsExp{intplot}).ConditionsNames];
x=categorical(conNamesPlot);
x = reordercats(x,conNamesPlot(1:length(IntervalsExp{intplot})));

PropCellspercondition = [round(100*AllAcceptedSimulatedTrajs(IntervalsExp{intplot},:)/nsimulations,2)];
PropCellspercondition = [PropCellspercondition(:,[1,2,4,6]),PropCellspercondition(:,3)+PropCellspercondition(:,5)+PropCellspercondition(:,7)+PropCellspercondition(:,8)];



H = bar(x,PropCellspercondition,0.4,'stacked');



 
if plotlegend
[~, hobj, ~, ~] =legend(ClassificationLabels,'Location','eastoutside','FontSize',18,'FontName','Arial','LineWidth',2,'TextColor',lineandtextcolor,'Color',bgcolor,'EdgeColor',lineandtextcolor);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',2,'Color',lineandtextcolor);

ht = findobj(hobj,'type','text');
set(ht,'FontSize',18,'FontName','Arial','FontWeight','bold','Color',lineandtextcolor);
end


title('Simulations','Color',lineandtextcolor);
ylabel('% of cells','Color',lineandtextcolor);
ylim([0,100])




set(gca,'Color',bgcolor)
set(gca,'XColor',lineandtextcolor)
set(gca,'YColor',lineandtextcolor)



fig = gcf;
fig.Color = bgcolor;
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
set(findall(fig,'-property','FontName'),'FontName','Arial')
heightsofar = zeros(1,size(PropCellspercondition,1));

for ii = 1:nLabels
    H(ii).FaceColor = 'flat';
    H(ii).CData = MatrixColors(ii,:);
    H(ii).LineWidth = 1;
    H(ii).EdgeColor = lineandtextcolor;%bgcolor;%lineandtextcolor;
    
    heightH = H(ii).YData;
    

    
    for jj=1:size(PropCellspercondition,1)

        if ii==1
            
            if heightH(jj)>heightpar
            
                if size(PropCellspercondition,1)>2
                    if round(heightH(jj),2)==100
                        starttext = 0.85;
                    else
                        starttext = 0.85;
                    end
                    text((jj-1)+starttext,heightH(jj)/2,num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
                else
                    if round(heightH(jj),2)==100
                        starttext = 0.85;
                    else
                        starttext = 0.85;
                    end
                text((jj-1)+starttext,heightH(jj)/2,num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
            
                end
            end
        else
            
            if heightH(jj)>heightpar
            
                if size(PropCellspercondition,1)>2
                    if round(heightH(jj),2)==100
                        starttext = 0.85;
                    else
                        starttext = 0.85;
                    end
            text((jj-1)+starttext,(heightH(jj)/2)+heightsofar(jj),num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
                else
                    if round(heightH(jj),2)==100
                        starttext = 0.85;
                    else
                        starttext = 0.85;
                    end
            text((jj-1)+starttext,(heightH(jj)/2)+heightsofar(jj),num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
            
                end
            end
            
        end
        
        
        
    end
    heightsofar = heightsofar + heightH;
    

end
xticklabels([])

set(findall(fig,'-property','FontSize'),'FontSize',18)

set(findall(fig,'-property','FontName'),'FontName','Arial')

saveas(fig,['figures' filesep colornameplot '-' ExperimentName '-PaperBarPlotCellClassification-',num2str(intplot)],'fig')
saveas(fig,['figures' filesep colornameplot '-' ExperimentName '-PaperBarPlotCellClassification-',num2str(intplot)],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures' filesep colornameplot '-' ExperimentName '-BarPlotCellClassification-',num2str(intplot)],'pdf')
    
array2table(PropCellspercondition,'VariableNames',ClassificationLabels,'RowNames',[ExpDataStruct(IntervalsExp{intplot}).ConditionsNames])
   


end