function [allPeaksFilt] = filterAllPeaksByNucArea(allPeaks,nucAreaMin,nucAreaMax)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
for iM = 1: size(allPeaks,1)
    for iN = 1:size(allPeaks,2)
allPeaksFilt{iM,iN} = cellfun(@(x) filterPeaksByNucArea(x,nucAreaMin,nucAreaMax), allPeaks{iM,iN},'UniformOutput',false);
    end
end




end

