%% MCMCfunction _ v1 Controls

clear all
close all

Ds = 1/2;%1.99;
dtb = 1.4;


load('MCMC_results_TimeCourse_SDE_v3.mat','parameters','parametersim','parfitnumbers','AllAcceptedNoises','AllAcceptedExpVar','AllAcceptedInitCond')


%%
load('ExpData.mat')
parfitnumbers = [21,22,23,24,25,27,28,29,31,32,33,34,35,36,37,38,39,41,42,43,44,45,46,47,48,49,50];
fitparamsmodel = 1;
fitmTeSRBMPlevels = 1;
fitbasalBMP = 0;
fitparamBMPfunc = 0;

%Initial condition in functions
initcond = [1,0,0];


for ii = 1:length(ExpDataStruct)
ExpDataStruct(ii).MatrixData = ExpDataStruct(ii).MatrixSimpData;

end

structtopass = struct('ExpDataStruct',ExpDataStruct,'AllMatProp',AllMatProp,'nExp',nExp,'parfitnumbers',parfitnumbers,'parameters',parametersim,'initcond',initcond);

% Weights
paramweights = [2,3,2,2,3];





%% Run MCMC (This)

NdrawsMCMC = 10000000;
NExp=structtopass.nExp; 

nsimulations = 1000;
D = 0.0001;

expcov = [0.0848 0.0072 0.0011;
    0.0072 0.001 0.0002;
    0.0011 0.0002 0.0004];

propexpcov = 1;


initcondsox2 = 1;


nparfit = length(parfitnumbers); 

rng(20);


tic


                          
[LastCost,LastSimulatedTrajs] = function_SDE_proportions_fit(parameters,structtopass,nsimulations,AllAcceptedNoises(end),AllAcceptedExpVar(end)*expcov,[AllAcceptedInitCond(end),0,0]);

AllAcceptedSimulatedTrajs = LastSimulatedTrajs;
AllAcceptedCosts = 0;
AllAcceptedParameters(1) = parameters;
MCMCChain = [0];

    
save('MCMC_results_TimeCourse_SDE_ODEControls_v3_AllSimulations')
