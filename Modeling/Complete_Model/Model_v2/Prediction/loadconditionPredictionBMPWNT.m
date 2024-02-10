function [solendtraj,ttraj] = loadconditionPredictionBMPWNT(BMPbeforeWNT,BMPlevel,WNTlevel,NoginMedia,IWP2inMedia,tswap,TimeFixedaux,parameteraux,Istar,tFaux)



parametervalue = parameteraux.parammodel;
mTeSRBMPlevel = parameteraux.mTesrBMPlevel;
basalBMPlevel = parameteraux.basalBMPlevel;


odeopt = 2;
dt=0.001;





Signals = zeros(4,3);

if BMPbeforeWNT %it's BMP signal at the beginning
    
    initcond = [BMPlevel,0,Istar,0,0,1,0,0];
    Signals(:,1) = [basalBMPlevel+BMPlevel;0;IWP2inMedia;0];
    
    if tswap<24 %We assume media change is at 24h
    tCH1 = tswap*1.5;
    tCH2 = 24*1.5;
    tF = tFaux*1.5;
    Signals(:,2) = [basalBMPlevel+BMPlevel*mTeSRBMPlevel;NoginMedia;IWP2inMedia;WNTlevel];
    Signals(:,3) = [basalBMPlevel+BMPlevel*mTeSRBMPlevel;NoginMedia;IWP2inMedia;WNTlevel];
    
    elseif tswap==24 %We assume media change is at 24h
    tCH1 = tswap*1.5;
    tCH2 = tFaux*1.5;
    tF = tFaux*1.5;
    Signals(:,2) = [basalBMPlevel+BMPlevel*mTeSRBMPlevel;NoginMedia;IWP2inMedia;WNTlevel];
    Signals(:,3) = [basalBMPlevel+BMPlevel*mTeSRBMPlevel;NoginMedia;IWP2inMedia;WNTlevel];
    
    else
    tCH1 = 24*1.5;
    tCH2 = tswap*1.5;
    tF = tFaux*1.5;
    Signals(:,2) = [basalBMPlevel+BMPlevel;0;IWP2inMedia;0];
    Signals(:,3) = [basalBMPlevel+BMPlevel*mTeSRBMPlevel;NoginMedia;IWP2inMedia;WNTlevel];
    end
  
else
    
    initcond = [0,0,Istar,0,0,1,0,0];
    Signals(:,1) = [basalBMPlevel;0;IWP2inMedia;WNTlevel];
    
    if tswap<24 %We assume media change is at 24h
    tCH1 = tswap*1.5;
    tCH2 = 24*1.5;
    tF = tFaux*1.5;
    Signals(:,2) = [basalBMPlevel+BMPlevel;0;IWP2inMedia;0];
    Signals(:,3) = [basalBMPlevel+BMPlevel;0;IWP2inMedia;0];
    
    elseif tswap==24 %We assume media change is at 24h
    tCH1 = tswap*1.5;
    tCH2 = tFaux*1.5;
    tF = tFaux*1.5;
    Signals(:,2) = [basalBMPlevel+BMPlevel;0;IWP2inMedia;0];
    Signals(:,3) = [basalBMPlevel+BMPlevel;0;IWP2inMedia;0];
    
    else
    tCH1 = 24*1.5;
    tCH2 = tswap*1.5;
    tF = tFaux*1.5;
    Signals(:,2) = [basalBMPlevel;0;IWP2inMedia;WNTlevel];
    Signals(:,3) = [basalBMPlevel+BMPlevel;0;IWP2inMedia;0];
    end
     
    
end

tspan1 = 0:dt:tCH1;
tspan2 = tCH1:dt:tCH2;
tspan3 = tCH2:dt:tF;
[0,tCH1,tCH2,tF];
tspan = {tspan1,tspan2,tspan3};

[solendtraj,ttraj] = simulate_solution_det_eqtn_step_GRNModel_ATP_PRED(initcond,tspan,BMPlevel,mTeSRBMPlevel,basalBMPlevel,Signals,parametervalue,TimeFixedaux*1.5,odeopt);
solendtraj = real(solendtraj);
        
       
    
