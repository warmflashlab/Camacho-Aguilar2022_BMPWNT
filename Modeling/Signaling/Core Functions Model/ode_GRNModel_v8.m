function dydt=ode_GRNModel_v8(t,y,p)


%Parameters:
%-----------

% BMP response parameters
% -----------------------
% gamma     (1)
% delta     (2)
% beta      (3)
% deltai    (4)
% Noggin    (5)
% tau       (6)


% WNT response parameters 
% -----------------------
% SMAD4 ->WNTR
% aSW   (7)
% nSW   (8)  
% KSW   (9)  

% WNTR->WNTR
% aWW   (10)  
% nWW   (11)  
% KWW   (12)  

% WNTR-> 0
% dW    (13)

% WNTR-> bCat
% aWb   (14) 
% nWb   (15) 
% KWb   (16)

% bCat-> 0
% db   (17) 

% External WNT and WNT Inhibition
% IWP2 (18)
% WEx (19)
% aWPWEx (20)


% SOX2 parameters 
% ---------------
% aS    (21)
% nCS   (22)
% KCS   (23)

% nBS   (24)
% KBS   (25)

% aSmS  (26)
% nSmS  (27)
% KSmS  (28)

% dS    (29)


% BRA parameters 
% ---------------
% aB    (30)
% abB   (31)

% nSB   (32)
% KSB   (33)

% nCB   (34)
% KCB   (35)

% dB    (36)


% CDX2 parameters 
% ---------------
% aSmC  (37)
% nSmC  (38)
% KSmC  (39)

% aC    (40)

% nSC   (41)
% KSC   (42)

% nBC   (43)
% KBC   (44)

% aCC   (45)
% nCC   (46)
% KCC   (47)

% dC    (48)

% KbB   (49)
% nbB   (50)







Ds = 2;
% Ds=2.5;

%Variables:
%-----------
% y = [BMPL,SMAD4,BMPR,WNTRNA,bCat,SOX2,BRA,CDX2];

dydt = [
    
    % (1) BMP ligand
    p(6)*(-p(5)*y(1)*y(3)+p(1)*y(2));... 
    
    % (2) Nuclear SMAD4 
    (1/Ds)*p(6)*(p(5)*y(1)*y(3)-(p(1)+p(2))*y(2));...    
    
    % (3) Inactive BMP receptors
    p(6)*(p(3)-(p(4)+p(5)*y(1))*y(3)+p(1)*y(2));... 
    
    % (4) WNT RNA
    (1-p(18))*(p(7)*(y(2)^p(8) ) ./ ( p(9).^p(8)+(y(2).^p(8)) )  +  ( p(10) * (y(5).^p(11)) ) ./ ( p(12)^p(11)+ (y(5).^p(11)) )) + p(19)*p(20)  -  p(13)*y(4); ...  
    
    % (5) Nuclear bCat
    (p(14)*(y(4).^p(15)))./(p(16).^p(15)+y(4).^p(15))-p(17)*y(5);...
    
    % (6) SOX2
    (p(26)./(p(28).^p(27)+y(2).^p(27))) * ((p(21))./(1+(y(8)./p(23)).^p(22)+(y(7)./p(25)).^p(24))) -  p(29)*y(6); ...
        
    % (7) BRA
    p(31).*((y(5).^p(50))./(p(49).^p(50)+y(5).^p(50))).*(1./(1+(y(6)./p(33)).^p(32)+(y(8)./p(35)).^p(34))) -  p(36)*y(7); ... 
        
    % (8) CDX2
    p(37)*((y(2).^p(38))./(p(39).^p(38)+y(2).^p(38))) * (p(40)./(1+(y(6)./p(42)).^p(41)+(y(7)./p(44)).^p(43))) + p(45)*((y(8).^p(46))./(p(47).^p(46)+y(8).^p(46)))  -  p(48)*y(8)];
