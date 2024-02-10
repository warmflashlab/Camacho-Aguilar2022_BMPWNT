%% make background image
% run in image directory. for now works for maxI projections from setupmoviefolder of two channel andor movie datasets with standard image export
% settings.
% go open first frame of each position only, median filter h = 20, then min intensity projection
function [mI] = mkBackgroundImage(direc);
files = dir([direc filesep '*tif']);
for ii = 1:length(files);
    Img = imread([direc filesep files(ii).name],1);
    if min(min(Img(:,:,1))) == 0 || min(min(Img(:,:,2))) == 0 % check for non-image
        error(['image F=' int2str(ii-1) ' = 0'; ]);
    end
    for jj = 1:size(Img,3)
    Img(:,:,jj) = medfilt2(Img(:,:,jj),'symmetric');
    end
    for iChan = 1:size(Img,3);    
    I{iChan}(:,:,ii)= Img(:,:,iChan);
    end
end
for ii = 1:size(Img,3)
mI(:,:,ii) = min(I{ii},[],3);
end

imwrite(mI(:,:,1),'bg_fimg1-1.tif'); % could easily rename and put inside previous loop
imwrite(mI(:,:,2),'bg_nuc-2.tif');
disp(['channel minimums are: ' int2str(min(min(mI)))])
figure; for ii = 1:size(mI,3); subplot(2,2,ii); imshow(mI(:,:,ii),[]); end
end
