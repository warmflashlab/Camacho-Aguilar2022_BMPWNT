function [AllXsol,Alltvsol,finalXsol]=simulate_SDEsolution_det_eqtn_step_GRNModel_ATP(initcondSignals,initcondGRN,tspan,Signals,p,tsol,odeopt,nsimulations,noisecov,BMPlevels,mTeSRBMPlevel,basalBMPlevel)

%tspan is a string containing the tspans between media changes
% Signals is a vector that contains the BMP ligand values for each tspan on
% the first row, the Noggin values for each tspan on the second row, the
% IWP2 value on the third row and WNTEx on the fourth row.

timeplot = [];
yplot = [];

flag=1;

AllXsol = [];
Alltvsol = [];

if length(tspan) == size(Signals,2)
   
    ii = 1;
  

while flag 

      
    if ii==1
        y0 = initcondSignals;
        Xs0 = initcondGRN;

AllXsol = [repmat(initcondSignals',1,nsimulations);initcondGRN];
Alltvsol = tspan{ii}(1);

    else
        y0 = solauxsignals.y(:,end);
        y0(1) = basalBMPlevel+BMPlevels*mTeSRBMPlevel^(Signals(1,ii)>0); %Media change changes the ligand value
        y0(3) = (1-Signals(2,ii))*y0(3); %Media change might introduce Noggin, inhibiting the free BMP receptors
        Xs0 = solauxgrn(6:end,:,end);
    end

    %Changes in parameters
    p(18) = Signals(3,ii);  %IWP2 in the media
    p(19) = Signals(4,ii);  %WNTEx in the media
    if Signals(2,ii) %If there is Noggin in the media, BMP Ligand can't attach to free BMP receptors
        p(5)=0;
    end

    y0signals = y0(1:5);

    solauxsignals = solution_det_eqtn_ONLYSIGNALS_GRNModel_v8(y0signals,tspan{ii},p,odeopt);
    solsignals = deval(solauxsignals,tspan{ii});

    Xs0 = [repmat(solsignals(:,1),1,nsimulations);Xs0];
    [solauxgrn,tvsol,flag] = solution_Euler_det_eqtn_GRNModel_v8_AllTimePoints(Xs0,tspan{ii},solsignals,p,tsol,nsimulations,noisecov);
    

    AllXsol = cat(3,AllXsol,solauxgrn);
    Alltvsol = [Alltvsol,tvsol];
    ii=ii+1;


end




else
    
    disp('Incorrect sizes tspan and Signals parameters')
    
end

finalXsol = solauxgrn(:,:,end);


