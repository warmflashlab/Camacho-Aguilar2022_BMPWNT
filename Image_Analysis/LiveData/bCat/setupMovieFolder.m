function [outputArg1,outputArg2] = setupMovieFolder
% imageDirec = '/Volumes/WD WL Elena/191203_LiveBcat_Exp21/LiveBcat_Concentrations_Exp21_120191203_105625 AM_20191205_120717 PM';
%moves andor movie scripts from template folder, along with metadata from
%image directory and images (compressed to maxIntensity) to SPICE data
%storage

imageDirec = '/Volumes/Elena-2020/220921_bCatDynamics_Exp80/Times-3to16h/220921_bCatDynamics_Exp80_20220923_23317 PM';
%% make new directory on SPICE, copy template files
AD = readAndorDirectory(imageDirec);
disp('Done')
AD.prefix;
newDirec = ['/Volumes/Elena-2020/220921_bCatDynamics_Exp80/Times-3to16h'];
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

