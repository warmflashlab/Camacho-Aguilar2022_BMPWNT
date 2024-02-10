

clear
load('MCMC_results_TimeCourse_ODE_v1.mat','AllAcceptedParameters','parfitnumbers','Istar')

parametervalue = AllAcceptedParameters(end);
paramBMPfunc = parametervalue.paramBMPfunc;

%For model v9
parametervalue.parammodel(20) = 0.8;


%%
BMPbeforeWNTvalues = [0,1];
tswapvalues = 4:2:72;

AllSolTrajs = cell(1,1);
AllTTrajs = cell(1,1);
AllLegends = cell(1,1);

%% mTeSR
BMPbeforeWNT = 1;
        BMPligandconc=0;
        BMPlevel = functionBMPlevel(BMPligandconc,paramBMPfunc);
%         BMPlevel=30/(1+1/BMPligandconc);
        WNTlevel = 0;
        NoginMedia=0;
        IWP2inMedia = 0;
        tswap = 72;
        TimeFixedAux = 96;
        tFaux = 96;

[soltraj,ttraj] = loadconditionPredictionBMPWNT(BMPbeforeWNT,BMPlevel,WNTlevel,NoginMedia,IWP2inMedia,tswap,TimeFixedAux,parametervalue,Istar,tFaux);

AllSolTrajs{1,1} = soltraj;
AllTTrajs{1,1} = ttraj;
AllLegends{1,1} = ['mTeSR'];

%% BMP 0-16
BMPbeforeWNT = 1;
        BMPligandconc=10;
        BMPlevel = functionBMPlevel(BMPligandconc,paramBMPfunc);
%         BMPlevel=30/(1+1/BMPligandconc);
        WNTlevel = 0;
        NoginMedia=0;
        IWP2inMedia = 0;
        tswap = 16;
        TimeFixedAux = 96;
        tFaux = 96;

[soltraj,ttraj] = loadconditionPredictionBMPWNT(BMPbeforeWNT,BMPlevel,WNTlevel,NoginMedia,IWP2inMedia,tswap,TimeFixedAux,parametervalue,Istar,tFaux);

AllSolTrajs{1,2} = soltraj;
AllTTrajs{1,2} = ttraj;
AllLegends{1,2} = ['BMP 0-16,mTeSR 16-48h'];
%% BMP 0-4,CHIR 4-72
BMPbeforeWNT = 1;
        BMPligandconc=10;
        BMPlevel = functionBMPlevel(BMPligandconc,paramBMPfunc);
%         BMPlevel=30/(1+1/BMPligandconc);
        WNTlevel = 2;
        NoginMedia=0;
        IWP2inMedia = 1;
        tswap = 4;
        TimeFixedAux = 96;
        tFaux = 96;

[soltraj,ttraj] = loadconditionPredictionBMPWNT(BMPbeforeWNT,BMPlevel,WNTlevel,NoginMedia,IWP2inMedia,tswap,TimeFixedAux,parametervalue,Istar,tFaux);

AllSolTrajs{1,3} = soltraj;
AllTTrajs{1,3} = ttraj;
AllLegends{1,3} = ['BMP+IWP2 0-4,CHIR1+IWP2 4-48h'];
%% CHIR 0-72
BMPbeforeWNT = 0;
        BMPligandconc=0;
        BMPlevel = functionBMPlevel(BMPligandconc,paramBMPfunc);
%         BMPlevel=30/(1+1/BMPligandconc);
        WNTlevel = 2;
        NoginMedia=0;
        IWP2inMedia = 0;
        tswap = 72;
        TimeFixedAux = 96;
        tFaux = 96;

[soltraj,ttraj] = loadconditionPredictionBMPWNT(BMPbeforeWNT,BMPlevel,WNTlevel,NoginMedia,IWP2inMedia,tswap,TimeFixedAux,parametervalue,Istar,tFaux);

AllSolTrajs{1,4} = soltraj;
AllTTrajs{1,4} = ttraj;
AllLegends{1,4} = ['CHIR 0-48h'];



save('Predictions_from_MCMC_results_TimeCourse_ODE_v1_CHIR_Fig7_New')
