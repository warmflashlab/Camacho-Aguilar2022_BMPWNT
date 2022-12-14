%% Load parameters and bifurcation plots signals
clear
addpath('/Users/elenacamachoaguilar/Dropbox (Personal)/Rice/Experiments/Modelling/BMP_CommitmentTime/GRN_Model_v7_SMAD4Decay_BistableWNT')

BifSet1 = dlmread('/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/Papers 2/BMPWNT_Elena/Supplemental-Information/Code/SignalingSystem/WNTSystem/StableBifPoints.dat');
BifSet2 = dlmread('/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/Papers 2/BMPWNT_Elena/Supplemental-Information/Code/SignalingSystem/WNTSystem/UnStableBifPoints.dat');
BifSet3 = dlmread('/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/Papers 2/BMPWNT_Elena/Supplemental-Information/Code/SignalingSystem/WNTSystem/StableBifPoints_WNT.dat');
BifSet4 = dlmread('/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/Papers 2/BMPWNT_Elena/Supplemental-Information/Code/SignalingSystem/WNTSystem/UnstableBifPoints_WNT.dat');


load('/Users/elenacamachoaguilar/Dropbox (Personal)/Rice/Experiments/Modelling/BMP_CommitmentTime/GRN_Model_v8_SMAD4Decay_BistableWNT_NonlinearbCatBRA_FateMarkers/ODE_Fitting_Controls/MCMC_results_TimeCourse_ODE_v1.mat')

initcond = structtopass.initcond;
parametersim = AllAcceptedParameters(length(AllAcceptedCosts));
paux=parametersim.parammodel;
paux([6,7,10,13,14,17,26,29,31,36,37,45,48]) = 1.5*paux([6,7,10,13,14,17,26,29,31,36,37,45,48]); %Change to s=t/1.5
parametersim.parammodel = paux;

StablePointsLow = find(BifSet1(:,2)<0.6);
StablePointsHigh = find(BifSet1(:,2)>0.6);

colorlinebif = 'k';
colorlineuns = 'r';
FontSizeMP = 25;



figure;
set(gcf,'Position',[10 10 2000 1500])

FontNameUse = 'Myriad Pro';
% analysisParam.orderConditions = [1,8,2,7,3,6,4,5]%[4,2,7,1,8];%[8,1,7,2,4]%[5,1,2,3,4,8,7,6];
%     
% % {'BMP 0-8h';'BMP 0-16h';'BMP 0-32h';'BMP 0-48h';'mTeSR+RI+P/S';'BMP 0-32h,Noggin 32-48h';'BMP 0-16h,Noggin 16-48h ';'BMP 0-8h,Noggin 8-48h'};

orderConditions = [1,8,2,7,3,6,4,5];%[4,6,7,8];%[4,2,7,1,8];%[8,1,7,2,4]%[5,1,2,3,4,8,7,6];
    
conNames =  {'BMP 0-8h';'BMP 0-16h';'BMP 0-32h';'BMP 0-48h';'mTeSR+RI+P/S';'BMP 0-32h,Noggin 32-48h';'BMP 0-16h,Noggin 16-48h ';'BMP 0-8h,Noggin 8-48h'};

figDir = ['/Users/elenacamachoaguilar/Library/CloudStorage/Box-Box/WarmflashLab/Papers 2/BMPWNT_Elena/Supplemental-Information/Code/SignalingSystem/figures'];


% colors = [49,77,161;121,195,237;240,78,73;239,174,30;238,230,50]/255;
% colors = [185,83,159;194,110,153;202,134,146;212,158,135;222,183,119;234,208,94;247,235,47;211,223,105;172,212,141;129,202,170;70,193,198]/255;
% colors = [colors([11,7,5,3,1],:);0.5,0.5,0.5];
% colors = [colors([11,7,5,3,1],:);193/255,39/255,160/255];
% colors([3,5,6],:) = 0;
% colors = [colors([11,7,5,3,1],:)];
% colors = [colors([11,7,5,3,1],:);193/255,39/255,160/255];
% colors = [185,83,159;194,110,153;202,134,146;212,158,135;222,183,119;234,208,94;247,235,47;211,223,105;172,212,141;129,202,170;70,193,198]/255;
% colors = flip([colors([11,9,7,4,2],:)],1);
% colors = distinguishable_colors(length(orderConditions),{'w','k'});
colors = [185,83,159;194,110,153;202,134,146;212,158,135;222,183,119;234,208,94;247,235,47;211,223,105;172,212,141;129,202,170;70,193,198]/255;
% plot(tplot,yplot(2,:),'Color',colors(iContoPlot,:),'LineWidth',5);
colors =flip([colors([11,9,7,4,2],:);193/255,39/255,160/255],1);

