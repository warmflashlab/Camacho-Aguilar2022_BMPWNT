%% Find roots of function

function  [root,stability,fate,flag] = findrootGRN(guess,parameters)

% %% Input and output variables:
% % Root = Root of the function near the guess
% % Stability: 0 if unstable, 1 if stable, 2 if it is not a root
% % fate: 1 if root corresponds to SOX2+, 2 if root corresponds to BRA+, 3 if
% % root corresponds to CDX2+, 4 if it's not a root
% % Flag: 0 if it does not return a root, 1 if it does return a root.
% 
% 
% 
% % Maximum number of trials:
% Ntrials = 50;
% 
% % Tolerance:
% tol = exp(-10);
% 
% % Initial guess for the root:
% x0=guess;
% 
% %Error:
% err = 2*tol;
% 
% % Trial number:
% n=1;
% 
% %% Using Newton-Raphson method
% while (err>tol)&&(n<Ntrials)
%     
%     F = ode_ONLYGRNModel_v7(x0,parameters);
%     err = sum(abs(F));
%     J = ode_ONLYGRNModel_v7_jac(1,x0,parameters);
%     
%     dx = J\(-F);
%     x0=x0+dx;
%     n=n+1;
% 
% end
% 
% root = x0;
% 
% 
% %%
% 
% if (n>=Ntrials)
%     % If the algorithm stopped because it reached the maximum number of
%     % iterations:
%     flag = 0;
%     stability = 2;
%     fate = 4;
%     
% elseif sum(sum(isnan(J)))%,"all")
%     % If the algorithm returned a non valid J
%     flag = 0;
%     stability = 2;
%     fate = 4;
%     
% elseif sum(sum(isnan(J)))%,"all")
%     
%     % If the algorithm returned a non valid J
%     flag = 0;
%     stability = 2;
%     fate = 4;
%     
% else
%     
%     flag = 1;
%     J = ode_ONLYGRNModel_v7_jac(1,x0,parameters);
%     
%     if sum(sum(isnan(J)))>0
%     % If the algorithm returned a non valid J
%     flag = 0;
%     stability = 2;
%     fate = 4;
%     
%     elseif sum(sum(isnan(J)))>0
%     
%     % If the algorithm returned a non valid J
%     flag = 0;
%     stability = 2;
%     fate = 4;
%     
%     else
%     
%         lambda = eig(J);
% 
%         if (isreal(lambda(1)))&&(isreal(lambda(2)))&&(isreal(lambda(3)))&&(lambda(1)<0)&&(lambda(2)<0)&&(lambda(3)<0)
%             stability = 1;
% 
%             if (x0(1)>x0(2))&&(x0(1)>x0(3))
% 
%                 fate = 1;
% 
%             elseif (x0(2)>x0(1))&&(x0(2)>x0(3))
% 
%                 fate = 2;
% 
%             elseif (x0(3)>x0(1))&&(x0(3)>x0(2))
% 
%                 fate = 3;
% 
%             else
%                 stability = 0;
% 
%                 fate = 4;
% 
%             end
%         else
% 
%             stability = 0;
%             fate = 4;
% 
%         end
%     end
%     
% end

%% Using Matlab's function
options = optimoptions('fsolve','Display','none');
[root,fval,exitflag,output] = fsolve(@(x) ode_ONLYGRNModel_v8(x,parameters), guess,options);
x0=root;

if sum(imag(x0))<1.0e-3
        x0 = real(x0);
        
end

if (exitflag >0)&&(isreal(x0))
flag=1;

        stability = 1;

                    if (x0(1)>x0(2))&&(x0(1)>x0(3))

                        fate = 1;

                    elseif (x0(2)>x0(1))&&(x0(2)>x0(3))

                        fate = 2;

                    elseif (x0(3)>x0(1))&&(x0(3)>x0(2))

                        fate = 3;

                    else
                        stability = 0;

                        fate = 4;

                    end
else

flag=0;
    stability = 2;

    fate = 4;

end



        
        


% 

% size(parameters)
% root = fsolve(@(x) ode_ONLYGRNModel_v7(x,parameters), guess);