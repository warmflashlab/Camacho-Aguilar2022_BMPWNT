function [criticalpoints,Ntrialscritpoints,stability] = findcriticalpoints_v4_LimitCycles(npointsdist,X,Y,Z,parameter,BMP,WNT,method)


criticalpoints = [];
Ntrialscritpoints = [];
stabilitycleanaux = [];

SMAD40 = BMP;
bCat0 = WNT;
paramattractors = parameter;
paramattractors(1) = SMAD40;
paramattractors(2) = bCat0;
        

            for ii = 1:npointsdist

                for jj = 1:npointsdist

                    for kk = 1:npointsdist

                        initcond = [X(ii,jj,jj);Y(ii,jj,jj);Z(ii,jj,jj)];
                        [root,stability,fate,flagg,Ntrials] = findrootGRN_stabilityanalysis(initcond,paramattractors,method);
                        stabilityaux = computestability(root,paramattractors);
%                         pause()
if stabilityaux == 1
                        if (stability<5)&&(sum(isnan(root))==0)&&(sum(imag(root)>0)==0)
                            if isempty(criticalpoints)
                                criticalpoints = [criticalpoints,root];
                                Ntrialscritpoints =[Ntrialscritpoints,Ntrials];
                                stabilitycleanaux = [stabilitycleanaux,stabilityaux];
                            else
                                
                                flagexistingcp = 1;
                                ncritpoints = size(criticalpoints,2)+1;
                                counter = 1;
                                while (flagexistingcp)&&(counter<ncritpoints)
                                    dis2critpoint = norm(root-criticalpoints(:,counter),2);
                                    
                                    if dis2critpoint<1.0e-2%3%4
                                        flagexistingcp=0;
                                    end
                                    counter=counter+1;
                                end
                                
                                if flagexistingcp
                                    criticalpoints = [criticalpoints,root];
                                    Ntrialscritpoints =[Ntrialscritpoints,Ntrials];
                                    stabilitycleanaux = [stabilitycleanaux,stabilityaux];
                                end
                                
                                
                            end
                        end
end

                    end

                end

            end
            
 %% Look on SOX2 Axis
 npointsdist0 = 0.1;
 Xaux = 0:npointsdist0:max(max(max(X)));
            
            for ii = 1:length(Xaux)


                        initcond = [Xaux(ii);0;0];
                        [root,stability,fate,flagg,Ntrials] = findrootGRN_stabilityanalysis(initcond,paramattractors,method);
                        stabilityaux = computestability(root,paramattractors);
%                         root
%                         stabilityaux
%                         pause()
if stabilityaux == 1
                        if (stability<5)&&(sum(isnan(root))==0)&&(sum(imag(root)>0)==0)
                            if isempty(criticalpoints)
                                criticalpoints = [criticalpoints,root];
                                Ntrialscritpoints =[Ntrialscritpoints,Ntrials];
                                stabilitycleanaux = [stabilitycleanaux,stabilityaux];
                            else
                                
                                flagexistingcp = 1;
                                ncritpoints = size(criticalpoints,2)+1;
                                counter = 1;
                                while (flagexistingcp)&&(counter<ncritpoints)
                                    dis2critpoint = norm(root-criticalpoints(:,counter),2);
                                    
                                    if dis2critpoint<1.0e-2%3%4
                                        flagexistingcp=0;
                                    end
                                    counter=counter+1;
                                end
                                
                                if flagexistingcp
                                    criticalpoints = [criticalpoints,root];
                                    Ntrialscritpoints =[Ntrialscritpoints,Ntrials];
                                    stabilitycleanaux = [stabilitycleanaux,stabilityaux];
                                end
                                
                                
                            end
                        end
end



            end
            
%% Look on BRA Axis
npointsdist0 = 0.1;
 Xaux = 0:npointsdist0:max(max(max(Y)));
            
            for ii = 1:length(Xaux)


                        initcond = [0;Xaux(ii);0];
                        [root,stability,fate,flagg,Ntrials] = findrootGRN_stabilityanalysis(initcond,paramattractors,method);
                        stabilityaux = computestability(root,paramattractors);
%                         pause()
if stabilityaux == 1
                        if (stability<5)&&(sum(isnan(root))==0)&&(sum(imag(root)>0)==0)
                            if isempty(criticalpoints)
                                criticalpoints = [criticalpoints,root];
                                Ntrialscritpoints =[Ntrialscritpoints,Ntrials];
                                stabilitycleanaux = [stabilitycleanaux,stabilityaux];
                            else
                                
                                flagexistingcp = 1;
                                ncritpoints = size(criticalpoints,2)+1;
                                counter = 1;
                                while (flagexistingcp)&&(counter<ncritpoints)
                                    dis2critpoint = norm(root-criticalpoints(:,counter),2);
                                    
                                    if dis2critpoint<1.0e-2%3%4
                                        flagexistingcp=0;
                                    end
                                    counter=counter+1;
                                end
                                
                                if flagexistingcp
                                    criticalpoints = [criticalpoints,root];
                                    Ntrialscritpoints =[Ntrialscritpoints,Ntrials];
                                    stabilitycleanaux = [stabilitycleanaux,stabilityaux];
                                end
                                
                                
                            end
                        end
end



            end
%% Look on CDX2 Axis
npointsdist0 = 0.1;
 Xaux = 0:npointsdist0:max(max(max(Z)));
            
            for ii = 1:length(Xaux)


                        initcond = [0;0;Xaux(ii)];
                        [root,stability,fate,flagg,Ntrials] = findrootGRN_stabilityanalysis(initcond,paramattractors,method);
                        stabilityaux = computestability(root,paramattractors);
%                         pause()
if stabilityaux == 1
                        if (stability<5)&&(sum(isnan(root))==0)&&(sum(imag(root)>0)==0)
                            if isempty(criticalpoints)
                                criticalpoints = [criticalpoints,root];
                                Ntrialscritpoints =[Ntrialscritpoints,Ntrials];
                                stabilitycleanaux = [stabilitycleanaux,stabilityaux];
                            else
                                
                                flagexistingcp = 1;
                                ncritpoints = size(criticalpoints,2)+1;
                                counter = 1;
                                while (flagexistingcp)&&(counter<ncritpoints)
                                    dis2critpoint = norm(root-criticalpoints(:,counter),2);
                                    
                                    if dis2critpoint<1.0e-2%3%4
                                        flagexistingcp=0;
                                    end
                                    counter=counter+1;
                                end
                                
                                if flagexistingcp
                                    criticalpoints = [criticalpoints,root];
                                    Ntrialscritpoints =[Ntrialscritpoints,Ntrials];
                                    stabilitycleanaux = [stabilitycleanaux,stabilityaux];
                                end
                                
                                
                            end
                        end
end



            end            
            [stability,indaux] = sort(stabilitycleanaux);
        
           criticalpoints = criticalpoints(:,indaux);
           Ntrialscritpoints = Ntrialscritpoints(indaux);
