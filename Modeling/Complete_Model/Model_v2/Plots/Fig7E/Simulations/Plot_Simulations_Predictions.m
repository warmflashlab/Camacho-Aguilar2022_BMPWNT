%% BarPlots
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
load('ExpData.mat')
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

IntervalsExp = {[1,163,170,171]};


%%

allmeans = zeros(2,4);
allstd = zeros(2,4);

for ii = 1:2
    
    ordergenes = [1,2];
    for jj = 1:4
        
        allmeans(ordergenes(ii),jj) = mean(AllEndTrajs{jj}(ii,:));
        allstd(ordergenes(ii),jj) = std(AllEndTrajs{jj}(ii,:));
        
    end
    
    
end

%%
alldata = zeros(2,4,1000);

for ii = 1:2
    orderdata = [1,2,4,3];
    
    for jj = 1:4
        
        alldata(ii,jj,:) = AllEndTrajs{orderdata(jj)}(ii,:);
        
    end
    
    
end
  
%% Plot Boxplot simulations


for channelnum = 1:2
data = squeeze(alldata(channelnum,:,:))';
x = 1:4;
colors = [49,77,161;121,195,237;238,230,50;240,78,73]/255;
figure();
set(gcf,'Position',[100 100 700 500])
ax = axes();
hold(ax);
for i=1:4
    boxchart(x(i)*ones(size(data(:,i))), data(:,i), 'BoxFaceColor', colors(i,:),'BoxEdgeColor','k','BoxFaceAlpha',1,'BoxWidth',0.8,'LineWidth',2,'MarkerColor',colors(i,:))
end
xticks([1:4])
% legend({'mTeSR 0-48h','BMP10 0-16, mTeSR 16-48h','CHIR 0-48h','BMP10+IWP2 0-4, CHIR+IWP2 4-48h'});
box on
ylabel(DifferentChannelsPresent{channelnum},'Color','k');
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color','w')
    set(gca,'Color','w')
    set(gca,'XColor','k')
    set(gca,'YColor','k') 

    fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)


saveas(fig,['figures' filesep 'Sim_BoxPlots-BMPCHIR-New-',num2str(channelnum)],'svg')
saveas(fig,['figures' filesep 'Sim_BoxPlots-BMPCHIR-New-',num2str(channelnum)],'fig')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures' filesep 'Sim_BoxPlots-BMPCHIR-New-',num2str(channelnum), '.pdf'],'pdf');


end


%% Plot Barplots Simulations
close all

colourclusters = [colorconvertorRGB([185,82,159]);colorconvertorRGB([249,236,49])];
nCon = 4;
colorfont = 'k';
set(gcf,'Position',[100 100 700 1000])

DifferentChannelsPresent = {'Simulated SOX2','Simulated BRA'}
tiledlayout(2,1,'TileSpacing','compact')
for channelnum = 1:2
    nexttile
barplotfc = bar(1:nCon,allmeans(channelnum,[1,2,4,3]),0.5,'FaceColor',colourclusters(channelnum,:),'EdgeColor',colorfont);
hold on    
errorbar(1:nCon,allmeans(channelnum,[1,2,4,3]),allstd(channelnum,[1,2,4,3])/2,'.','Color',colorfont)
    
colourclusters = [49,77,161;121,195,237;238,230,50;240,78,73]/255;
barplotfc.FaceColor = 'Flat'; 
for ii = 1:4
    
    barplotfc.CData(ii,:) = colourclusters(ii,:);
end
    
    ylabel(DifferentChannelsPresent{channelnum},'Color',colorfont);

    xticks(1:nCon)
    
    
        xticklabels({'mTeSR 0-48h','BMP10 0-16, mTeSR 16-48h','CHIR 0-48h','BMP10+IWP2 0-4, CHIR+IWP2 4-48h'});    

    
%     if channelnum==1
    title('Simulations','Color','k')
%     end
    
%     xtickangle(angleticks)
    
    set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color','w')
    set(gca,'Color','w')
    set(gca,'XColor','k')
    set(gca,'YColor','k')  
    
end



fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
set(findall(gcf,'-property','LineWidth'),'LineWidth',2)
% 
saveas(fig,['figures' filesep 'Sim_BarPlots-BMPCHIR-New'],'svg')
saveas(fig,['figures' filesep 'Sim_BarPlots-BMPCHIR-New'],'fig')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures' filesep 'Sim_BarPlots-BMPCHIR-New', '.pdf'],'pdf');