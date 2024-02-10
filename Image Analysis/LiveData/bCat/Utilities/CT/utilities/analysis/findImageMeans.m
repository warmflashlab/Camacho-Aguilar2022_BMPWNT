function [ dapiMeans, bCatMeans, bCat2dapiMeans, dapiSE, bCatSE, bCat2dapiSE ] = findImageMeans( allPeaks )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
dapi = nan(25,4);
bCat = nan(25,4);
nImages = size(allPeaks,1);

for ii = 1:size(allPeaks,1)
    for jj = 1:size(allPeaks,2);
    dapi(ii,jj) = meannonan(allPeaks{ii,jj}(:,5));
    bCat(ii,jj) = meannonan(allPeaks{ii,jj}(:,6));
    bCat2dapi(ii,jj) = meannonan(allPeaks{ii,jj}(:,6)./allPeaks{ii,jj}(:,5));
    
    end
end
dapiMeans = meannonan(dapi);
bCatMeans = meannonan(bCat);
bCat2dapiMeans = meannonan(bCat2dapi);
dapiSE = stdnonan(dapi)./sqrt(nImages);
bCatSE = stdnonan(bCat)./sqrt(nImages);
bCat2dapiSE  = stdnonan(bCat2dapi)./sqrt(nImages);

end