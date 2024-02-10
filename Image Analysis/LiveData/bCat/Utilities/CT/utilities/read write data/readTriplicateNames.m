function [sampleNames,triplicateNames]=readTriplicateNames(datafiles,genenumbers,Brigitte)
% adapted by JKm from computeOnePlate, outputs sample names
%----------------------------------------------------------------
%
% sampleNames should is each sample where rows are replicates and columns
% are triplicates. If these don't match then something is wrong.

% if sampleNames looks correct, then triplicateNames is in the same format
% as FC and Err from computeOnePlate only it shows the name of each sample
% instead of gene expression data.



if ~exist('Brigitte','var')
    Brigitte = false;
end

sampleNames=[];
for ii=1:length(datafiles)
    
    if ischar(datafiles{ii})
        T=readSOPdata3(datafiles{ii});
    else
        T=datafiles{ii};
    end
    
    tmp = length(T);
    
    if tmp < 96
        T((tmp+1):96)={'empty well'};
    end
    
    %check the size
    if length(T) ~= 96
        error('expected data from a 96 well plate');
    end
    
    %reshape, one column for each triplicate
    
    if Brigitte
        TRtmp=reshape(T,12,8)';
        %TRtmp=[TRtmp(1:3,:) TRtmp(5:7,:)];
        TRtmp=[TRtmp(1:3,:) TRtmp(4:6,:) NaN(3,8)];
        
    else
        TRtmp=reshape(T,3,32);
    end
    sampleNames=[sampleNames TRtmp];
end
ngenes=length(genenumbers);

%%
%group the data by gene
for ii=1:ngenes
    gdata(ii,:)=sampleNames(1,genenumbers{ii});
end
triplicateNames = gdata;
end