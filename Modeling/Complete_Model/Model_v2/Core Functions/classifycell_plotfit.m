function [vectorfates,propsfates] = classifycell_plotfit(xall,nsimulations,attractors)

vectorfates = zeros(1,nsimulations);
propsfates = zeros(1,8);

for ii = 1:nsimulations
    x=xall(:,ii);
xast = attractors\x;
vecaux = xast/sum(abs(xast));%norm(xast)

% norm(vecaux)

% distances = zeros(1,3);
% distances(1) = norm(x-attractors(:,1));
% distances(2) = norm(x-attractors(:,2));
% distances(3) = norm(x-attractors(:,3));
% distances
if vecaux(1)==1
    classificationnumber = 2;
elseif vecaux(2)==1
 classificationnumber = 4;
elseif vecaux(3)==1
     classificationnumber = 6;
     
else

%     vecaux

    propclassification1 = 0.5;
    propclassification2 = 0.8;

    if vecaux(1) > propclassification1  %SOX2

        classificationnumber = 2;

    elseif vecaux(2) > propclassification1  %BRA

        classificationnumber = 4;

    elseif vecaux(3) > propclassification1   %CDX2

        classificationnumber = 6;

    elseif vecaux(1)+vecaux(2) > propclassification2  %SOX2/BRA

       classificationnumber = 3;

    elseif vecaux(2)+vecaux(3) > propclassification2  %BRA/CDX2

       classificationnumber = 5;

    elseif vecaux(1)+vecaux(3) > propclassification2  %SOX2/CDX2

       classificationnumber = 7;

    else 

        classificationnumber = 8;
    end
end

vectorfates(ii) = classificationnumber;
propsfates(classificationnumber) = propsfates(classificationnumber)+1;
end



    