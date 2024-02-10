function [cost,fatesExperiments] = simulateexperiments_SDE_fit(paramstruct,attractors,ExpDataStruct,Istar,nExps,nsimulations,noisecov,expcov,dt,odeopt,initcondsim)
                                                    
                                                        

%% SDE fitting

fatesExperiments = zeros(nExps,8);


parametervalue = paramstruct.parammodel;
mTeSRBMPlevel = paramstruct.mTesrBMPlevel;
basalBMPlevel = paramstruct.basalBMPlevel;

paramBMPfunc = paramstruct.paramBMPfunc;


costs = zeros(1,nExps);

for ii = 1:nExps
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

        [solendtrajaux,ttrajaux,finalsol] = simulate_SDEsolution_det_eqtn_step_GRNModel_ATP(initcondSignals,initcondGRN,tspan,Signals,parametervalue,ExpDataStruct(ii).TimeFixedaux*1.5,odeopt,nsimulations,noisecov,BMPlevel,mTeSRBMPlevel,basalBMPlevel);
        solendtraj = real(finalsol(6:end,:));


            
            %Classify cell:
            %--------------
            fatevector = classifycell_v3(solendtraj,nsimulations,attractors);
            fatevector*100/nsimulations
            
            %Save fate:
            %---------
            fatesExperiments(ii,:) = fatevector;
            costs(ii) = sqrt(sum((ExpDataStruct(ii).MatrixProp-fatevector*100/nsimulations).^2));
            
    
end


cost = sum(costs);


