function [ img ] = presubBackground_provided_ECA(img,channelnumber )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

global userParam;


backgroundSmoothRad=5;
backgroundSmoothSig=1;
    
    bg_nuc = imread([userParam.backgroundfile]);
    bg_nuc = bg_nuc(:,:,channelnumber);
    bg_nuc = smoothImage(bg_nuc,backgroundSmoothRad,backgroundSmoothSig);
    img=imsubtract(img,bg_nuc);
    
    

end


