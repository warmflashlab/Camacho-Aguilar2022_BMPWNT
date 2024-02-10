function [solendtraj,ttraj] = simulateexperiments_ODE_ATP(conditiontosimulate,paramstruct,ExpDataStruct,initcondaux,Istar,nExps,dt,odeopt)
%% SDE fitting

EndtrajsExperiments = zeros(3,nExps);

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


for ii = conditiontosimulate%1:nExps
%  ii
        % Simulate experiment
        % -------------------      
        tCH1 = ExpDataStruct(ii).tCH1raw*1.5;
        tCH2 = ExpDataStruct(ii).tCH2raw*1.5;
        BMPlevel = ExpDataStruct(ii).BMPlevelraw;
        BMPlevel = functionBMPlevel(BMPlevel,paramBMPfunc);
        tF = 72*1.5;
        
        initcond = [BMPlevel,0,Istar,0,0,initcondaux];
        
        tspan1 = 0:dt:tCH1;
        tspan2 = tCH1:dt:tCH2;
        tspan3 = tCH2:dt:tF;
        tspan = {tspan1,tspan2,tspan3};
        Signals = ExpDataStruct(ii).Signals;
%         [tplot,solendtraj]=solution_det_eqtn_step_GRNModel_v7(initcond,tspan,Signals,parametervalue,[1,0,0],1);
%         solendtraj(6:8,end)    
% ii

                                                                
        [solendtraj,ttraj] = simulate_solution_det_eqtn_step_GRNModel_ATP(initcond,tspan,BMPlevel,mTeSRBMPlevel,basalBMPlevel,Signals,parametervalue,ExpDataStruct(ii).TimeFixedaux*1.5,odeopt);
        solendtraj = real(solendtraj);
%         solendtraj = solendtraj(6:8);
%         if plotopt
%             if ii==36
%             if odeopt
% 
%             solendtraj(6:8)
%             scatter3(solendtraj(6),solendtraj(7),solendtraj(8),20,'filled','MarkerEdgeColor','b','MarkerFaceColor','b')
%             hold on
%             scatter3(attractors(1,1),attractors(1,2),attractors(1,3),20,'filled','MarkerEdgeColor','k','MarkerFaceColor','k')
%             scatter3(attractors(2,1),attractors(2,2),attractors(2,3),20,'filled','MarkerEdgeColor','k','MarkerFaceColor','k')
%             scatter3(attractors(3,1),attractors(3,2),attractors(3,3),20,'filled','MarkerEdgeColor','k','MarkerFaceColor','k')
%             
%             else
%             solendtraj(6:8)
%             hold on
%             scatter3(solendtraj(6),solendtraj(7),solendtraj(8),20,'filled','MarkerEdgeColor','r','MarkerFaceColor','r')
% %             scatter3(attractors(1,1),attractors(1,2),attractors(1,3),20,'filled','MarkerEdgeColor','k','MarkerFaceColor','k')
% %             scatter3(attractors(2,1),attractors(2,2),attractors(2,3),20,'filled','MarkerEdgeColor','k','MarkerFaceColor','k')
% %             scatter3(attractors(3,1),attractors(3,2),attractors(3,3),20,'filled','MarkerEdgeColor','k','MarkerFaceColor','k')
%             end
%             end
%                 
%         end
        %       solendtraj(6:8)
        % Compute fate
        % ------------
            
%             %Classify cell:
%             %--------------
% %             attractors
% 
%             endtrajvector = classifycell_v3(solendtraj,nsimulations,attractors);
            
            %Save fate:
            %---------
%             EndtrajsExperiments(:,ii) = solendtraj;
            
            
    
end





