function [simulatedEndTrajs,ttrajs,attractors] = functiontofit_ODE_plot(conditiontosimulate,subparameter,structtopass)

% disp('functiontofit_v2: Running...')
% tic
% rng(13)
% structtopass
ExpDataStruct = structtopass.ExpDataStruct;
nExp=structtopass.nExp; 
initcondaux = structtopass.initcond;

parameter = subparameter.parammodel;
mTesrBMPlevel = subparameter.mTesrBMPlevel;
basalBMPlevel = subparameter.basalBMPlevel;
paramBMPfunc = subparameter.paramBMPfunc;

Istar=10;
dt=0.001;
% noisecov = sqrt(2*dt*D);

simulatedFates = zeros(nExp,9);
goodparameters = 0;
% NSimulations = 100;


attractorsaux = zeros(3,3);
attractors = zeros(3,3);

flag=1;
flagg=1;


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

        solendtraj = simulate_solution_det_eqtn_step_GRNModel(initcond,tspan,BMPlevel,mTesrBMPlevel,basalBMPlevel,Signals,parameter,100*1.5,2);
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
        [root,stability,fate,flagg] = findrootGRN(solendtraj(6:8),paramattractors);

        
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
               
        solendtraj = simulate_solution_det_eqtn_step_GRNModel(initcond,tspan,BMPlevel,mTesrBMPlevel,basalBMPlevel,Signals,parameter,100*1.5,2);
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
        [root,stability,fate,flagg] = findrootGRN(solendtraj(6:8),paramattractors);

        if (fate==2)&&(stability==1)
            attractorsaux(:,2) = root;
        else
            disp('BRA')
            flag=0;
            disBRA=2;

        end

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

        solendtraj = simulate_solution_det_eqtn_step_GRNModel(initcond,tspan,BMPlevel,mTesrBMPlevel,basalBMPlevel,Signals,parameter,100*1.5,2);
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
        [root,stability,fate,flagg] = findrootGRN(solendtraj(6:8),paramattractors);

        if (fate==3)&&(stability==1)
            attractorsaux(:,3) = root;
        else
            disp('CDX2')
            flag=0;
            disCDX2=2;

        end
        
        
        attractorsaux = real(attractorsaux);
        

        %%
        
