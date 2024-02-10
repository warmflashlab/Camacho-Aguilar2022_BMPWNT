%% exp1, 10 and 30 up to 20h ramps
clear;
x = [-2 reshape([0:2:20;0:2:20],1,22) 40];
 y = zeros(8,24);
 y(2,3:end) = 10;
 y(3,1:16) = [reshape([linspace(0,10,8);linspace(0,10,8)],1,16) ];
 y(3,17:end) = 10;
 y(4,:) = reshape([linspace(0,10,12);linspace(0,10,12)],1,24);
 y(5,23:end) = 10;
 y(6,3:end) = 300;
 y(7,:) = reshape([linspace(0,300,12);linspace(0,300,12)],1,24);
 y(8,23:end) = 300;
%
figure; subplot(2,1,1);

plot(x,y(1:5,:)');
title('10ng/ml conditions');
ylim([-1 11]);
xlabel('hours');
ylabel('WNT3A ng/ml');
subplot(2,1,2);
plot(x,y([1 6:8],:)');
ylim([-10 310]);
title('300ng/ml conditions');
xlabel('hours');
ylabel('WNT3A ng/ml');


%% exp 2 10,20,30h ramps
clear;
finalC = 100;

x = [-2 reshape([0:2:30;0:2:30],1,32) 40];

 y = zeros(8,34);
 y(2,3:end) = finalC; % 0h 10
 y(3,1:16) = [reshape([linspace(0,finalC,8);linspace(0,finalC,8)],1,16) ]; %12h ramp
 y(3,17:end) = finalC;
 y(4,15:end) = finalC; %12h step
  
 y(5,1:24) = reshape([linspace(0,finalC,12);linspace(0,finalC,12)],1,24); %20h ramp
 y(5,25:end) = finalC;
 y(6,23:end) = finalC; %20h step
 y(7,:) = reshape([linspace(0,finalC,17);linspace(0,finalC,17)],1,34); %30h ramp
 y(8,33:end) = finalC; %30h step
 
 figure; plot(x,y');
 ylim([-.1*finalC 1.1*finalC]);
 xlabel('hours');
ylabel('WNT3A ng/ml');
legend('no treatment',['0h step to ' int2str(finalC) 'ng/ml'],['12h ramp, step size = ' num2str(round(y(3,3),2))],'12h step',['20h ramp, step size = ' num2str(round(y(5,3),2))],['20h step, step size = ' num2str(round(y(7,3),2))]','30h ramp','30h step');
title([int2str(finalC) 'ng/ml ramps']);