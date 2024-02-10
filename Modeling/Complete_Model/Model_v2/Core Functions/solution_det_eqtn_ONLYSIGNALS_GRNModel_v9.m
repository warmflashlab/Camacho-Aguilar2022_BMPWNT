function sol=solution_det_eqtn_ONLYSIGNALS_GRNModel_v9(s0,tspan,p,opt)

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




if opt==1
    options = odeset('InitialStep',0.001);
    sol=ode15s(@(t,s) ode_ONLYSIGNALS_GRNModel_v9(t,s,p),tspan,s0,options);
else
options = odeset('InitialStep',0.001);
sol=ode23(@(t,s) ode_ONLYSIGNALS_GRNModel_v9(t,s,p),tspan,s0,options);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Elena 04/28/21
