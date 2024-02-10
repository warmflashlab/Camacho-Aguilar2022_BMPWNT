function [FC,ERR,meanDDCT,stdDDCT,  mddCT, MeanDcte, StdDcte]=ComputeOnePlate(datafiles,genenumbers,normgene,normcond,Brigitte)
%[fc err]=ComputeOnePlate(datafile,genenumbers,normgene,genenames,condnames)
%----------------------------------------------------------------
%Function to read in one plate worth of qPCR data and quantify

%read in the data file, should contain 96 numbers

if ~exist('Brigitte','var')
    Brigitte = false;
end

TRall=[];
for ii=1:length(datafiles)
    
    if ischar(datafiles{ii})
        T=readSOPData2(datafiles{ii});
    else
        T=datafiles{ii};
    end
    
    tmp = length(T);
    
    if tmp < 96
        T((tmp+1):96)=NaN;
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
    TRall=[TRall TRtmp];
end
ngenes=length(genenumbers);

%replace single NaN by mean of others
for ii = 1:length(TRall)
    inan = isnan(TRall(:,ii));
    if sum(inan) == 1
        TRall(inan,ii) = mean(TRall(~inan,ii));
    end
end

%group the data by gene
for ii=1:ngenes
    gdata{ii}=TRall(:,genenumbers{ii});
end


 
for ii=1:ngenes
       
    dCTE =  gdata{ii}-gdata{normgene};
    dCTC =  gdata{ii}(:,normcond)-gdata{normgene}(:,normcond);    
    ddCT = bsxfun(@minus,dCTE,dCTC);
    F = 2.^(-(ddCT));
    FC{ii} = F;
    mddCT{ii} = -ddCT;
    MeanDcte(ii,:) = meannonan(-dCTE);
    StdDcte(ii,:) = stdnonan(-dCTE);
    dCTEall{ii} = dCTE;
end

for ii=1:ngenes
meanFC(ii,:) = meannonan(FC{ii});
stdFC(ii,:) = stdnonan(FC{ii});
meanDDCT(ii,:) = meannonan(mddCT{ii});
stdDDCT(ii,:) = stdnonan(mddCT{ii});
end
FC = meanFC;
ERR = stdFC;


end