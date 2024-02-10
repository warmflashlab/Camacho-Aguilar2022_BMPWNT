function solaux2=simulate_solution_det_eqtn_step_GRNModel(initcond,tspan,BMPlevels,mTeSRBMPlevel,basalBMPlevel,Signals,p,tsol,odeopt)

%tspan is a string containing the tspans between media changes
% Signals is a vector that contains the BMP ligand values for each tspan on
% the first row, the Noggin values for each tspan on the second row, the
% IWP2 value on the third row and WNTEx on the fourth row.

timeplot = [];
yplot = [];

flag=1;





if length(tspan) == size(Signals,2)
   
    ii = 1;
  

while flag 
    


    % Changes in variables    
    if ii==1
        y0 = initcond;
    else
        y0 = solaux.y(:,end);
        y0(1) = basalBMPlevel+BMPlevels*mTeSRBMPlevel^(Signals(1,ii)>0);%Signals(1,ii); %Media change changes the ligand value to a proportion of the original BMP levels
%         y0(1) = basalBMPlevel+BMPlevels*mTeSRBMPlevel^Signals(1,ii);
        y0(3) = (1-Signals(2,ii))*y0(3); %Media change might introduce Nogging, inhibiting the free BMP receptors
    end

    %Changes in parameters
    p(18) = Signals(3,ii);  %IWP2 in the media
    p(19) = Signals(4,ii);  %WNTEx in the media
    if Signals(2,ii) %If there is Noggin in the media, BMP Ligand can't attach to free BMP receptors
        p(5)=0;
    end

    solaux = solution_det_eqtn_GRNModel_v8(y0,tspan{ii},p,odeopt);
    
    
    
%     size(solaux)

% ii
% tsol
% tspan{ii}(end)
if tsol<=tspan{ii}(end)
%     solaux=solaux.y;
    solaux2 = deval(solaux,tsol);
    flag=0;
else
    ii=ii+1;
end

end


else
    
    disp('Incorrect sizes tspan and Signals parameters')
    
end

% yplot(:,end)
