function vectorfates = classifycell_v3(xall,nsimulations,attractors)

vectorfates = zeros(1,8);

for ii = 1:nsimulations
    x=xall(:,ii);
xast = attractors\x;
vecaux = xast/sum(abs(xast));
if vecaux(1)==1
    classificationnumber = 2;
elseif vecaux(2)==1
 classificationnumber = 4;
elseif vecaux(3)==1
     classificationnumber = 6;
     
else



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

vectorfates(classificationnumber) = vectorfates(classificationnumber)+1;

end



    