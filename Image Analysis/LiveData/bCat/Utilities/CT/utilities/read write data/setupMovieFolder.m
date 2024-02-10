function [outputArg1,outputArg2] = setupMovieFolder(imageDirec)
%moves andor movie scripts from template folder, along with metadata from
%image directory and images (compressed to maxIntensity) to SPICE data
%storage
%% make new directory on SPICE, copy template files
AD = readAndorDirectory(imageDirec);
disp('Done')
AD.prefix;
newDirec = ['/Users/elenacamachoaguilar/Dropbox (Personal)/Rice/Experiments/181023_CDX2Commitment_time_6/Data' filesep AD.prefix];
% copyfile('/Users/elenacamachoaguilar/Desktop/181025_BMPCommitment_Experiment_6/181019-100Wnt+ldn+sb+iwp2-420181025_30924 PM_20181027_30406 PM',newDirec);
% disp('Done')
% %% copy metadata file from image directory
% txtFile = dir([imageDirec filesep '*.txt']);
% copyfile([imageDirec filesep txtFile.name],[newDirec filesep txtFile.name]);
%% make maxI for images and save in newDirec/MaxI
mkMaxIntensities(imageDirec,'tif',[newDirec filesep 'MaxI']);
%%
%cd(newDirec);
end

