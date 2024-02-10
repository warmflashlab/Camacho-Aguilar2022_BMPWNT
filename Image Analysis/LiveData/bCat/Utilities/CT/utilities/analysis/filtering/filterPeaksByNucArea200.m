function peaks = filterNucArea(peaks)
peaks = peaks(peaks(:,3)>200,:);
end