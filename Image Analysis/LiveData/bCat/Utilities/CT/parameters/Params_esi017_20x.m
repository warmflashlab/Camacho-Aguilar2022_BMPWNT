function setUserParamForJKM_ESI017_20x1024
%
%
% Contains master set of comments on how to adjust parameters and other


global userParam

fprintf(1, '%s called to define params\n',mfilename);


userParam.maskDiskSize = 5; % this is only used for filtering too small "cells" in ilastik mask
userParam.nucAreaHi = 5000;  % excludes too large "cells" from analysis

%%%%Background parameters
userParam.providedBackground=1; %if using provided bg images


