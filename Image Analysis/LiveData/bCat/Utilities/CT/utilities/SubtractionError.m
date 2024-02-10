function [ sigmaz ] = SubtractionError( x,y,sigmax,sigmay )
%SubtractionError determines the error of x minus y when sigmax is the
%standard deviation of x and sigmay is the standard deviation of y

% also works for addition
%   
sigmaz = sqrt(sigmax^2+sigmay^2);


end

