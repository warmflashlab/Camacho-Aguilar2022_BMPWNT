BifSet1 = dlmread('/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/Papers 2/BMPWNT_Elena/Supplemental-Information/Code/SignalingSystem/WNTSystem/StableBifPoints.dat');
BifSet2 = dlmread('/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/Papers 2/BMPWNT_Elena/Supplemental-Information/Code/SignalingSystem/WNTSystem/UnStableBifPoints.dat');
BifSet3 = dlmread('/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/Papers 2/BMPWNT_Elena/Supplemental-Information/Code/SignalingSystem/WNTSystem/StableBifPoints_WNT.dat');
BifSet4 = dlmread('/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/Papers 2/BMPWNT_Elena/Supplemental-Information/Code/SignalingSystem/WNTSystem/UnstableBifPoints_WNT.dat');

StablePointsLow = find(BifSet1(:,2)<0.6);
StablePointsHigh = find(BifSet1(:,2)>0.6);

colorlinebif = 'k';
colorlineuns = 'r';

figDir = ['/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/Papers 2/BMPWNT_Elena/Supplemental-Information/Code/SignalingSystem/figures'];


figure;
set(gcf,'Position',[10 10 2000 700])

tiledlayout(1,3)

nexttile
plot3(BifSet1(StablePointsLow,1),BifSet3(StablePointsLow,2),BifSet1(StablePointsLow,2),'Color',colorlinebif,'LineWidth',2)
hold on
plot3(BifSet1(StablePointsHigh,1),BifSet3(StablePointsHigh,2),BifSet1(StablePointsHigh,2),'Color',colorlinebif,'LineWidth',2)
plot3(BifSet2(:,1),BifSet4(:,2),BifSet2(:,2),'--','Color',colorlineuns,'LineWidth',2)
xlim([-0.5,2])
title('3D bifurcation plot')
grid on


xlabel('SMAD4')
ylabel('WNT')
zlabel('bCat')
set(gca,'linewidth',2)
nexttile
plot(BifSet1(StablePointsLow,1),BifSet3(StablePointsLow,2),'Color',colorlinebif,'LineWidth',2)
hold on
plot(BifSet1(StablePointsHigh,1),BifSet3(StablePointsHigh,2),'Color',colorlinebif,'LineWidth',2)
plot(BifSet2(:,1),BifSet4(:,2),'--','Color',colorlineuns,'LineWidth',2)
title('WNT bifurcation plot')

grid on



xlabel('SMAD4')
ylabel('WNT')
set(gca,'linewidth',2)

nexttile
plot(BifSet1(StablePointsLow,1),BifSet1(StablePointsLow,2),'Color',colorlinebif,'LineWidth',2)
hold on
plot(BifSet1(StablePointsHigh,1),BifSet1(StablePointsHigh,2),'Color',colorlinebif,'LineWidth',2)
plot(BifSet2(:,1),BifSet2(:,2),'--','Color',colorlineuns,'LineWidth',2)
title('bCat bifurcation plot')


grid on


xlabel('SMAD4')
ylabel('bCat')
set(gca,'linewidth',2)




set(gca,'Color','w')
set(gca,'XColor','k')
set(gca,'YColor','k')



fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',30)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

fig = gcf;
    fig.Color = 'w';
    fig.InvertHardcopy = 'off';
saveas(fig,['figures/','PaperBifSet'],'svg')
saveas(fig,['figures/','PaperBifSet'],'fig')
saveas(fig,['figures/','PaperBifSet'],'png')