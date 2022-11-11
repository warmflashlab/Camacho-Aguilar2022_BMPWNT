function singleCellsNucClean = cleanNucMarkerSingleCells(singleCells)

setUserParam_esi017_20x

global analysisParam;
global userParam;

singleCellsNucClean = cell(analysisParam.nCon,1);

for iCon = 1:analysisParam.nCon
    
    timepointsnoempty = find(~cellfun('isempty', singleCells{iCon}));
    ntimepoints = length(singleCellsNucClean{iCon});
    
    singleCellsNucClean{iCon} = cell(1,ntimepoints);
    
    for iTime = timepointsnoempty
        
        NArea = singleCells{iCon}{iTime}(:,3);
    
        singleCellsNucClean{iCon}{iTime} = singleCells{iCon}{iTime}((NArea>=userParam.nucAreaLo)&(NArea<=userParam.nucAreaHi),:);
    
    
    end

end