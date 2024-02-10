function [ img ] = presubBackground_provided( img,bgimprovided,nucOrRep )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

global userParam;

if bgimprovided
    
    if nucOrRep == 1;

        bg_nuc = imread(userParam.bgim,nucOrRep);
        bg_nuc = smoothImage(bg_nuc,userParam.backgroundSmoothRad,userParam.backgroundSmoothSig);
        img=imsubtract(img,bg_nuc);


    elseif nucOrRep == 2;
        bg_fimg = imread(userParam.bgim,nucOrRep);
        bg_fimg = smoothImage(bg_fimg,userParam.backgroundSmoothRad,userParam.backgroundSmoothSig);
        img=imsubtract(img,bg_fimg);
    end
    
else
    if nucOrRep == 1;

        bg_nuc = imopen(img,strel('disk',40));
        img=imsubtract(img,bg_nuc);
        
    elseif nucOrRep == 2;
        bg_nuc = imopen(img,strel('disk',40));
        img=imsubtract(img,bg_nuc);
        
    end    
        
end
end


