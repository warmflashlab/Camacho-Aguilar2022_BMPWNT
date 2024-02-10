function peaks=addgoodtopeaks(cells2,peaks)
%function to add flag indicated good cells to last column of peaks

goodcells=[cells2.good]==1;


for ii=1:length(peaks)
    if size(peaks{ii},2) > 8
%         disp(['Warning: removing columns 9 to' int2str(size(peaks{ii},2))...
%             ' from peaks, frame ' int2str(ii) '.']);        
        peaks{ii}=peaks{ii}(:,1:8);
    end
    huitiemeColonne = peaks{ii}(:,end);
    isgoodframe = zeros(size(huitiemeColonne));
    NotMinusOne = find(huitiemeColonne ~= -1);
    isgoodframe(NotMinusOne)= goodcells(peaks{ii}(NotMinusOne,end));
    peaks{ii}(:,end+1)=isgoodframe;
end
