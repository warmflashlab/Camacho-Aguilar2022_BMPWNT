%function segmentCellsAndorMovie_ECA(direc,pos,chan,paramfile,outfile)
%% imread faster than bfopen, regionprops faster than image2peaks, medianfilt2 better than
% smoothimage

% background subtraction and processing could be moved prior to segmentation
%% 
% latest function to process movies from Andor Spinning Disk microscope. Assumes images are max intensity projections and are formatted
% the default Andor way, i.e., files are split only by Position and Time.




% This is much faster than old functions that relied on image2peaks 

%%
clear;
tic;
setAnalysisParam_this;
global analysisParam;
data_direc = analysisParam.data_direc;

file_suffix = '.tif'; % may have to make further adjustments if not using andor .tif files
chan = analysisParam.chan; %first value is nuc channel, following contains other channels
paramfile = analysisParam.userParam; %the paramfile for preprocessing images
positions = [0:analysisParam.nPos-1]; %positions to run (assumes andor dataset naming conventions)
% mkdir([data_direc '-OutfilesV2']);
% mkdir('scripts&paramfiles');

pos = 0;
ii = 1; %.txt file of the corresponding position
jj = 135; %time at that .txt (maximum is nT)

outfile = fullfile([data_direc '-OutfilesV2'],['pos' int2str(pos) '.mat']);
direc = data_direc;

%%
global userParam;

try
    eval(paramfile);
catch
    error('Could not evaluate paramfile command');
end

ff=readAndorDirectory(direc);

if length(chan) < 2
    nImages = 1;
else
    nImages=length(chan)-1;
end

if isempty(ff.t)
    ntimefiles = 1;
else
    ntimefiles = length(ff.t);
end

nimg = 1;

disp('Done')

%% Get position information   
   % tic;
    
    filename = getAndorFileName(ff,pos,ii-1,[],[]);
    
    %reader = bfGetReader(filename);
    
    %nT = reader.getSizeT;
    nT = length(imfinfo(filename));
    h5file = geth5name(filename); 
    
%% Read position and time   
   % h5file = geth5nameMask3(filename); %ilastik update defaults to prefix "mask3" 3/13/18 jkm
    if exist(h5file,'file')
        usemask = 1;
        [masks memMasks] = readIlastikFileNucMem(h5file);
        if isfield(userParam,'maskDiskSize')
        masks = imopen(masks,strel('disk',userParam.maskDiskSize));
        end
    else
       error('h5 file not found');
    end
    
        
        %nuc = bfMaxIntensity(reader,jj,chan(1));
        img = imread(filename,jj);
        nuc = img(:,:,chan(1));
        if length(chan) == 1
            fimg = nuc;
        else
        
        for xx=2:length(chan)
            %fimg(:,:,xx-1) = bfMaxIntensity(reader,jj,chan(xx));
            fimg(:,:,xx-1) = img(:,:,chan(xx));
        end
        end
        
        disp(['frame ' int2str(nimg) ' of file: ' filename]);
        % setup string to hold all the error messages for this frame number
        userParam.errorStr = sprintf('frame= %d\n', nimg);
        

        
%         %record some info about image file.
%         imgfiles(nimg).filestruct=ff;
%         imgfiles(nimg).pos = pos;
%         imgfiles(nimg).w = chan;
   
%% pre process image <-- this will probably be moved to take place during MaxI to save time
        
        nuc2 = medfilt2(presubBackground_provided_ECA(nuc,2));
        fimg2 = medfilt2(presubBackground_provided_ECA(fimg,1));
        %[nuc2, fimg2] =preprocessImages(nuc,fimg);
 
%% Compare original with background substracted one        
figure
subplot(2,2,1)
imshow(imadjust(mat2gray(nuc)))
subplot(2,2,2)
imshow(imadjust(mat2gray(nuc2)))
subplot(2,2,3)
imshow(imadjust(mat2gray(fimg)))
subplot(2,2,4)
imshow(imadjust(mat2gray(fimg2)))

%%

maskN = bwareafilt(masks(:,:,jj),[0, userParam.nucAreaHi]);

%% Visualisation of the raw data and original mask

% Visualize original mask from Ilastik:
%--------------------------------------
% allocate empty array for data
R = maskN;
B = 0*R;
% show image for time t, cat concatenates nuclei and cell segmentation data
% to colour them differently
imshow(cat(3,R,B,R),[]);

%%
% 
% Visualize raw data and original mask from Ilastik as a doughnut:
%-----------------------------------------------------------------  
%Create a doughnut around nuclei by using the mask:
mask=maskN-imerode(maskN,strel('disk',2));
%mask=nuclei_new(:,:,t)'-imerode(nuclei_new(:,:,t)',strel('disk',2));

%Get Nuclei
RawNucleiplot=imadjust(mat2gray(nuc2)); %This version saturates the background
RawMembraneplot =imadjust(mat2gray(fimg2));
% RawNucleiplot=mat2gray(FluorescenceLevelsRaw(:,:,channeltoplot));

%Plot them:
    NucleiandNucleiDonuts=cat(3,mask,RawNucleiplot,RawMembraneplot);
    figure
    Plot2=imshow(NucleiandNucleiDonuts,[]);
    title('Improved Nuclei segmentation on Raw Nuclei')



                %% object classification and cell averages
                statsNucMarker = regionprops(maskN, nuc2, 'Area' ,'PixelIdxList', 'Centroid','MeanIntensity');
                statsFimg = regionprops(maskN, fimg2, 'MeanIntensity');
length(statsNucMarker)