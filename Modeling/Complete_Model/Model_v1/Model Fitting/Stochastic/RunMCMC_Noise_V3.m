%% MCMCfunction _ v1 Controls

clear all
close all

Ds = 1/2;%1.99;
dtb = 1.4;

load('MCMC_results_TimeCourse_ODE_v1.mat','AllAcceptedParameters','parametersim','parfitnumbers')
parameters = AllAcceptedParameters(end);
clear AllAcceptedParameters

%%
load('DataToFitTCv7-DataSet22_FitNoise_TimeCourse.mat')
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
                        
[LastCost,LastSimulatedTrajs] = function_SDE_proportions_fit(parameters,structtopass,nsimulations,D,propexpcov*expcov,[initcondsox2,0,0]);


AllAcceptedSimulatedTrajs = LastSimulatedTrajs;
AllAcceptedCosts = LastCost;
AllAcceptedNoises(1) = D;
AllAcceptedExpVar(1) = propexpcov;
AllAcceptedInitCond(1) = initcondsox2;
MCMCChain = [LastCost];

save('MCMC_results_TimeCourse_SDE_v3_p')

%%    
ct = AllAcceptedCosts(1);
naccepted = 1;

NewCandidatesigmasD = [0.01*D];
NewCandidatesignmasexpcov = 0.01*propexpcov;
NewCandidatesignmasinitcondsox2 = 0.01*initcondsox2;

parfitnew = 1:nparfit;
ii=2;
NewCandidateD = D;
NewCandidatepropexpcov = propexpcov;
NewCandidateinitcondsox2 = initcondsox2;


while ii <NdrawsMCMC

NewCandidateDaux = normrnd(NewCandidateD,NewCandidatesigmasD);
NewCandidatepropexpcovaux = normrnd(NewCandidatepropexpcov,NewCandidatesignmasexpcov);
NewCandidateinitcondsox2aux = normrnd(NewCandidateinitcondsox2,NewCandidatesignmasinitcondsox2);

    

if (sum([NewCandidateDaux,NewCandidatepropexpcovaux,NewCandidateinitcondsox2aux]<0)==0)

    [LastCost,LastSimulatedTrajs] = function_SDE_proportions_fit(parameters,structtopass,nsimulations,NewCandidateDaux,NewCandidatepropexpcovaux*expcov,[NewCandidateinitcondsox2aux,0,0]);

    MCMCChain(ii) = LastCost;
    
    if LastCost < ct
        naccepted = naccepted+1;
        ct = LastCost;
        NewCandidateD = NewCandidateDaux;
        NewCandidatepropexpcov = NewCandidatepropexpcovaux;
        NewCandidateinitcondsox2 = NewCandidateinitcondsox2aux;

AllAcceptedNoises(naccepted) = NewCandidateD;
AllAcceptedExpVar(naccepted) = NewCandidatepropexpcov;
AllAcceptedInitCond(naccepted) = NewCandidateinitcondsox2;

        AllAcceptedSimulatedTrajs(:,:,naccepted) = LastSimulatedTrajs;
        AllAcceptedCosts(naccepted) = ct;

        save('MCMC_results_TimeCourse_SDE_v3_p')
    end
    
    if rem(ii,50)==0
        save('MCMC_results_TimeCourse_SDE_v3_p')
        disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
    ii
    naccepted
    ct
    LastCost
    end
    ii=ii+1;
end

  
end

