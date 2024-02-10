function [expression,expressionSigma]=ComputeOnePlate(datafiles,genenumbers,normgene,normcond,Brigitte,LogExpression)
%[fc err]=ComputeOnePlate(datafile,genenumbers,normgene,genenames,condnames)
%----------------------------------------------------------------
%Function to read in one plate worth of qPCR data and quantify

%read in the data file, should contain 96 numbers

%set Brigitte to zero unless triplicates on plate are in columns
%(e.g.,triplicate(1) = A1,B1,C1 ; triplicate(2) = D1,E1,F1 ; etc; where
%rows G and H are unused)

% LogExpression = output expression data in log2 format; set to 0 for linear (i.e., expression will
%                 be 2^-ddCT)

if ~exist('Brigitte','var') 
    Brigitte = false;
end


if ~exist('LogExpression','var')
    LogExpression = true;
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



 

 % ddCTstd = sqrt(std(dCT)^2+std(dCT(control)^2)
 % ddCTsem = ddCTstd./sqrt(n)
 % -ddCT
for ii=1:ngenes
    dCT(ii,:) = meannonan(gdata{ii})-meannonan(gdata{normgene}); % mean(CTexp)- mean(CTcontrol) = dCT
    DCTsigma(ii,:) = sqrt(stdnonan(gdata{ii}).^2+stdnonan(gdata{normgene}).^2); %std(dCT)
 end   
    ddCT = dCT-dCT(:,normcond); % dCT-dCT(1) = ddCT
    ddCTsigma = sqrt(DCTsigma.^2+DCTsigma(:,normcond).^2); %std of ddCT
    mddCT = -ddCT;
    
    if LogExpression
        expression = mddCT;
        expressionSigma = ddCTsigma;
    else
         expression = 2.^mddCT;
         expressionSigma = abs(expression*log(2).*ddCTsigma);
    end

end