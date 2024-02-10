function stability = computestability(root,parameters)

SM = ode_ONLYGRNModel_v8_jac(0,root,parameters);
SM;

eigSM = eig(SM);



% 1 = stablepoint
% 2 = maxpoint
% 3 = saddlepoint
% 4 = limitcycle


stability = 0;

% eigSM=real(eigSM);

if (isreal(eigSM))|(sum(abs(imag(eigSM)))<1.0e-3)
    
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

