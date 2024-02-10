function [meanG2R semG2R]= getGFP2RFP(peaks)
meanG2R = meannonan(peaks(:,6)./peaks(:,5));
semG2R = (stdnonan(peaks(:,6)./peaks(:,5)))./sqrt(size(peaks,1));
end
