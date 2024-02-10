%% Compute maximum values

function savesingleCells
load('AllDataExperiment.mat')

nPlates = 2;
nConditions=8;

singleCells = {};

for condnum = 1:nPlates
    
    singleCells{condnum} = {};
    
    for tpnum = 1:nConditions
        singleCells{condnum}{tpnum} = AllDataExperiment{condnum}{tpnum};
%      scatter3(singleCells{condnum}{tpnum}(:,4),singleCells{condnum}{tpnum}(:,5),singleCells{condnum}{tpnum}(:,6))
%     hold on
    end
%     pause
%     close
end
    
%%
save('singleCells')