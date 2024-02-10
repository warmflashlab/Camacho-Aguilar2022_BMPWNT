function [root,stability,flag]=integrateODEsystembackwards(guess,parameters)

        initcond = guess;

        options = odeset('InitialStep',0.001);
        solendtraj = ode15s(@(t,s) ode_ONLYGRNModel_v8(t,s,parameters),[1000:-0.001:0],guess,options);
        root = solendtraj.y(:,end)
        
        if sum(imag(root))<0.0001
        root = real(root);
        end
    
        if sum(isnan(root))>1
            
            flag=0;
            stability = 2;

            fate = 4;
            
        elseif sum(imag(root)>0)>1
    
            flag=0;
            stability = 2;

            fate = 4;
            
        elseif sum(root)>exp(10)
            
            flag=0;
            stability = 2;

            fate = 4;
            
        else
            
            flag=1;
            stability=1;
            fate=0;
        end
