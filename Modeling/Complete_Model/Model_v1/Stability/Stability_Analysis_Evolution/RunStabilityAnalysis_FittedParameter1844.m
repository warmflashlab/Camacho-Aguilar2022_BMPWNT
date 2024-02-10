
%%  RESULTS WITH NON-INTEGER COEFFICIENTS Method 4 MORE EXHAUSTIVE SEARCH v4
clear

%%
load(['MCMC_results_TimeCourse_ODE_v1.mat'])

%%
nacceptedpar = length(AllAcceptedCosts);

significantchangesdistances = [1,996,1006,1844,2541,4463,6910,nacceptedpar];


accepterparameternumber  = 4

mTesrBMPlevel = AllAcceptedParameters(significantchangesdistances(accepterparameternumber)).mTesrBMPlevel;
basalBMPlevel = AllAcceptedParameters(significantchangesdistances(accepterparameternumber)).basalBMPlevel;
paramBMPfunc = AllAcceptedParameters(significantchangesdistances(accepterparameternumber)).paramBMPfunc;
parameter = AllAcceptedParameters(significantchangesdistances(accepterparameternumber)).parammodel;
%% Find attractors


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
%         solendtraj
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
%         solendtraj
        [root,stability,fate,flagg] = findrootGRN_stabilityanalysis(solendtraj(6:8),paramattractors,2);

        
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
        [root,stability,fate,flagg] = findrootGRN_stabilityanalysis(solendtraj(6:8),paramattractors,2);

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
        [root,stability,fate,flagg] = findrootGRN_stabilityanalysis(solendtraj(6:8),paramattractors,2);

        if (fate==3)&&(stability==1)
            attractorsaux(:,3) = root;
        else
            disp('CDX2')
            flag=0;
            disCDX2=2;

        end
        
        
attractorsaux = real(attractorsaux)
        
        
        
%% IC generators
attractorSOX2 = attractorsaux(:,1);
attractorBRA = attractorsaux(:,2);
attractorCDX2 = attractorsaux(:,3);

npointsdist = 4;
x = linspace(0,attractorSOX2(1),npointsdist);
y = linspace(0,attractorBRA(2),npointsdist);
z = linspace(0,attractorCDX2(3),npointsdist);

[X,Y,Z] = meshgrid(x,y,z);

%% Compute attractors

tic
method=4

BMPvalues = [0:0.005:1.5];
WNTvalues = [0:0.005:1.5];

cellstability = cell(length(BMPvalues),length(WNTvalues));
nstablepointsmatrix = zeros(length(BMPvalues),length(WNTvalues));
Ntrialsall = cell(length(BMPvalues),length(WNTvalues));
stabilityall = cell(length(BMPvalues),length(WNTvalues));

for BMPii = 1:length(BMPvalues)
    BMPvalues(BMPii)
    for WNTii = 1:length(WNTvalues)
        
% BMPvalues(BMPii)
% WNTvalues(WNTii)
        [criticalpoints,Ntrialscritpoints,stability] = findcriticalpoints_v4(npointsdist,X,Y,Z,parameter,BMPvalues(BMPii),WNTvalues(WNTii),method);

            
           cellstability{BMPii,WNTii} = criticalpoints;
           Ntrialsall{BMPii,WNTii} = Ntrialscritpoints;
           nstablepointsmatrix(BMPii,WNTii) = size(criticalpoints,2);
            stabilityall{BMPii,WNTii} = stability;
    end
    
end

eltime = toc

% Allcellstability{accepterparameternumber} = cellstability;
% AllNtrialsall{accepterparameternumber} = Ntrialsall;
% Allnstablepointsmatrix{accepterparameternumber} =nstablepointsmatrix;
% Allstabilityall{accepterparameternumber} = stability;

%% Clean cellstability & only save stable points

% cellstability = Allcellstability{end};
% Ntrialsall = AllNtrialsall{end};
% nstablepointsmatrix = Allnstablepointsmatrix{end} ;
% stability = Allstabilityall{end};

BMPvalues = [0:0.005:1.5];
WNTvalues = [0:0.005:1.5];

cellstabilityclean = cell(length(BMPvalues),length(WNTvalues));
nstablepointsmatrixclean = zeros(length(BMPvalues),length(WNTvalues));
Ntrialsallclean = cell(length(BMPvalues),length(WNTvalues));
stabilityclean = cell(length(BMPvalues),length(WNTvalues));

for BMPii = 1:length(BMPvalues)
    BMPvalues(BMPii);
    for WNTii = 1:length(WNTvalues)
        
SMAD40 = BMPvalues(BMPii);
bCat0 = WNTvalues(WNTii);
paramattractors = parameter;
paramattractors(1) = SMAD40;
paramattractors(2) = bCat0;

criticalpoints = cellstability{BMPii,WNTii};
critpointsaux = [];
Ntrialscritpointsaux = [];
stabilitycleanaux = [];

        for ii = 1:size(criticalpoints,2)
            
            root = criticalpoints(:,ii);
            stabilityaux = computestability(root,paramattractors);
            
            if stabilityaux == 1
                            if isempty(critpointsaux)
                                critpointsaux = [critpointsaux,root];
                                Ntrialscritpointsaux =[Ntrialscritpointsaux,Ntrialsall{BMPii,WNTii}(ii)];
                                stabilitycleanaux = [stabilitycleanaux,computestability(root,paramattractors)];
                            else
                                
                                flagexistingcp = 1;
                                ncritpoints = size(critpointsaux,2)+1;
                                counter = 1;
                                while (flagexistingcp)&&(counter<ncritpoints)
                                    dis2critpoint = norm(root-critpointsaux(:,counter),2);
                                    
                                    if dis2critpoint<2*1.0e-2
                                        flagexistingcp=0;
                                    end
                                    counter=counter+1;
                                end
                                
                                if flagexistingcp
                                    critpointsaux = [critpointsaux,root];
                                    Ntrialscritpointsaux =[Ntrialscritpointsaux,Ntrialsall{BMPii,WNTii}(ii)];
                                    stabilitycleanaux = [stabilitycleanaux,computestability(root,paramattractors)];
                                end
                                
                                
                            end
            end
            
        end
        
        [stabilityclean{BMPii,WNTii},indaux] = sort(stabilitycleanaux);
        
           cellstabilityclean{BMPii,WNTii} = critpointsaux(:,indaux);
           Ntrialsallclean{BMPii,WNTii} = Ntrialscritpointsaux(indaux);
           nstablepointsmatrixclean(BMPii,WNTii) = size(critpointsaux,2);
           stabilityclean{BMPii,WNTii} = stabilitycleanaux;
            

            
    end
    
end

% eltime = toc
% save('StabilityAnalysis_FittedParameter1844')


