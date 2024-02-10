function [tplot,yplot] = loadconditionSignals_v8(conditionnumber,p,I0,initcondGRN)
dt = 0.01;
colors = distinguishable_colors(8,{'w','k'});
tCH = 36/1.5;
tF = 72/1.5;
% I0 = 4;

pmodel = p.parammodel;
mBMPlevel = p.mTesrBMPlevel;
bBMPlevel = p.basalBMPlevel;
pBMPF = p.paramBMPfunc;

switch conditionnumber

    case 1  %BMP 0-8h, mTeSR 8-48h
        
        tCH1 = 12/1.5;
        tCH2 = 36/1.5;
        x=10;
        BMPlevel = functionBMPlevel(x,pBMPF);
%         BMPlevel=18;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
        tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2,tspan3};
        Signals = [0,1,1;...
                   0,0,0;...
                   0,0,0;...
                   0,0,0];     
        colorcond = colors(1,:);
%         
%         initcond = [0,0,I0];
%         tspan1 = [0:dt:tCH];
%         tspan2 = [tCH:dt:tF];
%         Signals = [0,0,1]%;[0.1,0.1,1];        
%         colorcond = colors(4,:);
        
    case 2  %BMP 0-16h, mTeSR 16-48h
        
        tCH1 = 24/1.5;
        tCH2 = 36/1.5;
        x=10;
        BMPlevel = 1./(1+1./x)*30;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
        tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2,tspan3};
        Signals = [0,1,1;...
                   0,0,0;...
                   0,0,0;...
                   0,0,0];
        colorcond = colors(2,:);
        
    case 3  %BMP 0-32h, mTeSR 32-48h
        
        tCH1 = 36/1.5;
        tCH2 = 48/1.5;
        x=10;
        BMPlevel = 1./(1+1./x)*30;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
        tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2,tspan3};
        Signals = [0,0,1;...
                   0,0,0;...
                   0,0,0;...
                   0,0,0];
        colorcond = colors(3,:);
        
    case 4  %BMP 0-48h
        
        tCH1 = 36/1.5;
        tCH2 = tF;
        x=10;
        BMPlevel = 1./(1+1./x)*30;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
%         tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2};
        Signals = [0,0;...
                   0,0;...
                   0,0;...
                   0,0];
        colorcond = colors(4,:);
        
    case 5  %mTeSR 0-48h
        
        tCH1 = 36/1.5;
        tCH2 = tF;
        x=10;
        BMPlevel = 1./(1+1./x)*30;
        
        
        initcond = [mBMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
        tspan = {tspan1,tspan2};
        Signals = [1,1;...
                   0,0;...
                   0,0;...
                   0,0];
        colorcond = colors(5,:);
        
    case 6 %BMP 0-32h, Noggin 32-48h
        
        tCH1 = 36/1.5;
        tCH2 = 48/1.5;
        x=10;
        BMPlevel = 1./(1+1./x)*30;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
        tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2,tspan3};
        Signals = [0,0,1;...
                   0,0,1;...
                   0,0,0;...
                   0,0,0];
        colorcond = colors(6,:);
        
    case 7  %BMP 0-16h, mTeSR 16-48h
        
        tCH1 = 24/1.5;
        tCH2 = 36/1.5;
        x=10;
        BMPlevel = 1./(1+1./x)*30;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
        tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2,tspan3};
        Signals = [0,1,1;...
                   0,1,1;...
                   0,0,0;...
                   0,0,0];
        colorcond = colors(7,:);
        
    case 8   %BMP 0-8h, mTeSR 8-48h
        
        tCH1 = 12/1.5;
        tCH2 = 36/1.5;
        x=10;
        BMPlevel = 1./(1+1./x)*30;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
        tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2,tspan3};
        Signals = [0,1,1;...
                   0,1,1;...
                   0,0,0;...
                   0,0,0];
        colorcond = colors(8,:);
        
      case 9  %2
        
        tCH1 = 36/1.5;
        tCH2 = tF;
        x=2;
        BMPlevel = 1./(1+1./x)*30;
