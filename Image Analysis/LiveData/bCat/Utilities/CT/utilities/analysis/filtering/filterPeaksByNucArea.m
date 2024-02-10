function peaks = filterNucArea(peaks,nucAreaMin,nucAreaMax)
peaks = peaks(peaks(:,3)>nucAreaMin,:);
peaks = peaks(peaks(:,3)<nucAreaMax,:);

end