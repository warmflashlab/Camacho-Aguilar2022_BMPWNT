function [soltraj,ttraj,attractors,fatesvector,propsfates] = functionplotscatter_SDE_fit_plot_v9(conditiontosimulate,subparameter,structtopass,nsimulations,D,expcov,initcondsim)

% disp('functiontofit_v2: Running...')
% tic
% rng(13)
% structtopass
ExpDataStruct = structtopass.ExpDataStruct;
nExp=structtopass.nExp; 

Istar=10;
dt=0.001;
noisecov = sqrt(2*dt*D);

simulatedFates = zeros(nExp,9);
goodparameters = 0;
% NSimulations = 100;

% parametervalueaux = parameter;

attractorsaux = zeros(3,3);
attractors = zeros(3,3);

flag=1;
flagg=1;

initcondaux = structtopass.initcond;

parameter = subparameter.parammodel;
mTesrBMPlevel = subparameter.mTesrBMPlevel;
basalBMPlevel = subparameter.basalBMPlevel;
paramBMPfunc = subparameter.paramBMPfunc;




% AllMatProp
% simulatedFates
%%
%Compute attractors:
%------------------
        dt = 0.01;
        tCH = 24*1.5;
        tF = 100*1.5;

        
        %--------------------------------------
        %       SOX2
        %--------------------------------------
        
        % Simulate experiment
        % -------------------
        tCH1 = 24*1.5;
        tCH2 = tF;
        BMPlevel = functionBMPlevel(0,paramBMPfunc);


        initcond = [0,0,Istar,0,0,1,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
        tspan = {tspan1,tspan2};
        Signals = [0,0;...
                   0,0;...
                   0,0;...
                   0,0];
%         [tplot,solendtraj]=solution_det_eqtn_step_GRNModel_v7(initcond,tspan,Signals,parametervalue,[1,0,0],1);
%         solendtraj(6:8,end)    

        solendtraj = simulate_solution_det_eqtn_step_GRNModel_v9(initcond,tspan,BMPlevel,mTesrBMPlevel,basalBMPlevel,Signals,parameter,100*1.5,2);
        if sum(imag(solendtraj))<1.0e-4
        solendtraj = real(solendtraj);
        end

%         solendtraj(6:8)
        % Check if there is an attractor next and it's the SOX2 attractor
        % ---------------------------------------------------------------
        SMAD40 = 0;
        bCat0 = 0;
        paramattractors = parameter;
        paramattractors(1) = SMAD40;
        paramattractors(2) = bCat0;
        [root,stability,fate,flagg] = findrootGRN_v9(solendtraj(6:8),paramattractors);

        
        if (fate==1)&&(stability==1)
            attractorsaux(:,1) = root;            
        else
            disp('SOX2')
            flag=0;
            disSOX2=2;

        end

    
        %--------------------------------------
        %       BRA
        %--------------------------------------
        
        % Simulate experiment
        % -------------------
        tCH1 = 16*1.5;
        tCH2 = 24*1.5;
        BMPlevel = functionBMPlevel(10,paramBMPfunc);
        
        
        initcond = [BMPlevel,0,Istar,0,0,1,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
        tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2,tspan3};
        Signals = [0,1,1;...
                   0,0,0;...
                   0,0,0;...
                   0,0,0];
               
        solendtraj = simulate_solution_det_eqtn_step_GRNModel_v9(initcond,tspan,BMPlevel,mTesrBMPlevel,basalBMPlevel,Signals,parameter,100*1.5,2);
%         solendtraj(6:8)
        if sum(imag(solendtraj))<1.0e-4
        solendtraj = real(solendtraj);
        end
        
        % Check if there is an attractor next and it's the BRA attractor
        % ---------------------------------------------------------------
        SMAD40 = 0;
        bCat0 = 1;
        paramattractors = parameter;
        paramattractors(1) = SMAD40;
        paramattractors(2) = bCat0;
        [root,stability,fate,flagg] = findrootGRN_v9(solendtraj(6:8),paramattractors);

        if (fate==2)&&(stability==1)
            attractorsaux(:,2) = root;
        else
            disp('BRA')
            flag=0;
            disBRA=2;

        end
        
%         %--------------------------------------
%         %       BRA (50ng,30h, Noggin)
%         %--------------------------------------
%         
%         % Simulate experiment
%         % -------------------
%         tCH1 = 24*1.5;
%         tCH2 = 30*1.5;
%         BMPlevel = functionBMPlevel(50,paramBMPfunc);
%         
%         
%         initcond = [BMPlevel,0,Istar,0,0,1,0,0];
%         tspan1 = [0:dt:tCH1];
%         tspan2 = [tCH1:dt:tCH2];
%         tspan3 = [tCH2:dt:tF];
%         tspan = {tspan1,tspan2,tspan3};
%         Signals = [0,0,1;...
%                    0,0,1;...
%                    0,0,0;...
%                    0,0,0];
%                
%         solendtraj = simulate_solution_det_eqtn_step_GRNModel(initcond,tspan,BMPlevel,mTesrBMPlevel,basalBMPlevel,Signals,parameter,100*1.5,2);
% %         solendtraj(6:8)
%         if sum(imag(solendtraj))<1.0e-4
%         solendtraj = real(solendtraj);
%         end
%         
%         % Check if there is an attractor next and it's the BRA attractor
%         % ---------------------------------------------------------------
%         SMAD40 = 0;
%         bCat0 = 1;
%         paramattractors = parameter;
%         paramattractors(1) = SMAD40;
%         paramattractors(2) = bCat0;
%         [root,stability,fate,flagg] = findrootGRN(solendtraj(6:8),paramattractors);
% 
%         if (fate==2)&&(stability==1)
%             attractorsaux(:,2) = root;
%         else
%             disp('BRA')
%             flag=0;
%             disBRA=2;
% 
%         end

        %--------------------------------------
        %       CDX2
        %--------------------------------------
        
        % Simulate experiment
        % -------------------
        tCH1 = 24*1.5;
        tCH2 = tF;
        BMPlevel = functionBMPlevel(10,paramBMPfunc);


        initcond = [BMPlevel,0,Istar,0,0,1,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
        tspan = {tspan1,tspan2};
        Signals = [0,0;...
                   0,0;...
                   0,0;...
                   0,0];

        solendtraj = simulate_solution_det_eqtn_step_GRNModel_v9(initcond,tspan,BMPlevel,mTesrBMPlevel,basalBMPlevel,Signals,parameter,100*1.5,2);
%         solendtraj(6:8,end)   
        if sum(imag(solendtraj))<1.0e-4
        solendtraj = real(solendtraj);
        end

        
        % Check if there is an attractor next and it's the CDX2 attractor
        % ---------------------------------------------------------------
        SMAD40 = 1;
        bCat0 = 1;
        paramattractors = parameter;
        paramattractors(1) = SMAD40;
        paramattractors(2) = bCat0;
        [root,stability,fate,flagg] = findrootGRN_v9(solendtraj(6:8),paramattractors);

        if (fate==3)&&(stability==1)
            attractorsaux(:,3) = root;
        else
            disp('CDX2')
            flag=0;
            disCDX2=2;

        end
        
        
        attractorsaux = real(attractorsaux);

attractors = attractorsaux

% attractors(:,3) = [0.0086;1.3115;0.1733];


% pause()
        
 %%   
%Simulate experiments with that parameter:
%----------------------------------------
eltime15s=0;
eltime23=0;
resall=0;
paramvalues = [];

simulatedfates = zeros(nExp,9,nsimulations);
goodparameters = zeros(1,nsimulations);

if rank(attractors)<3
    flag=0;
end


if flag

                                                           
        [soltraj,ttraj,fatesvector,propsfates] = simulateandplotexperiment_SDE_fit_ATP_v9(attractors,conditiontosimulate,subparameter,ExpDataStruct,Istar,nsimulations,noisecov,expcov,dt,2,initcondsim);



else

    
end
% res=0;

% res
% toc
% disp('functiontofit_v2: Finished')

