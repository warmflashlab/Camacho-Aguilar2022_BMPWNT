function [outputArg1,outputArg2] = setupMovieFolder
% imageDirec is the path to the folder where RAW data is;
%% make new directory on SPICE, copy template files
AD = readAndorDirectory(imageDirec);
disp('Done')
AD.prefix;
newDirec = [''];% Path where the MaxI folder with max projections will be created

%% make maxI for images and save in newDirec/MaxI
mkMaxIntensities(imageDirec,'tif',[newDirec filesep 'MaxI']);
%%
%cd(newDirec);
end

