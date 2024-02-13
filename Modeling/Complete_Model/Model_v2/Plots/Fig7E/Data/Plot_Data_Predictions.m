load('AllDataExperiment_77_2.mat')

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

  

%% Plot Boxplot Data


DifferentChannelsPresent = {'SOX2 Intensity (a.u.)','BRA Intensity (a.u.)'}

conditionsplot = [1,2,8,7];
for channelnum = 1:2
  % subplot(2,1,channelnum)
x = 1:4;
colors = [49,77,161;121,195,237;238,230,50;240,78,73]/255;
figure();
set(gcf,'Position',[100 100 700 500])
ax = axes();
hold(ax);
for i=1:4
    boxchart(x(i)*ones(size(AllDataExperiment{1}{conditionsplot(i)}(:,4+channelnum))), AllDataExperiment{1}{conditionsplot(i)}(:,4+channelnum), 'BoxFaceColor', colors(i,:),'BoxEdgeColor','k','BoxFaceAlpha',1,'BoxWidth',0.8,'LineWidth',2,'MarkerColor',colors(i,:))
end
% xticks([1,2,3,4])
% legend({'mTeSR 0-48h','BMP10 0-16, mTeSR 16-48h','CHIR 0-48h','BMP10+IWP2 0-4, CHIR+IWP2 4-48h'});
box on
ylabel(DifferentChannelsPresent{channelnum},'Color','k');
xticks([1:4])
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


saveas(fig,['figures' filesep 'Data_BoxPlots-BMPCHIR-New-',num2str(channelnum)],'svg')
saveas(fig,['figures' filesep 'Data_BoxPlots-BMPCHIR-New-',num2str(channelnum)],'fig')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures' filesep 'Data_BoxPlots-BMPCHIR-New-',num2str(channelnum), '.pdf'],'pdf');
% close

end

%% Data Bar Plot SOX2

ConditionsSelection=[1,1,1,1;1,2,8,7];
titleplottosave = 'SOX2';
%Optional options
blackBG = 0; %0 if white background, 1 if black background (0 default)
channelnums = [3]; %choose channels in analysisParam.MapChannels.DifferentChannelsPresent, (analysisParam.MapChannels.ChannelsCoordMatrix{ConditionsSelection(1,1),ConditionsSelection(2,1)} default)
stdmean = 1; %1 if plotting std of the mean, 0 if plotting std of data;
angleticks = 0; %angle for xticks in barplots
title = '';
[sidx,ordercolors]=sort(channelnums);
uniformlimits = 1;

options = {'blackbg',blackBG,'channels',channelnums,'stdmean',stdmean,'angleticks',angleticks,'title',title,'uniformlimits',uniformlimits,'ordercolors',ordercolors};

DA_BarPlotsData_FixedData_ConditionsSelection_Exp77(ConditionsSelection,titleplottosave,options)

%% Data Bar Plot BRA

ConditionsSelection=[1,1,1,1;1,2,8,7];
titleplottosave = 'BRA';
%Optional options
blackBG = 0; %0 if white background, 1 if black background (0 default)
channelnums = [4]; %choose channels in analysisParam.MapChannels.DifferentChannelsPresent, (analysisParam.MapChannels.ChannelsCoordMatrix{ConditionsSelection(1,1),ConditionsSelection(2,1)} default)
stdmean = 1; %1 if plotting std of the mean, 0 if plotting std of data;
angleticks = 0; %angle for xticks in barplots
title = '';
[sidx,ordercolors]=sort(channelnums);
uniformlimits = 1;

options = {'blackbg',blackBG,'channels',channelnums,'stdmean',stdmean,'angleticks',angleticks,'title',title,'uniformlimits',uniformlimits,'ordercolors',ordercolors};

DA_BarPlotsData_FixedData_ConditionsSelection_Exp77(ConditionsSelection,titleplottosave,options)