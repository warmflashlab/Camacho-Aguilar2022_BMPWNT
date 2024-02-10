clear
load('singleCells')

%%
NuclearMarkerValues = cell(8,1);

for position = 1:8

    for time = 1:(size(singleCells{1},2)-1)
        
        NuclearMarkerValues{position} = [NuclearMarkerValues{position};singleCells{position}{time}(:,6)];
        
    end
    
    
end

%%

histogram(NuclearMarkerValues{1})