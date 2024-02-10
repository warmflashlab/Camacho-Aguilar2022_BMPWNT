
function segmentCellsAndorMovie(direc,pos,chan,paramfile,outfile)
%% imread faster than bfopen, regionprops faster than image2peaks, medianfilt2 better than
% smoothimage

% background subtraction and processing could be moved prior to segmentation
%% 
% latest function to process movies from Andor Spinning Disk microscope. Assumes images are max intensity projections and are formatted
% the default Andor way, i.e., files are split only by Position and Time.




% This is much faster than old functions that relied on image2peaks 


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
%% main loop over frames (time)
for ii=1:ntimefiles
    
   % tic;
    
    filename = getAndorFileName(ff,pos,ii-1,[],[])
    
    %reader = bfGetReader(filename);
    
    %nT = reader.getSizeT;
    nT = length(imfinfo(filename));
    h5file = geth5name(filename); 
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
    
    for jj = 1:nT
        
        %nuc = bfMaxIntensity(reader,jj,chan(1));
        img = imread(filename,jj);
%         size(img)
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
        
        nuc2 = medfilt2(presubBackground_provided(nuc,1));
        fimg2 = medfilt2(presubBackground_provided(fimg,2));
        %[nuc2, fimg2] =preprocessImages(nuc,fimg);
        
        
        
        %run routines to segment cells, do stats, and get the output matrix
        try
            
                if max(max(masks(:,:,jj))) == 0
                    disp('Empty mask. Continuing...');
                    peaks{nimg}=[];
                    membrane(nimg) = nan;
                    statsArray{nimg}=[];
                    nimg = nimg + 1;

                    continue;
                end
                %disp(['Using ilastik mask frame ' int2str(jj)]);
                maskN = bwareafilt(masks(:,:,jj),[0, userParam.nucAreaHi]); %filter too big "nuclei"
                
%                 %Plot images
%                 maskdog=maskN-imerode(maskN,strel('disk',2));
%                 imshow(cat(3,maskdog,maskdog,imadjust(mat2gray(nuc2))),[])
                %% object classification and cell averages
                statsNucMarker = regionprops(maskN, nuc2, 'Area' ,'PixelIdxList', 'Centroid','MeanIntensity');
                statsFimg = regionprops(maskN, fimg2, 'MeanIntensity');
                for ii = 1:length(statsNucMarker);
                    stats(ii).NucMarkerNucIntensity = round(statsNucMarker(ii).MeanIntensity);
                    stats(ii).GreenNucIntensity = round(statsFimg(ii).MeanIntensity);
                    stats(ii).NucArea = round(statsNucMarker(ii).Area);
                    stats(ii).Centroid = statsNucMarker(ii).Centroid;
                    stats(ii).PixelIdxList = statsNucMarker(ii).PixelIdxList;
                end
                
               
                xy = stats2xy(stats);
                for iImages = 1:length(stats)
                    datacell(iImages,:) = [xy(iImages,1) xy(iImages,2) stats(iImages).NucArea -1 stats(iImages).NucMarkerNucIntensity stats(iImages).GreenNucIntensity 0];
                end
                
                %[outdat, ~, statsN] = image2peaks(nuc2, fimg2, masks(:,:,jj));
                mem = segmentMembrane(fimg2, memMasks(:,:,jj)); 
                
           
        catch err
            disp(['Error with image ' int2str(ii) ' continuing...']);
            
            peaks{nimg}=[];
            membrane(nimg) = nan;
            statsArray{nimg}=[];
                    nimg = nimg + 1;

            %rethrow(err);
            continue;
        end
        
        % copy over error string, NOTE different naming conventions in structs userParam
        % vs imgfiles.
%         imgfiles(nimg).errorstr = userParam.errorStr;
%         if userParam.verboseSegmentCells
%             display(userParam.errorStr);
%         end
%         % compress and save the binary mask for nuclei
%         imgfiles(nimg).compressNucMask = compressBinaryImg([statsN.PixelIdxList], size(nuc) );
        peaks{nimg}=datacell;
        membrane(nimg) = mem;
        

        statsArray{ii}=stats;
        clear stats;
        clear datacell;
        nimg = nimg + 1; %counts up for frames (time)
        %toc;
    end
end

dateSegmentCells = clock;
save(outfile,'peaks','statsArray','userParam','dateSegmentCells','membrane');


