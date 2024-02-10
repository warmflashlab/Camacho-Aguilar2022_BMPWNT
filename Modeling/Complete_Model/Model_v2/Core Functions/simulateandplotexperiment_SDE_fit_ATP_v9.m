function [solendtraj,ttraj,fatevector,propsfates] = simulateandplotexperiment_SDE_fit_ATP_v9(attractors,conditiontosimulate,paramstruct,ExpDataStruct,Istar,nsimulations,noisecov,expcov,dt,odeopt,initcondsim)

%% Chaged v3 for corrected BMPraw

%% SDE fitting




parametervalue = paramstruct.parammodel;
mTeSRBMPlevel = paramstruct.mTesrBMPlevel;
basalBMPlevel = paramstruct.basalBMPlevel;

paramBMPfunc = paramstruct.paramBMPfunc;

% attractors = zeros(3,3);
% %Compute attractors:
% %------------------
% 
%     %SOX2
%     SMAD40 = 0;
%     bCat0 = 0;
%     paramattractors = parametervalue;
%     paramattractors(1) = SMAD40;
%     paramattractors(2) = bCat0;
%     [attractorsaux,nattractorspresent] = computeattractors(paramattractors);
%     if nattractorspresent(1)==0
%         disp('SOX2')
%         flag=0;
%     else
%         attractors(:,1) = attractorsaux(:,1);
%     end
%     
%     %BRA
%     SMAD40 = 0;
%     bCat0 = 1;
%     paramattractors = parametervalue;
%     paramattractors(1) = SMAD40;
%     paramattractors(2) = bCat0;
%     [attractorsaux,nattractorspresent] = computeattractors(paramattractors);
%     if nattractorspresent(2)==0
%         disp('BRA')
%         flag=0;
%     else
%     attractors(:,2) = attractorsaux(:,2);
% 
%     end
% 
%     %CDX2
%     SMAD40 = 1;
%     bCat0 = 0;
%     paramattractors = parametervalue;
%     paramattractors(1) = SMAD40;
%     paramattractors(2) = bCat0;
%     [attractorsaux,nattractorspresent] = computeattractors(paramattractors);
% 
%     if nattractorspresent(3)==0
%         disp('CDX2')
%         flag=0;
%     else
%     attractors(:,3) = attractorsaux(:,3);
% 
%     end
    
% attractors


for ii = conditiontosimulate
 ii
        % Simulate experiment
        % -------------------
        
         tCH1 = ExpDataStruct(ii).tCH1raw*1.5;
        tCH2 = ExpDataStruct(ii).tCH2raw*1.5;
        BMPlevel = ExpDataStruct(ii).BMPlevelraw;
        BMPlevel = functionBMPlevel(BMPlevel,paramBMPfunc);
        tF = 48*1.5;
        
        initcondSignals = [BMPlevel,0,Istar,0,0];
        initcondGRN = mvnrnd(initcondsim,expcov,nsimulations)';
        initcondGRN = abs(initcondGRN);
        
        tspan1 = 0:dt:tCH1;
        tspan2 = tCH1:dt:tCH2;
        tspan3 = tCH2:dt:tF;
        tspan = {tspan1,tspan2,tspan3};
        Signals = ExpDataStruct(ii).Signals;
%         [tplot,solendtraj]=solution_det_eqtn_step_GRNModel_v7(initcond,tspan,Signals,parametervalue,[1,0,0],1);
%         solendtraj(6:8,end)    
%
        [solendtraj,ttraj,finalsol] = simulate_SDEsolution_det_eqtn_step_GRNModel_ATP_v9(initcondSignals,initcondGRN,tspan,Signals,parametervalue,ExpDataStruct(ii).TimeFixedaux*1.5,odeopt,nsimulations,noisecov,BMPlevel,mTeSRBMPlevel,basalBMPlevel);
        solendtraj = real(solendtraj);
%         size(solendtraj)
% sum(sum(real(finalsol(6:end,:))-squeeze(solendtraj(6:8,:,end))))
            
            %Classify cell:
            %--------------
%             attractors
propsfates=classifycell_v3(real(finalsol(6:end,:)),nsimulations,attractors);
            [fatevector,propsfates] = classifycell_plotfit(squeeze(solendtraj(6:8,:,end)),nsimulations,attractors);
propsfates
            %             
%             %Save fate:
%             %---------
%             fatesExperiments(ii,:) = fatevector;
    
end