% %% Re-Compute Attractors but normalising to maximum
% 
% flagaux = 1;
% flagaux2 = 1;
% 
% if flag
%     
% if attractorsaux(1,1)>0
%     DSOX2 = attractorsaux(1,1);
% else
%     DSOX2 = 1;
% end
% 
% if attractorsaux(2,2)>0
%     DBRA = attractorsaux(2,2);
% else
%     DBRA = 1;
% end
% 
% if attractorsaux(3,3)>0
%     DCDX2 = attractorsaux(3,3);
% else
%     DCDX2 = 1;
% end
%     
%     parameter([21,33,42]) = parameter([21,33,42])/DSOX2;
%     parameter([25,31,44]) = parameter([25,31,44])/DBRA;
%     parameter([23,35,37,45,47]) = parameter([23,35,37,45,47])/DCDX2;
%     
% %Compute attractors:
% %------------------
%         dt = 0.01;
%         tCH = 24*1.5;
%         tF = 100*1.5;
% 
%         mTesrBMPlevel = 0.1;
%         NogginBMPLevel = 0;
%         
%         %--------------------------------------
%         %       SOX2
%         %--------------------------------------
%         
%         % Simulate experiment
%         % -------------------
%         tCH1 = 24*1.5;
%         tCH2 = tF;
%         BMPlevel = 1./(1+1./10)*30;
% 
% 
%         initcond = [mTesrBMPlevel,0,Istar,0,0,1,0,0];
%         tspan1 = [0:dt:tCH1];
%         tspan2 = [tCH1:dt:tCH2];
%         tspan = {tspan1,tspan2};
%         Signals = [mTesrBMPlevel,mTesrBMPlevel;...
%                    0,0;...
%                    0,0;...
%                    0,0];
% %         [tplot,solendtraj]=solution_det_eqtn_step_GRNModel_v7(initcond,tspan,Signals,parametervalue,[1,0,0],1);
% %         solendtraj(6:8,end)    
% 
%         solendtraj = simulate_solution_det_eqtn_step_GRNModel_v7(initcond,tspan,Signals,parameter,100*1.5,2);
%         if sum(imag(solendtraj))<1.0e-4
%         solendtraj = real(solendtraj);
%         end
% %         solendtraj(6:8)
%         % Check if there is an attractor next and it's the SOX2 attractor
%         % ---------------------------------------------------------------
%         SMAD40 = 0;
%         bCat0 = 0;
%         paramattractors = parameter;
%         paramattractors(1) = SMAD40;
%         paramattractors(2) = bCat0;
%         [root,stability,fate,flagaux2] = findrootGRN_v8(solendtraj(6:8),paramattractors);
% 
%         
%         if (fate==1)&&(stability==1)
%             attractors(:,1) = root;
%             
%         else
%             disp('SOX2')
%             flagaux=0;
%             disSOX2=2;
% 
%         end
% 
%     
%         %--------------------------------------
%         %       BRA
%         %--------------------------------------
%         
%         % Simulate experiment
%         % -------------------
%         tCH1 = 16*1.5;
%         tCH2 = 24*1.5;
%         BMPlevel = 1./(1+1./10)*30;
%         
%         
%         initcond = [BMPlevel,0,Istar,0,0,1,0,0];
%         tspan1 = [0:dt:tCH1];
%         tspan2 = [tCH1:dt:tCH2];
%         tspan3 = [tCH2:dt:tF];
%         tspan = {tspan1,tspan2,tspan3};
%         Signals = [BMPlevel,BMPlevel*mTesrBMPlevel,BMPlevel*mTesrBMPlevel;...
%                    0,0,0;...
%                    0,0,0;...
%                    0,0,0];
%         
%         solendtraj = simulate_solution_det_eqtn_step_GRNModel_v7(initcond,tspan,Signals,parameter,100*1.5,2);
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
%         [root,stability,fate,flagaux2] = findrootGRN_v8(solendtraj(6:8),paramattractors);
% 
%         if (fate==2)&&(stability==1)
%             attractors(:,2) = root;
%         else
%             disp('BRA')
%             flagaux=0;
%             disBRA=2;
% 
%         end
% 
%         %--------------------------------------
%         %       CDX2
%         %--------------------------------------
%         
%         % Simulate experiment
%         % -------------------
%         tCH1 = 24*1.5;
%         tCH2 = tF;
%         BMPlevel = 1./(1+1./10)*30;
% 
% 
%         initcond = [mTesrBMPlevel,0,Istar,0,0,1,0,0];
%         tspan1 = [0:dt:tCH1];
%         tspan2 = [tCH1:dt:tCH2];
%         tspan = {tspan1,tspan2};
%         Signals = [BMPlevel,BMPlevel;...
%                    0,0;...
%                    0,0;...
%                    0,0];
% 
%         solendtraj = simulate_solution_det_eqtn_step_GRNModel_v7(initcond,tspan,Signals,parameter,100*1.5,2);
% %         solendtraj(6:8,end)  
%         if sum(imag(solendtraj))<1.0e-4
%         solendtraj = real(solendtraj);
%         end
% 
%         
%         % Check if there is an attractor next and it's the CDX2 attractor
%         % ---------------------------------------------------------------
%         SMAD40 = 1;
%         bCat0 = 1;
%         paramattractors = parameter;
%         paramattractors(1) = SMAD40;
%         paramattractors(2) = bCat0;
%         [root,stability,fate,flagaux2] = findrootGRN_v8(solendtraj(6:8),paramattractors);
% 
%         if (fate==3)&&(stability==1)
%             attractors(:,3) = root;
%         else
%             disp('CDX2')
%             flagaux=0;
%             disCDX2=2;
% 
%         end
%         
%         if flagaux
%             attractors = real(attractors);
%             
%             disSOX2 = norm([1;0;0]-attractors(:,1),2);
%             disSOX2 = 1+(disSOX2/(1+disSOX2));
%             
%             disBRA = norm([0;1;0]-attractors(:,2),2);
%             disBRA = 1+(disBRA/(1+disBRA));
%             
%             disCDX2 = norm([0;0;1]-attractors(:,3),2);
%             disCDX2 = 1+(disCDX2/(1+disCDX2));
%         else
%             attractors = real(attractorsaux);
%             parameter = allparameters;
%             parameter(parfitnumbers) = subparameter;
%             
%             disSOX2 = norm([1;0;0]-attractors(:,1),2);
%             disSOX2 = 1+(disSOX2/(1+disSOX2));
%             
%             disBRA = norm([0;1;0]-attractors(:,2),2);
%             disBRA = 1+(disBRA/(1+disBRA));
%             
%             disCDX2 = norm([0;0;1]-attractors(:,3),2);
%             disCDX2 = 1+(disCDX2/(1+disCDX2));
%         end
%             
%         
% else
%     
%     if attractorsaux(1,1)>0
%         DSOX2 = attractorsaux(1,1);
%     else
%         DSOX2 = 1;
%     end
% 
%     if attractorsaux(2,2)>0
%         DBRA = attractorsaux(2,2);
%     else
%         DBRA = 1;
%     end
% 
%     if attractorsaux(3,3)>0
%         DCDX2 = attractorsaux(3,3);
%     else
%         DCDX2 = 1;
%     end
%     
%     parameter([21,33,42]) = parameter([21,33,42])/DSOX2;
%     parameter([25,31,44]) = parameter([25,31,44])/DBRA;
%     parameter([23,35,37,45,47]) = parameter([23,35,37,45,47])/DCDX2;
%     
% %Compute attractors:
% %------------------
%         dt = 0.01;
%         tCH = 24*1.5;
%         tF = 100*1.5;
% 
%         mTesrBMPlevel = 0.1;
%         NogginBMPLevel = 0;
%         
%         %--------------------------------------
%         %       SOX2
%         %--------------------------------------
%         
%         % Simulate experiment
%         % -------------------
%         tCH1 = 24*1.5;
%         tCH2 = tF;
%         BMPlevel = 1./(1+1./10)*30;
% 
% 
%         initcond = [mTesrBMPlevel,0,Istar,0,0,1,0,0];
%         tspan1 = [0:dt:tCH1];
%         tspan2 = [tCH1:dt:tCH2];
%         tspan = {tspan1,tspan2};
%         Signals = [mTesrBMPlevel,mTesrBMPlevel;...
%                    0,0;...
%                    0,0;...
%                    0,0];
% %         [tplot,solendtraj]=solution_det_eqtn_step_GRNModel_v7(initcond,tspan,Signals,parametervalue,[1,0,0],1);
% %         solendtraj(6:8,end)    
% 
%         solendtraj = simulate_solution_det_eqtn_step_GRNModel_v7(initcond,tspan,Signals,parameter,100*1.5,2);
%         if sum(imag(solendtraj))<1.0e-4
%         solendtraj = real(solendtraj);
%         end
% 
% %         solendtraj(6:8)
%         % Check if there is an attractor next and it's the SOX2 attractor
%         % ---------------------------------------------------------------
%         SMAD40 = 0;
%         bCat0 = 0;
%         paramattractors = parameter;
%         paramattractors(1) = SMAD40;
%         paramattractors(2) = bCat0;
%         [root,stability,fate,flagaux2] = findrootGRN_v7(solendtraj(6:8),paramattractors);
% 
%         
%         if (fate==1)&&(stability==1)
%             attractors(:,1) = root;            
%         else
%             disp('SOX2')
%             flagaux=0;
%             disSOX2=2;
% 
%         end
% 
%     
%         %--------------------------------------
%         %       BRA
%         %--------------------------------------
%         
%         % Simulate experiment
%         % -------------------
%         tCH1 = 16*1.5;
%         tCH2 = 24*1.5;
%         BMPlevel = 1./(1+1./10)*30;
%         
%         
%         initcond = [BMPlevel,0,Istar,0,0,1,0,0];
%         tspan1 = [0:dt:tCH1];
%         tspan2 = [tCH1:dt:tCH2];
%         tspan3 = [tCH2:dt:tF];
%         tspan = {tspan1,tspan2,tspan3};
%         Signals = [BMPlevel,BMPlevel*mTesrBMPlevel,BMPlevel*mTesrBMPlevel;...
%                    0,0,0;...
%                    0,0,0;...
%                    0,0,0];
%         
%         solendtraj = simulate_solution_det_eqtn_step_GRNModel_v7(initcond,tspan,Signals,parameter,100*1.5,2);
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
%         [root,stability,fate,flagaux2] = findrootGRN_v7(solendtraj(6:8),paramattractors);
% 
%         if (fate==2)&&(stability==1)
%             attractors(:,2) = root;
%             disBRA = norm([0;1;0]-attractors(:,2),2);
%             disBRA = 1+(disBRA/(1+disBRA));
%         else
%             disp('BRA')
%             flagaux=0;
%             disBRA=2;
% 
%         end
% 
%         %--------------------------------------
%         %       CDX2
%         %--------------------------------------
%         
%         % Simulate experiment
%         % -------------------
%         tCH1 = 24*1.5;
%         tCH2 = tF;
%         BMPlevel = 1./(1+1./10)*30;
% 
% 
%         initcond = [mTesrBMPlevel,0,Istar,0,0,1,0,0];
%         tspan1 = [0:dt:tCH1];
%         tspan2 = [tCH1:dt:tCH2];
%         tspan = {tspan1,tspan2};
%         Signals = [BMPlevel,BMPlevel;...
%                    0,0;...
%                    0,0;...
%                    0,0];
% 
%         solendtraj = simulate_solution_det_eqtn_step_GRNModel_v7(initcond,tspan,Signals,parameter,100*1.5,2);
% %         solendtraj(6:8,end)
%         if sum(imag(solendtraj))<1.0e-4
%         solendtraj = real(solendtraj);
%         end
% 
%         
%         % Check if there is an attractor next and it's the CDX2 attractor
%         % ---------------------------------------------------------------
%         SMAD40 = 1;
%         bCat0 = 1;
%         paramattractors = parameter;
%         paramattractors(1) = SMAD40;
%         paramattractors(2) = bCat0;
%         [root,stability,fate,flagaux2] = findrootGRN_v7(solendtraj(6:8),paramattractors);
% 
%         if (fate==3)&&(stability==1)
%             attractors(:,3) = root;
%             disCDX2 = norm([0;0;1]-attractors(:,3),2);
%             disCDX2 = 1+(disCDX2/(1+disCDX2));
%         else
%             disp('CDX2')
%             flagaux=0;
%             disCDX2=2;
% 
%         end
%         
%         if flagaux
%             attractors = real(attractors);
%             flag=1;
%             
%             disSOX2 = norm([1;0;0]-attractors(:,1),2);
%             disSOX2 = 1+(disSOX2/(1+disSOX2));
%             
%             disBRA = norm([0;1;0]-attractors(:,2),2);
%             disBRA = 1+(disBRA/(1+disBRA));
%             
%             disCDX2 = norm([0;0;1]-attractors(:,3),2);
%             disCDX2 = 1+(disCDX2/(1+disCDX2));
%             
%         else
%             attractors = real(attractorsaux);
%             parameter = allparameters;
%             parameter(parfitnumbers) = subparameter;
%             
%             disSOX2 = norm([1;0;0]-attractors(:,1),2);
%             disSOX2 = 1+(disSOX2/(1+disSOX2));
%             
%             disBRA = norm([0;1;0]-attractors(:,2),2);
%             disBRA = 1+(disBRA/(1+disBRA));
%             
%             disCDX2 = norm([0;0;1]-attractors(:,3),2);
%             disCDX2 = 1+(disCDX2/(1+disCDX2));
%         end
%         
% end