%% Plot BMP 8h, Noggin 8-48h in bif set
iContoPlot = 8;
[tplot,yplot] = loadconditionSignals_v8(iContoPlot,parametersim,Istar,initcond);
colorplot = colors(2,:);

tiledlayout(5,3)
nexttile

plot(tplot,yplot(1,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('BMP')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
title('BMP4 ligand dynamics')

nexttile

plot(tplot,yplot(3,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('BMPR')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
title('BMPR dynamics')

nexttile

plot(tplot,yplot(2,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('SMAD4')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
title('SMAD4 dynamics')



set(gca,'Color','w')
set(gca,'XColor','k')
set(gca,'YColor','k')



fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',FontSizeMP)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

%% Plot BMP 16h, Noggin 16-48h in bif set
iContoPlot = 7;
[tplot,yplot] = loadconditionSignals_v8(iContoPlot,parametersim,Istar,initcond);
colorplot = colors(3,:);
% tiledlayout(4,4)
nexttile

plot(tplot,yplot(1,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('BMP')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
% title('BMP4 ligand dynamics')

nexttile

plot(tplot,yplot(3,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('BMPR')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
% title('BMPR dynamics')

nexttile

plot(tplot,yplot(2,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('SMAD4')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
% title('SMAD4 dynamics')



set(gca,'Color','w')
set(gca,'XColor','k')
set(gca,'YColor','k')



fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',FontSizeMP)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')


%% Plot BMP 16h, mTeSR 16-48h in bif set
iContoPlot = 2;
[tplot,yplot] = loadconditionSignals_v8(iContoPlot,parametersim,Istar,initcond);
colorplot = colors(4,:);
% tiledlayout(4,4)
nexttile

plot(tplot,yplot(1,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('BMP')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
% title('BMP4 ligand dynamics')

nexttile

plot(tplot,yplot(3,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('BMPR')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
% title('BMPR dynamics')

nexttile

plot(tplot,yplot(2,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('SMAD4')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
% title('SMAD4 dynamics')



set(gca,'Color','w')
set(gca,'XColor','k')
set(gca,'YColor','k')



fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',FontSizeMP)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

%% Plot BMP 32h, Noggin 32-48h in bif set
iContoPlot = 6;
[tplot,yplot] = loadconditionSignals_v8(iContoPlot,parametersim,Istar,initcond);
colorplot = colors(5,:);
% tiledlayout(4,4)
nexttile

plot(tplot,yplot(1,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('BMP')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
% title('BMP4 ligand dynamics')

nexttile

plot(tplot,yplot(3,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('BMPR')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
% title('BMPR dynamics')

nexttile

plot(tplot,yplot(2,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('SMAD4')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
% title('SMAD4 dynamics')



set(gca,'Color','w')
set(gca,'XColor','k')
set(gca,'YColor','k')



fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',FontSizeMP)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')


%% Plot BMP 0-48h
iContoPlot = 4;
[tplot,yplot] = loadconditionSignals_v8(iContoPlot,parametersim,Istar,initcond);
colorplot = colors(6,:);
% tiledlayout(4,4)
nexttile

plot(tplot,yplot(1,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('BMP')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
% title('BMP4 ligand dynamics')

nexttile

plot(tplot,yplot(3,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('BMPR')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
% title('BMPR dynamics')

nexttile

plot(tplot,yplot(2,:),'Color',colorplot,'LineWidth',4)
xlabel('time after BMP treatment')
ylabel('SMAD4')
set(gca,'linewidth',2)
xlim([0,48])
xticks([0,10,20,30,40])
grid on
% title('SMAD4 dynamics')



set(gca,'Color','w')
set(gca,'XColor','k')
set(gca,'YColor','k')



fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',FontSizeMP)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',2)

set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

fig = gcf;
    fig.Color = 'w';
    fig.InvertHardcopy = 'off';
saveas(fig,['figures/','PaperConditionsTrajectoriesBMP'],'svg')
saveas(fig,['figures/','PaperConditionsTrajectoriesBMP'],'fig')
saveas(fig,['figures/','PaperConditionsTrajectoriesBMP'],'png')
