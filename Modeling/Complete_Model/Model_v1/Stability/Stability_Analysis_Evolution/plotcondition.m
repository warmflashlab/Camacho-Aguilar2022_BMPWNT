function plotcondition(conditiontosimulate,parameter,structtopass)

lineandtextcolor = 'k';
colorbg = 'w';

colorsplotscatter = distinguishable_colors(1,{'w','k'});

ExpDataStruct = structtopass.ExpDataStruct;
[soltraj,ttraj,attractors] = functiontofit_ODE_plot(64,parameter,structtopass);
squeeze(soltraj(:,end))
DataMat = ExpDataStruct(conditiontosimulate).MatrixData;


c=ismember(ttraj/1.5,[0:1:ExpDataStruct(conditiontosimulate).TimeFixedaux]);
tpointsplot = find(c);
ttrajplot = ttraj(tpointsplot)/1.5;

c2=ismember(ttraj/1.5,[0:1:ExpDataStruct(conditiontosimulate).TimeFixedaux]);
tpointsplot2 = find(c2);
ttrajplot2 = ttraj(tpointsplot2)/1.5;

subplot(2,3,1)
plot(ttrajplot2,squeeze(soltraj(2,tpointsplot2)),'LineWidth',2,'Color',colorsplotscatter(1,:))
xlim([ttrajplot2(1),ttrajplot2(end)])
ylim([0,1.5])
hold on
title('SMAD4','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

subplot(2,3,2)
plot(ttrajplot2,squeeze(soltraj(4,tpointsplot2)),'LineWidth',2,'Color',colorsplotscatter(1,:))
xlim([ttrajplot2(1),ttrajplot2(end)])
ylim([0,2.5])
hold on
title('WNTP','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

subplot(2,3,3)
plot(ttrajplot2,squeeze(soltraj(5,tpointsplot2)),'LineWidth',2,'Color',colorsplotscatter(1,:))
xlim([ttrajplot2(1),ttrajplot2(end)])
ylim([0,1.5])
hold on
title('bCat','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

subplot(2,3,4)
plot(ttrajplot,squeeze(soltraj(6,tpointsplot)),'LineWidth',2,'Color',colorsplotscatter(1,:))
xlim([ttrajplot(1),ttrajplot(end)])
% ylim([0,attractors(1,1)])
hold on
scatter(ExpDataStruct(conditiontosimulate).TimeFixedaux,DataMat(1),60,'MarkerFaceColor',colorsplotscatter(1,:),'MarkerEdgeColor',colorsplotscatter(1,:))
title('SOX2','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

subplot(2,3,5)
plot(ttrajplot,squeeze(soltraj(7,tpointsplot)),'LineWidth',2,'Color',colorsplotscatter(1,:))
xlim([ttrajplot(1),ttrajplot(end)])
% ylim([0,attractors(2,2)])
ylim([0,1])
hold on
scatter(ExpDataStruct(conditiontosimulate).TimeFixedaux,DataMat(2),60,'MarkerFaceColor',colorsplotscatter(1,:),'MarkerEdgeColor',colorsplotscatter(1,:))
title('BRA','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 

subplot(2,3,6)
plot(ttrajplot,squeeze(soltraj(8,tpointsplot)),'LineWidth',2,'Color',colorsplotscatter(1,:))
xlim([ttrajplot(1),ttrajplot(end)])
ylim([0,1])
hold on
scatter(ExpDataStruct(conditiontosimulate).TimeFixedaux,DataMat(3),60,'MarkerFaceColor',colorsplotscatter(1,:),'MarkerEdgeColor',colorsplotscatter(1,:),'HandleVisibility','off')
title('CDX2','Color',lineandtextcolor)
set(gca, 'LineWidth', 2);
    set(gca,'FontWeight', 'bold')
    set(gca,'FontName','Myriad Pro')
    set(gca,'FontSize',18)
    set(gca,'Color',colorbg)
    set(gca,'Color',colorbg)
    set(gca,'XColor',lineandtextcolor)
    set(gca,'YColor',lineandtextcolor) 
    
    distance = sum((DataMat(3)-soltraj(6:8,end)).^2)