% attractors = real(attractors);

% attractorsaux


attractors = real(attractorsaux);

disSOX2 = norm([1;0;0]-attractors(:,1),2);
disSOX2 = 1+(disSOX2/(1+disSOX2));

disBRA = norm([0;1;0]-attractors(:,2),2);
disBRA = 1+(disBRA/(1+disBRA));

disCDX2 = norm([0;0;1]-attractors(:,3),2);
disCDX2 = 1+(disCDX2/(1+disCDX2));


% pause()
        
 %%   
%Simulate experiments with that parameter:
%----------------------------------------
eltime15s=0;
eltime23=0;
resall=0;
paramvalues = [];

simulatedEndTrajs = zeros(3,nExp);

if rank(attractors)<3
    flag=0;
end

% if (disSOX2>1.9) || (disBRA>1.9) || (disCDX2>1.9)
%     flag=0;
% end

% allfates = zeros(NSimulations+1,58,8);
% allparameters = zeros(NSimulations+1,length(parameter));
if flag
%     
%         parametervalueaux = parameter;                      
           
        [simulatedEndTrajs,ttrajs] = simulateexperiments_ODE_ATP(conditiontosimulate,subparameter,ExpDataStruct,initcondaux,Istar,nExp,dt,2);


% res = sqrt(sum(sum(([ExpDataStruct.MatrixData] - simulatedEndTrajs).^2)));
% simulatedFates = 100*simulatedFates(:,2:9)/nsimulations;

%     else
%         simulatedFates = sum(simulatedFates(:,:,logical(goodparameters)),3);
% %         simulatedFates = 100*simulatedFates(:,2:8)/sum(goodparameters);
% 
% %         res = sum(sum((AllMatProp(:,2:8)).^2))/(58*7);
% res = sqrt(sum(sum((AllMatProp(:,2:8)).^2)));
%     end

else
        simulatedEndTrajs = zeros(3,nExp);

%         res = sum(sum((AllMatProp(:,2:8)).^2))/(58*7);
%         res = sqrt(sum(sum(([ExpDataStruct.MatrixData] - simulatedEndTrajs).^2)));
    
end
% res=0;
% res = res;%*disSOX2*disBRA*disCDX2;
% res
% toc
% disp('functiontofit_v2: Finished')

