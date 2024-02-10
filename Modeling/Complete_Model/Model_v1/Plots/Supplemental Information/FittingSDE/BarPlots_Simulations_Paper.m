%% Barplots

load('MCMC_results_TimeCourse_SDE_v3.mat')
ExperimentName = 'MCMC_results_TimeCourse_SDE_v8_ODEControls_v3';
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

NoBMPCondition = 6;
IntervalsExp = {1:8,[1,9:16],[17:24],[1,25:31]};

% ClassificationLabels = {'AllLow','S+','SB+','B+','BC+','C+','CS+','SBC+'};
ClassificationLabels = {'AllLow','S+','B+','C+','Mix'};
nLabels = length(ClassificationLabels);

for intplot = 1:length(IntervalsExp)

figure('Position',[0 0 2000 700]);
% BlackColor = [0,0,0];
% RedColor = [207,20,43]/255;
% YellowColor = [254,221,0]/255;
% CyanColor = [0 163 224]/255;
% OrangeColor = (RedColor+YellowColor)/2;
% GreenColor = (CyanColor+YellowColor)/2;
% PurpleColor = (RedColor+CyanColor)/2;
% GrayColor = [200 200 200]/255;
GrayColorText = [1 1 1]/255;

RedColor = [185,82,159]/255;
YellowColor = [248,235,48]/255;
CyanColor = [68 192 198]/255;
OrangeColor = (RedColor+YellowColor)/2;
GreenColor = (CyanColor+YellowColor)/2;
PurpleColor = (RedColor+CyanColor)/2;
GrayColor = [200 200 200]/255;
% MatrixColors = [BlackColor;RedColor;OrangeColor; YellowColor;GreenColor;CyanColor;PurpleColor;GrayColor];


MatrixColors = [BlackColor;RedColor; YellowColor;CyanColor;GrayColor];
MatrixColorsText = [GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText;GrayColorText];


AllMatProp = reshape([structtopass.ExpDataStruct(IntervalsExp{intplot}).MatrixProp],8,length(IntervalsExp{intplot}))';
PropCellspercondition = [round(AllMatProp,2)];
PropCellspercondition = [PropCellspercondition(:,[1,2,4,6]),PropCellspercondition(:,3)+PropCellspercondition(:,5)+PropCellspercondition(:,7)+PropCellspercondition(:,8)];

conNamesPlot = [ExpDataStruct(IntervalsExp{intplot}).ConditionsNames];
x=categorical(conNamesPlot);
x = reordercats(x,conNamesPlot(1:length(IntervalsExp{intplot})));

tiledlayout(1,2)
nexttile
H = bar(x,PropCellspercondition,'stacked');



 
if plotlegend
[~, hobj, ~, ~] =legend(ClassificationLabels,'Location','eastoutside','FontSize',18,'FontName','Arial','LineWidth',2,'TextColor',lineandtextcolor,'Color',bgcolor,'EdgeColor',lineandtextcolor);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',2,'Color',lineandtextcolor);

ht = findobj(hobj,'type','text');
set(ht,'FontSize',18,'FontName','Arial','FontWeight','bold','Color',lineandtextcolor);
end


title('Data','Color',lineandtextcolor);
ylabel('% of cells','Color',lineandtextcolor);
ylim([0,100])
% xticks('')




set(gca,'Color',bgcolor)
set(gca,'XColor',lineandtextcolor)
set(gca,'YColor',lineandtextcolor)



fig = gcf;
fig.Color = bgcolor;
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',25)
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
            
            if heightH(jj)>3
            
                if size(PropCellspercondition,1)>2
                    if round(heightH(jj),2)==100
                        starttext = 0.7;
                    else
                        starttext = 0.8;
                    end
                    text((jj-1)+starttext,heightH(jj)/2,num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
                else
                    if round(heightH(jj),2)==100
                        starttext = 0.7;
                    else
                        starttext = 0.8;
                    end
                text((jj-1)+starttext,heightH(jj)/2,num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
            
                end
            end
        else
            
            if heightH(jj)>3
            
                if size(PropCellspercondition,1)>2
                    if round(heightH(jj),2)==100
                        starttext = 0.7;
                    else
                        starttext = 0.8;
                    end
            text((jj-1)+starttext,(heightH(jj)/2)+heightsofar(jj),num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
                else
                    if round(heightH(jj),2)==100
                        starttext = 0.7;
                    else
                        starttext = 0.8;
                    end
            text((jj-1)+starttext,(heightH(jj)/2)+heightsofar(jj),num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
            
                end
            end
            
        end
        
        
        
    end
    heightsofar = heightsofar + heightH;
    

end

nexttile

PropCellspercondition = [round(100*AllAcceptedSimulatedTrajs(IntervalsExp{intplot},:)/nsimulations,2)];
PropCellspercondition = [PropCellspercondition(:,[1,2,4,6]),PropCellspercondition(:,3)+PropCellspercondition(:,5)+PropCellspercondition(:,7)+PropCellspercondition(:,8)];


H = bar(x,PropCellspercondition,'stacked');



 
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
set(findall(fig,'-property','FontSize'),'FontSize',25)
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
            
            if heightH(jj)>3
            
                if size(PropCellspercondition,1)>2
                    if round(heightH(jj),2)==100
                        starttext = 0.7;
                    else
                        starttext = 0.8;
                    end
                    text((jj-1)+starttext,heightH(jj)/2,num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
                else
                    if round(heightH(jj),2)==100
                        starttext = 0.7;
                    else
                        starttext = 0.8;
                    end
                text((jj-1)+starttext,heightH(jj)/2,num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
            
                end
            end
        else
            
            if heightH(jj)>3
            
                if size(PropCellspercondition,1)>2
                    if round(heightH(jj),2)==100
                        starttext = 0.7;
                    else
                        starttext = 0.8;
                    end
            text((jj-1)+starttext,(heightH(jj)/2)+heightsofar(jj),num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
                else
                    if round(heightH(jj),2)==100
                        starttext = 0.7;
                    else
                        starttext = 0.8;
                    end
            text((jj-1)+starttext,(heightH(jj)/2)+heightsofar(jj),num2str(round(heightH(jj),1)),'FontName',FontNameChoice,'FontSize',18,'FontWeight','normal','Color',MatrixColorsText(ii,:));
            
                end
            end
            
        end
        
        
        
    end
    heightsofar = heightsofar + heightH;
    

end
set(findall(fig,'-property','FontSize'),'FontSize',20)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(fig,'-property','FontName'),'FontName','Myriad Pro')

saveas(fig,['figures' filesep colornameplot '-' ExperimentName '-PaperBarPlotCellClassification-',num2str(intplot)],'fig')
saveas(fig,['figures' filesep colornameplot '-' ExperimentName '-PaperBarPlotCellClassification-',num2str(intplot)],'svg')
saveas(fig,['figures' filesep colornameplot '-' ExperimentName '-PaperBarPlotCellClassification-',num2str(intplot)],'png')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures' filesep colornameplot '-' ExperimentName '-BarPlotCellClassification-',num2str(intplot)],'pdf')
    
array2table(PropCellspercondition,'VariableNames',ClassificationLabels,'RowNames',[ExpDataStruct(IntervalsExp{intplot}).ConditionsNames])
   
close

end