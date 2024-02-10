
function [nucAvg nucMax] = readJpgsZstack(basefile,frame)

global userParam

%nucAvg = zeros(userParam.imsize); nucMax = zeros(userParam.imsize);

for z=1:userParam.zsections
    readfile = [basefile '_z' int2str(z) '_' int2str(frame) '_nuc.jpg'];
    nucimg_t=imread(readfile);
    if z==1
        nucMax=zeros(size(nucimg_t));
        nucMax=im2uint8(nucMax);
        nucAvg=nucMax;
    end
    nucMax = max(nucMax,nucimg_t);
    nucAvg = imadd(nucAvg,nucimg_t/userParam.zsections);
end
