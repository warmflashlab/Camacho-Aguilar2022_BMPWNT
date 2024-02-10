
function [z] = log10toLog2(Y)
%convert log10 plot to log2
% where log10(x) = Y
%log2(X) = log10(x)/log10(2)
% lX = log10(x)
% lX/log10(2) = log2(x)

z=Y./log10(2);
end
