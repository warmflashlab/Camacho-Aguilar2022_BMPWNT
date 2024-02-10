%% divide by baseline, subtract baseline, and only preligand

clear;

%% display as fraction of maximum signal

% subtract Y = (Y-1)./max(Y)
h = findobj(gcf,'Type','line')
x=get(h,'Xdata')
y=get(h,'Ydata')
t = get(gca,'Title');
t = t.String;
a = legend;


%%
figure; clf; subplot(2,1,1); hold on;
for ii = 1:length(x)
    y1 = (y{ii});
   
    plot(x{ii},y1,'LineWidth',3);
end
set(gca,'LineWidth',3);
title(t);
%legend(a(1).String(1:length(x)));


% fraction Max
minusOne = 0;
 subplot(2,1,2); hold on;
for ii = 1:length(x)
    y1 = (y{ii}-minusOne);
    y1 = y1./max(y1);
    plot(x{ii},y1,'LineWidth',3);
end
set(gca,'LineWidth',3);
title([t ' fraction max']);
%legend(a(1).String(1:2:length(x)));
% 
% figure; clf; hold on;
% for ii = 2:2:length(x)
%     y1 = (y{ii}-minusOne);
%     y1 = y1./max(y1);
%     plot(x{ii},y1,'LineWidth',3);
% end
% set(gca,'LineWidth',3);
% title('fraction max w/ control norm');
% legend(a(1).String(2:2:length(x)));