function [Xsol,tvsol,flag]=solution_Euler_det_eqtn_GRNModel_v8_AllTimePoints(Xs0,tspan,signaltraj,p,tsol,nsimulations,noisecov)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                          v1: modelsignals .                             %
%                                                                         %
%  This programme solves the deterministic differential equation of the   %
%  model for the evolution of the WNT signals in time given BMP.          %
%  s0 is the initial condition.                                           %
%  tspan is the discretisation of time in which we approximate the        %
%        solution.                                                        %
%  param are the parameters                                               %
%                                                                         %
%  sol is the structure with the solution of the ODE.                     %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ntpoints = length(tspan)-1;


    
    Z1D = randn(ntpoints,nsimulations)*noisecov;  % Noise realisations for each dimension
    Z2D = randn(ntpoints,nsimulations)*noisecov;  
    Z3D = randn(ntpoints,nsimulations)*noisecov;

Xprev = Xs0;

ii=1;
flagaux=1;

Xsol = zeros(8,nsimulations,ntpoints);


while flagaux


    dtfprev=(tspan(ii+1)-tspan(ii))*ode_ONLYGRNModel_v8_vec(tspan(ii+1),Xprev,p);       %Evaluate f at the previous state




Xprevaux = Xprev(6:end,:)+dtfprev+[Z1D(ii,:);Z2D(ii,:);Z3D(ii,:)];        
    Xprevaux(Xprevaux<0) = 0;
    
    Xprev = [repmat(signaltraj(:,ii+1),1,nsimulations);Xprevaux];
    
    
    


if tspan(ii+1)>=tsol
    
    flagaux = 0;
    flag=0;
    
elseif (ii)==ntpoints
    flagaux=0;
    flag=1;
end
Xsol(:,:,ii) = Xprev;
ii=ii+1;




    
end

Xsol = Xsol(:,:,1:(ii-1));
tvsol = tspan(2:ii);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Elena 11/30/21
