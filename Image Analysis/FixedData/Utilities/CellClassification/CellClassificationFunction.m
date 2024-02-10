
function CellClassificationFunction
%Load dataset
% clear


AnalysisParamScript_v2
global analysisParam

CellClassifParamScript
global CellClassifParam

load([CellClassifParam.data_direc_OUT filesep 'singleCells.mat'])

%% Get the negative populations
% For each gene, we choose the samples that would have the lowest values
% for that gene (negative samples).

NegativePop = {}; %It is already ordered in the correct order (SOX2,BRA,CDX2)
meanNegativePop = [];

for ii = 1:CellClassifParam.nChannels
    
    NegativePop{ii} = singleCells{CellClassifParam.NegativePopConditions{ii}(1)}{CellClassifParam.NegativePopConditions{ii}(2)}(:,CellClassifParam.startGeneData+ii);
    meanNegativePop(ii) = quantile(NegativePop{ii},0.95);%mean(NegativePop{ii});
end 



%% Save all data into a matrix for clustering
% Here we choose either all data or the positive samples for 

AllDataMatrixGenes = [];

for SubExpNum = 1
    for conditionnumber = 1%:analysisParam(SubExpNum).nCon
    
        AllDataMatrixGenes = [ AllDataMatrixGenes; singleCells{SubExpNum}{conditionnumber}(:,CellClassifParam.startGeneData+(1:analysisParam(SubExpNum).nChannels))];
    
    end
end

% for SubExpNum = 2%1:CellClassifParam.NumofSubexperiments
%     for conditionnumber = [4,8]%1:analysisParam(SubExpNum).nCon
for SubExpNum = 1:CellClassifParam.NumofSubexperiments
    for conditionnumber = 1:analysisParam(SubExpNum).nCon
    
        AllDataMatrixGenes = [ AllDataMatrixGenes; singleCells{SubExpNum}{conditionnumber}(:,CellClassifParam.startGeneData+(1:analysisParam(SubExpNum).nChannels))];
    
    end
end

minvalues = quantile(AllDataMatrixGenes,0.005);
maxvalues = quantile(AllDataMatrixGenes,0.995);


%% Plot Negative Populations

% figure('Position',[0 0 1200 800])
% 
% for ii = 1:analysisParam.nChannels
%     
%     subplot(1,analysisParam.nChannels,ii)
%     
%     hold on
%     histogram(AllDataMatrixGenes(:,ii),'Normalization','probability')
%     histogram(NegativePop{ii},'Normalization','probability')
%     
% %     xlim([minvalues(ii),maxvalues(ii)])
%     title(analysisParam.Channels{ii})
%     
%     legend('All Data','Negative Population')
%     
% end

%% Normalize data as (Data - mean negative population)/NormValues, normvalues is a high number so that the normalized data is around [0,1], so we take for example the 95% quantile.

NormValues = quantile(AllDataMatrixGenes,0.995);

NewNormalizedData = {};

for SubExpNum = 1:CellClassifParam.NumofSubexperiments
    for conditionnumber=1:analysisParam(SubExpNum).nCon
    
%     NormDataAux = (AllDataMatrixDAPInorm{conditionnumber}(:,analysisParam.startGeneData+(1:analysisParam.nChannels))-meanNegativePop)./NormValues;
        NormDataAux = (singleCells{SubExpNum}{conditionnumber}(:,CellClassifParam.startGeneData+(1:CellClassifParam.nChannels)))./NormValues;
%     NormDataAux(NormDataAux<0) = 0; %Set to 0 the values that end up negative after the normalization (those such that are smaller than the mean of the negative population)
    NewNormalizedData{SubExpNum}{conditionnumber} = [ singleCells{SubExpNum}{conditionnumber}(:,1:CellClassifParam.startGeneData),NormDataAux,singleCells{SubExpNum}{conditionnumber}(:,end)];

    end
    
end

minvalues = minvalues ./ NormValues;
maxvalues = maxvalues./NormValues;

%% Plot normalized data



% figure('Position',[0 0 1200 1000])
% 
% channelstoplot = CellClassifParam.startGeneData+(1:analysisParam(1).nChannels);
% for ii=1:8
% 
%     subplot(1,2,1)
%     scatter3(singleCells{1}{ii}(:,channelstoplot(1)),singleCells{1}{ii}(:,channelstoplot(2)),singleCells{1}{ii}(:,channelstoplot(3)))
%     hold on
%     subplot(1,2,2)
% scatter3(NewNormalizedData{1}{ii}(:,channelstoplot(1)),NewNormalizedData{1}{ii}(:,channelstoplot(2)),NewNormalizedData{1}{ii}(:,channelstoplot(3)))
% 
% % xlim([0 5])
% % ylim([0 5])
% % zlim([0 5])
%     hold on
% end
% %PCA
% figure
% [coeff,score,latent] = pca(AllDataMatrixGenes);
% scatter3(score(:,1),score(:,2),score(:,3))



