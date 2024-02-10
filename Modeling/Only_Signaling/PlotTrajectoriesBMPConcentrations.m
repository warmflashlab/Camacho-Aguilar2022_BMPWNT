%% Load parameters and bifurcation plots signals
clear
addpath('Core Functions Model')

BifSet1 = dlmread('WNTSystem/StableBifPoints.dat');
BifSet2 = dlmread('WNTSystem/UnStableBifPoints.dat');
BifSet3 = dlmread('WNTSystem/StableBifPoints_WNT.dat');
BifSet4 = dlmread('WNTSystem/UnstableBifPoints_WNT.dat');


load('MCMC_results_TimeCourse_ODE_v1.mat')

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

orderConditions = [1,8,2,7,3,6,4,5];
    
conNames =  {'BMP 0-8h';'BMP 0-16h';'BMP 0-32h';'BMP 0-48h';'mTeSR+RI+P/S';'BMP 0-32h,Noggin 32-48h';'BMP 0-16h,Noggin 16-48h ';'BMP 0-8h,Noggin 8-48h'};

figDir = ['figures'];



colors = [185,83,159;194,110,153;202,134,146;212,158,135;222,183,119;234,208,94;247,235,47;211,223,105;172,212,141;129,202,170;70,193,198]/255;

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
