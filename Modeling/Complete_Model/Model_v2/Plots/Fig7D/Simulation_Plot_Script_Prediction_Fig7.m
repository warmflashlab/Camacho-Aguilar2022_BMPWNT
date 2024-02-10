 
    
%% Load and plot simulations
    clear
namefile = 'Predictions_from_MCMC_results_TimeCourse_ODE_v1_CHIR_Fig7_New';
    load([namefile,'.mat'])
    

BMPWNTtitles = {''};
    
    for ii = 1:size(AllSolTrajs,1)
        figure
        x1=10;
y1=10;

width=1100;
height=1100;
set(gcf,'position',[x1,y1,width,height])


colorsplotscatter = [49,77,161;121,195,237;240,78,73;238,230,50]/255;
        for jj = [1,2,3,4]
            
            conditiontosimulateidx=jj;
            
            soltraj = AllSolTrajs{ii,jj};
            ttraj = AllTTrajs{ii,jj};
            
            colorbg = 'w';
lineandtextcolor = 'k';

c=ismember(ttraj/1.5,[0:0.1:72]);
tpointsplot = find(c);
ttrajplot = ttraj(tpointsplot)/1.5;

c2=ismember(ttraj/1.5,[0:0.1:72]);
tpointsplot2 = find(c2);
ttrajplot2 = ttraj(tpointsplot2)/1.5;

subplot(2,2,1)
plot(ttrajplot2,squeeze(soltraj(2,tpointsplot2)),'LineWidth',3,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot2(1),ttrajplot2(end)])
ylim([0,1.5])
hold on
title('SMAD4','Color',lineandtextcolor)
set(gca, 'LineWidth', 3);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',25)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 
    
xlim([0,48])

subplot(2,2,2)
plot(ttrajplot2,squeeze(soltraj(5,tpointsplot2)),'LineWidth',3,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot2(1),ttrajplot2(end)])
ylim([0,1.5])
hold on
title('bCat','Color',lineandtextcolor)
set(gca, 'LineWidth', 3);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',25)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 
    
xlim([0,48])

subplot(2,2,3)
plot(ttrajplot,squeeze(soltraj(6,tpointsplot)),'LineWidth',3,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot(1),ttrajplot(end)])
ylim([0,1.5])
hold on
title('SOX2','Color',lineandtextcolor)
set(gca, 'LineWidth', 3);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',25)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 
    
xlim([0,48])

subplot(2,2,4)
plot(ttrajplot,squeeze(soltraj(7,tpointsplot)),'LineWidth',3,'Color',colorsplotscatter(conditiontosimulateidx,:))
xlim([ttrajplot(1),ttrajplot(end)])
hold on
title('BRA','Color',lineandtextcolor)
set(gca, 'LineWidth', 3);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',25)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 


xlim([0,48])
ylim([-0.5,3.5])

set(gca, 'LineWidth', 3);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',25)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 
            
            
            
            
            
        end
        legend({'mTeSR','BMP 0-16h, mTeSR 16-48h','BMP+IWP2 0-4h, CHIR+IWP2 4-48h','CHIR 0-48h'},'Location','northwest')
%          legend({AllLegends([1,2,3,4])},'Location','northwest')
fig = gcf;
fig.Color = colorbg;
fig.InvertHardcopy = 'off';
saveas(fig,['figures/','PlotTrajectoriesPresNew_',namefile,'_',BMPWNTtitles{ii}],'svg')
saveas(fig,['figures/','PlotTrajectoriesPresNew_',namefile,'_',BMPWNTtitles{ii}],'fig')
saveas(fig,['figures/','PlotTrajectoriesPresNew_',namefile,'_',BMPWNTtitles{ii}],'png')

        
        
    end

    
    
    %%
    
    
    