%% Cluster data depending on the proportion of the expression of each gene (subclustering unclassified cells)
% 
% propclassification1 = 0.5; % Threshold for a cell to be classified as a single fate
% 
% propclassification2 = 0.8; % Threshold for a cell to be classified as mix of fates

singleCellsClassified = cell(1,CellClassifParam.NumofSubexperiments);

PropCellspercondition = cell(1,CellClassifParam.NumofSubexperiments);

PropCellsperconditionperposition = cell(1,CellClassifParam.NumofSubexperiments);

for SubExpNum = 1:CellClassifParam.NumofSubexperiments
    singleCellsClassified{SubExpNum} = cell(1,analysisParam(SubExpNum).nCon);
    PropCellspercondition{SubExpNum} = zeros(analysisParam(SubExpNum).nCon,CellClassifParam.nLabels);
    PropCellsperconditionperposition{SubExpNum} = zeros(analysisParam(SubExpNum).nCon,CellClassifParam.nLabels,NewNormalizedData{SubExpNum}{conditionnumber}(end,end));

    for conditionnumber=1:analysisParam(SubExpNum).nCon
    
    DataAux = NewNormalizedData{SubExpNum}{conditionnumber};
    
    for ii = 1:size(DataAux,1)
        vecaux1 = DataAux(ii,(CellClassifParam.startGeneData+1):((CellClassifParam.startGeneData+1)+CellClassifParam.nChannels-1));
        
        if sum(vecaux1<(meanNegativePop./NormValues)) == 3
            singleCellsClassified{SubExpNum}{conditionnumber} = [singleCellsClassified{SubExpNum}{conditionnumber};DataAux(ii,:),vecaux1,1];
            PropCellspercondition{SubExpNum}(conditionnumber,1) = PropCellspercondition{SubExpNum}(conditionnumber,1)+1;
            PropCellsperconditionperposition{SubExpNum}(conditionnumber,1,DataAux(ii,end)) = PropCellsperconditionperposition{SubExpNum}(conditionnumber,1,DataAux(ii,end)) + 100/sum(DataAux(:,end)==DataAux(ii,end));
            
        else
            
        vecaux = vecaux1/sum(abs(vecaux1));
        vecaux = vecaux(analysisParam(SubExpNum).ChannelOrder);
        
        if vecaux(1) > CellClassifParam.propclassification1  %SOX2
            
            classificationnumber = 2;
            
        elseif vecaux(2) > CellClassifParam.propclassification1  %BRA
            
            classificationnumber = 4;
            
        elseif vecaux(3) > CellClassifParam.propclassification1   %CDX2
            
            classificationnumber = 6;
            
        elseif vecaux(1)+vecaux(2) > CellClassifParam.propclassification2  %SOX2/BRA
            
           classificationnumber = 3;
           
        elseif vecaux(2)+vecaux(3) > CellClassifParam.propclassification2  %BRA/CDX2
            
           classificationnumber = 5;
           
        elseif vecaux(1)+vecaux(3) > CellClassifParam.propclassification2  %SOX2/CDX2
            
           classificationnumber = 7;
           
        else 
            
            classificationnumber = 8;
        end
        
        singleCellsClassified{SubExpNum}{conditionnumber} = [singleCellsClassified{SubExpNum}{conditionnumber};DataAux(ii,:),vecaux1,classificationnumber];
            
            PropCellspercondition{SubExpNum}(conditionnumber,classificationnumber) = PropCellspercondition{SubExpNum}(conditionnumber,classificationnumber)+1;

            PropCellsperconditionperposition{SubExpNum}(conditionnumber,classificationnumber,DataAux(ii,end)) = PropCellsperconditionperposition{SubExpNum}(conditionnumber,classificationnumber,DataAux(ii,end)) + 100/sum(DataAux(:,end)==DataAux(ii,end));
            
        end
        
    end
    
    PropCellspercondition{SubExpNum}(conditionnumber,:) = PropCellspercondition{SubExpNum}(conditionnumber,:)/size(DataAux,1)*100;
    
end
PropCellsperconditionTableNormalization = array2table(PropCellspercondition{SubExpNum}(analysisParam(SubExpNum).ConditionOrder,:),'VariableNames',CellClassifParam.ClassificationLabels,'RowNames',analysisParam(SubExpNum).conNamesPlot(analysisParam(SubExpNum).ConditionOrder))

PropCellsperconditionTableNormalizationcsv = array2table(round(PropCellspercondition{SubExpNum}(analysisParam(SubExpNum).ConditionOrder,:),2),'VariableNames',CellClassifParam.ClassificationLabels,'RowNames',analysisParam(SubExpNum).conNamesPlot(analysisParam(SubExpNum).ConditionOrder));

writetable(PropCellsperconditionTableNormalizationcsv,['singleCellClassification',num2str(SubExpNum),'.csv'],'WriteRowNames',true) 

end



%%

save('singleCellsClassified','singleCellsClassified','PropCellspercondition','PropCellsperconditionTableNormalization','PropCellsperconditionperposition','minvalues','maxvalues')

