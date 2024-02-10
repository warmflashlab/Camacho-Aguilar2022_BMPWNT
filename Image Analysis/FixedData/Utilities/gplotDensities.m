function gplotDensities(Data,distance,titlesdimensions,limits)

ndimensions = size(Data,2);

pointsize=5;

% figure('Position',[100 100 1700 1700])
disp('Plotting')
for i=1:ndimensions
    
%     disp(num2str(i))
    for j=1:ndimensions
        disp('.')
%         disp(num2str(j))
        if i==j
        subplot(ndimensions,ndimensions,(ndimensions+1)*(i-1)+1)
        histogram(Data(:,i))
        xlim([0,limits{i}(2)])
        title(titlesdimensions{i})
        else
            subplot(ndimensions,ndimensions,ndimensions*(i-1)+j)
            scatter(Data(:,j),Data(:,i),pointsize,assignnumberneighbours2(Data(:,i),Data(:,j),distance),'MarkerEdgeAlpha',0.5)
            xlabel(titlesdimensions{j})
            ylabel(titlesdimensions{i})
            xlim([0,limits{j}(2)])
            ylim([0,limits{i}(2)])
    
        end
        
        
    end
end