%         BMPlevel=18;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
%         tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2};
        Signals = [0,0;...
                   0,0;...
                   0,0;...
                   0,0];  
        colorcond = colors(1,:);
%         
%         initcond = [0,0,I0];
%         tspan1 = [0:dt:tCH];
%         tspan2 = [tCH:dt:tF];
%         Signals = [0,0,1]%;[0.1,0.1,1];        
%         colorcond = colors(4,:);
        
      case 10  %5
        
        tCH1 = 36/1.5;
        tCH2 = tF;
        x=5;
        BMPlevel = 1./(1+1./x)*30;
%         BMPlevel=18;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
%         tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2};
        Signals = [0,0;...
                   0,0;...
                   0,0;...
                   0,0];  
        colorcond = colors(1,:);
%         
%         initcond = [0,0,I0];
%         tspan1 = [0:dt:tCH];
%         tspan2 = [tCH:dt:tF];
%         Signals = [0,0,1]%;[0.1,0.1,1];        
%         colorcond = colors(4,:);  
      case 11  %10
        
        tCH1 = 36/1.5;
        tCH2 = tF;
        x=10;
        BMPlevel = 1./(1+1./x)*30;
%         BMPlevel=18;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
%         tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2};
        Signals = [0,0;...
                   0,0;...
                   0,0;...
                   0,0];
        colorcond = colors(1,:);
%         
%         initcond = [0,0,I0];
%         tspan1 = [0:dt:tCH];
%         tspan2 = [tCH:dt:tF];
%         Signals = [0,0,1]%;[0.1,0.1,1];        
%         colorcond = colors(4,:);   

case 12  %50
        
        tCH1 = 36/1.5;
        tCH2 = tF;
        x=50;
        BMPlevel = 1./(1+1./x)*30;
%         BMPlevel=18;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
%         tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2};
        Signals = [0,0;...
                   0,0;...
                   0,0;...
                   0,0];  
        colorcond = colors(1,:);
%         
%         initcond = [0,0,I0];
%         tspan1 = [0:dt:tCH];
%         tspan2 = [tCH:dt:tF];
%         Signals = [0,0,1]%;[0.1,0.1,1];        
%         colorcond = colors(4,:); 

case 13  %1
        
        tCH1 = 36/1.5;
        tCH2 = tF;
        x=1;
        BMPlevel = 1./(1+1./x)*30;
%         BMPlevel=18;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
%         tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2};
        Signals = [0,0;...
                   0,0;...
                   0,0;...
                   0,0];  
        colorcond = colors(1,:);
%         
%         initcond = [0,0,I0];
%         tspan1 = [0:dt:tCH];
%         tspan2 = [tCH:dt:tF];
%         Signals = [0,0,1]%;[0.1,0.1,1];        
%         colorcond = colors(4,:); 

case 14  %1.5
        
        tCH1 = 36/1.5;
        tCH2 = tF;
        x=1.5;
        BMPlevel = 1./(1+1./x)*30;
%         BMPlevel=18;
        
        
        initcond = [BMPlevel,0,I0,0,0];
        tspan1 = [0:dt:tCH1];
        tspan2 = [tCH1:dt:tCH2];
%         tspan3 = [tCH2:dt:tF];
        tspan = {tspan1,tspan2};
        Signals = [0,0;...
                   0,0;...
                   0,0;...
                   0,0];  
        colorcond = colors(1,:);
%         
%         initcond = [0,0,I0];
%         tspan1 = [0:dt:tCH];
%         tspan2 = [tCH:dt:tF];
%         Signals = [0,0,1]%;[0.1,0.1,1];        
%         colorcond = colors(4,:); 
        
end

BMPlevel = functionBMPlevel(x,pBMPF);
initcond = [initcond,initcondGRN];
[yplot,tplot]=simulate_solution_det_eqtn_step_GRNModel_ATP(initcond,tspan,BMPlevel,mBMPlevel,bBMPlevel,Signals,pmodel,tF,2);