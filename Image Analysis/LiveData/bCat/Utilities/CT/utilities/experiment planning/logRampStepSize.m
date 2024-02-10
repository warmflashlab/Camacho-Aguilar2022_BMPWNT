clear;
fC = 10; %final concentration
nSteps = 7; %number of steps
tV = 100; %total volume added
stepMultiplier = 2; %how much to increase successive steps by in relation to previous step
% x = logRampStepSize(nSteps,stepMultiplier,tV)
% 


% approximation
% firstStep = 1.56;
% cTotals = logspace(log10(firstStep),log10(tV),nSteps);%commulative totals
% steps = diff(cTotals);
% steps = [steps(1) steps];
% sum(steps);

%
% linear
figure; clf;
cTotals = linspace(0,tV,nSteps+1);%commulative totals
steps = diff(cTotals);
round(steps,2)

y(1,:) = [cTotals(1) cTotals(1) cTotals(2) cTotals(2) cTotals(3) cTotals(3) ...
    cTotals(4) cTotals(4) cTotals(5) cTotals(5) cTotals(6) cTotals(6) ...
    cTotals(7) cTotals(7) cTotals(8) cTotals(8) ];
x = [-2 0 0 2 2 4 4 6 6 8 8 10 10 12 12 15];
%hold on; plot(x,y);
%
% log2
firstStep = 1.56;
cTotals = logspace(log10(firstStep),log10(tV),nSteps);%commulative totals
steps = diff(cTotals);
steps = [tV-sum(steps) steps];
round(steps,2)


cTotals = [cTotals;cTotals];
cTotals = reshape(cTotals,1,14);
y(2,:) = [0 0 cTotals ];
% 
% y = [0 0 cTotals(1) cTotals(1) cTotals(2) cTotals(2) cTotals(3) cTotals(3) ...
%     cTotals(4) cTotals(4) cTotals(5) cTotals(5) cTotals(6) cTotals(6) ...
%     cTotals(7) cTotals(7) ];
x = [-2 0 0 2 2 4 4 6 6 8 8 10 10 12 12 15];
%hold on; plot(x,y);

%
firstStep = 6;
nSteps = 7;
cTotals = logspace(log10(firstStep),log10(tV),nSteps);%commulative totals
steps = diff(cTotals);
steps = [tV-sum(steps) steps];
round(steps,2)


cTotals = [cTotals;cTotals];
cTotals = reshape(cTotals,1,numel(cTotals));
x = 0:2:12;
x = [x;x];
x = reshape(x,1,numel(x));
x = [-2 x 15];
y(3,:) = [0 0 cTotals ];
%plot(x,y);
%legend('7 linear steps','7 log2 steps','new log steps');


%
% log2
firstStep = 14.2857;
cTotals = logspace(log10(firstStep),log10(tV),nSteps);%commulative totals
steps = diff(cTotals);
steps = [tV-sum(steps) steps];
round(steps,2)


cTotals = [cTotals;cTotals];
cTotals = reshape(cTotals,1,14);
y(4,:) = [0 0 cTotals ];
% 
% y = [0 0 cTotals(1) cTotals(1) cTotals(2) cTotals(2) cTotals(3) cTotals(3) ...
%     cTotals(4) cTotals(4) cTotals(5) cTotals(5) cTotals(6) cTotals(6) ...
%     cTotals(7) cTotals(7) ];
x = [-2 0 0 2 2 4 4 6 6 8 8 10 10 12 12 15];
%hold on; plot(x,y);

plot(x,y./10);
legend('linear steps', 'log2 steps (ramp4)', 'log steps, higher first step (ramp3)',' log steps, (highest first step) (ramp2)');

%%

% 
% 
% function [additions] = logRampStepSize(nSteps,stepMultiplier,tV)
% % additions = volume to add at each step's timepoint
% % nSteps = total number of step additions
% % stepMultipler = relationship of proceeding steps to previous steps
% 
% additions = zeros(1,nSteps);
% additions(nSteps) = tV/stepMultiplier;
% iStep = nSteps;
% for ii = 1:nSteps
%     
%     additions(ii) = tV/(stepMultiplier^iStep);
%     iStep = iStep - 1;
%     if ii == nSteps;
%         additions(1) = additions(2);
%     end
% end
% additions = round(additions,2);
% disp(['for step multipler of ' num2str(stepMultiplier) ' with ' int2str(nSteps) ' steps,']);
% disp(['additions will be: ' num2str(additions)]);
% disp(['total media added is: ' int2str(sum(additions))]);
% % determine cumulative concentration at each step (assumes initial volume is 300)
% % to do
% 
% 
% end

%
hold on;
x=[-2 0 0 12 15]
y = [0 0 100 100 100]
plot(x,y./10)

x=[-2 0 0 12 15]
y = [0 0 0 0 0]
plot(x,y./10)
ylim([-1 11]);
xlim([-1.7500   13]);