load('/Users/elenacamachoaguilar/Dropbox (Personal)/Rice/Experiments/200115_CDX2Commitment_Exp22/Analysis_BeforeTreatment/allPeaks.mat')
allPeaksBT = allPeaks;

load('/Users/elenacamachoaguilar/Dropbox (Personal)/Rice/Experiments/200115_CDX2Commitment_Exp22/Analysis_AfterTreatment/allPeaks.mat')
allPeaksAT = allPeaks;

%% Join all data

[nCon,nPos] = size(allPeaksBT);
allPeaks = cell(nCon,nPos);

for iCon=1:nCon
    for iPos=1:nPos
        
        allPeaks{iCon,iPos} = [allPeaksBT{iCon,iPos}(1:11),allPeaksAT{iCon,iPos}(1:174)];
        
    end
    
end

%%

save('/Users/elenacamachoaguilar/Dropbox (Personal)/Rice/Experiments/200115_CDX2Commitment_Exp22/Analysis_AllData/allPeaks.mat','allPeaks')

disp('Data saved')