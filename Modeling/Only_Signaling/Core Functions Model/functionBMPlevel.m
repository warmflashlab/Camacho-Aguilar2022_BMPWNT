function BMPlevelres = functionBMPlevel(BMPlevelraw,param)

if BMPlevelraw == 0
    BMPlevelres=0;
    
else
% BMPlevelres = 1./(1+1./BMPlevelraw)*30; % Used for fitting v1-v8
BMPlevelres = param(3)./(1+(param(1)./BMPlevelraw).^param(2));
end

% if param == 0
%     BMPlevelres=1/2;
%     
% else
% BMPlevelres = 1+tanh(param(1)*(BMPlevelraw+param(2)))/2;

% end
