%% MCMCfunction _ v1 Controls

% Started from SDE_v6

%Fixed that when computing the CDX2 attractor, the initial condition was
%set to mTeSR level instead of BMPlevel

clear all
close all

Ds = 1/2;%1.99;
dtb = 1.4;

% *********************************
% *********************************
% Signal response parameters 
% *********************************
% *********************************

% BMP response parameters
% -----------------------
gammap = 5/Ds;
deltap = 1/Ds;
betap = 0.1;
deltai = 0.01;
Noggin = 0.1;
tau = 0.05;

% WNT response parameters 
% -----------------------
% SMAD4 -> WNTR
aSW = 0.3/3;
nSW = 2;
KSW =1.55;%sqrt(6);  

% bCat->WNTR
aWW = dtb*0.464/1.5; 
nWW = 3;  
KWW = 1.45;%1.5; 

% WNTR-> 0
dW = dtb*0.1/3; 


% WNTR-> bCat
aWb = dtb*0.6*2;      %(14) 
nWb = 2.5;%2;        %(15) 
KWb = 0.59;%0.5;      %(16)

% bCat-> 0
db = dtb*0.55*2;%0.5;       %(17) 

% External WNT and WNT Inhibition
IWP2 = 0;       %(18)
WEx = 0;        %(19)
aWPWEx = 0.1;   %(20)

% *********************************
% *********************************
% Fate marker expressionparameters 
% *********************************
% *********************************

DSOX2 = 1.1;                    %1
DBRA = 0.8;                     %1
DCDX2 = 1.5;                    %0.5
initcond = [0,0,0,1,0,0];

% SOX2 parameters 
% -----------------------
aS =  0.1/DSOX2 ; %(14)
nCS =  2; %(15)                 %3
KCS =  0.6/DCDX2; %(16)         %0.2/0.5

nBS  = 2; %(17)                 %3
KBS  = 0.3/DBRA; %(18)          %0.5

aSmS = 1;
nSmS = 1;  %(20)
KSmS = 0.8;  %(21)

dS  = 0.11 ; %(22)


% BRA parameters 
% -----------------------
aB  =  0;%0.01; %(23)
abB =  0.2/DBRA; %(24)

nSB =  3; %(25)
KSB =  0.4*1.1/DSOX2;%0.4/DSOX2;%1/2; %(26)    %0.6

nCB =  3; %(27)
KCB =  0.101/DCDX2; %(28)       %0.1/0.5

dB  =  0.12; %(32)              %0.1


% CDX2 parameters 
% -----------------------
aSmC=  1.5/DCDX2; %(34)         %1/0.5
nSmC = 2;                       %1
KSmC =0.9;                      %0.7

aC = 1*0.1;

nSC =  3; %(35)                 %4
KSC =  0.42/DSOX2; %(36)         %0.5

nBC =  2; %(37)                 
KBC =  0.3*1.5/DBRA;%0.4/DBRA; %(38)

aCC = 0.5/DCDX2; %(39)          %1.2*0.1/0.5
nCC = 3;  %(40)
KCC = 0.45/DCDX2; %(41)         %0.2/0.5

dC  =  3*0.1; %(42)

KbB = 0.6;
nbB = 4;



Istar =  betap/deltai;%betap*(gammap+deltap)/(deltap*deltai+gammap*deltai)
parametersim = [gammap,deltap,betap,deltai,Noggin,tau,  aSW,nSW,KSW,  aWW,nWW,KWW,  dW,  aWb,nWb,KWb,  db,   IWP2,WEx,aWPWEx,       aS,nCS,KCS,   nBS,KBS,aSmS,nSmS,KSmS,  dS,  aB,abB,   nSB,KSB,   nCB,KCB,  dB,   aSmC,nSmC,KSmC, aC,  nSC,KSC,  nBC,KBC,  aCC,nCC,KCC,dC,KbB,nbB];

load('/Users/elenacamachoaguilar/Dropbox (Personal)/Rice/Experiments/Modelling/BMP_CommitmentTime/GRN_Model_v8_SMAD4Decay_BistableWNT_NonlinearbCatBRA_FateMarkers/ODE_Fitting_Controls/MCMC_results_TimeCourse_ODE_v1.mat','AllAcceptedParameters')

%%

load('/Users/elenacamachoaguilar/Dropbox (Personal)/Rice/Experiments/Modelling/BMP_CommitmentTime/GRN_Model_v7_SMAD4Decay_BistableWNT_FateMarkers/ExperimentalDatatoFit/TimeCourseData/DataToFitTCv7-DataSet21_TimeCourse_Concentrations_Controls.mat')
parfitnumbers = [21,22,23,24,25,27,28,29,31,32,33,34,35,36,37,38,39,41,42,43,44,45,46,47,48,49,50];
fitparamsmodel = 1;
fitmTeSRBMPlevels = 1;
fitbasalBMP = 0;
fitparamBMPfunc = 0;

%Initial condition in functions
initcond = [1,0,0];

% Use simplified data!!!!!!!!!!!!

for ii = 1:length(ExpDataStruct)
ExpDataStruct(ii).MatrixData = ExpDataStruct(ii).MatrixSimpData;

end

structtopass = struct('ExpDataStruct',ExpDataStruct,'AllMatProp',AllMatProp,'nExp',nExp,'parfitnumbers',parfitnumbers,'parameters',parametersim,'initcond',initcond);

% Weights
paramweights = [2,3,2,2,3];



%% Run MCMC

NdrawsMCMC = 10000000;
% Ndrawsperparameter = 4000;
NExp=structtopass.nExp; 

mTeSRprop = AllAcceptedParameters(end).mTesrBMPlevel;%0.1;
basalBMPlevel = AllAcceptedParameters(end).basalBMPlevel;
paramBMPfunc = AllAcceptedParameters(end).paramBMPfunc;
x0 = AllAcceptedParameters(end).parammodel;



nparfit = length(parfitnumbers); %Not fitting basalBMPlevel

rng(20);

%First step MCMC
% profile on
tic

parameters.parammodel = x0';
parameters.mTesrBMPlevel = mTeSRprop;
parameters.basalBMPlevel = basalBMPlevel;
parameters.paramBMPfunc = paramBMPfunc;


[LastCost,LastSimulatedTrajs] = functiontofit_ODE_5weighted(parameters,structtopass,paramweights);

%%

ExpDataStruct(end).MatrixData = [0;1;0];

sqrt(sum(([ExpDataStruct.MatrixData] - LastSimulatedTrajs).^2))
