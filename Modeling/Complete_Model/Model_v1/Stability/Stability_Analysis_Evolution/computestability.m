function stability = computestability(root,parameters)

SM = ode_ONLYGRNModel_v8_jac(0,root,parameters);

if sum(sum(isnan(SM)))>0
    
    stability = 5;
    
elseif sum(sum(isinf(SM)))>0
    stability = 5;
else

eigSM = eig(SM);


% 1 = stablepoint
% 2 = maxpoint
% 3 = saddlepoint
% 4 = limitcycle


stability = 0;


if isreal(eigSM)
    
    if sum(eigSM<0) == 3
        stability = 1;

    elseif sum(eigSM>0) == 3
        stability=2;

    else
        stability = 3;
        
    end
    
else
    stability = 4;
end
end

