function runSegmentCellsOnImageDirec(direc,imSuffix,chan,paramfile)
% split from runSegmentCellsAndorSplitOnlyByPosTime jkm 2/22/18
% adds 'membrane' to 'outfile.mat'

% runSegmentCellsZstack_bfopen_splitByPos(direc,pos,chan,paramfile,outfile)
%__________________________
% Assumes files are split only by position and possible time but with several
% timepoints in each file. All z-positions and channels must be in one
% file.
% Inputs:
%   -direc - directory containing images
%   - pos - position number
%   - chan - list of channels (1st for segmentation, others to quantify)
%       NOTE: starts from 1 for consistency with other routines
%   - paramfile - paramter file to use
%   - disksize - used to erode mask from ilastik
%       NOTE: pixel size 10 is reasonable for images acquired at 30x
%   - outfile - output .mat file
%   - nframes (optional) number of frames to run. If not supplied will run
%   all
% Output data is saved in the output file in peaks variable with image information
% in imgfiles variable.





global userParam;

try
    eval(paramfile);
catch
    error('Could not evaluate paramfile command');
end

files = dir([direc filesep '*' imSuffix]);
nFiles = length(files);

for iFiles=1:nFiles
    
   % tic;
    
    filename = [direc filesep files(iFiles).name];
    reader = bfGetReader(filename);
    
    nT = reader.getSizeT;
    
    h5file = geth5name(filename); 
   % h5file = geth5nameMask3(filename); %ilastik update defaults to prefix "mask3" 3/13/18 jkm
    if exist(h5file,'file')
        usemask = 1;
        [masks] = readIlastikFileNucMem(h5file);
        if isfield(userParam,'maskDiskSize')
        masks = imopen(masks,strel('disk',userParam.maskDiskSize));
        end
    else
        usemask = 0;
    end
    
    for jj = 1:nT
        
        nuc = bfMaxIntensity(reader,jj,chan(1));
        
        
        if length(chan) == 1
            fimg = nuc;
        else
        
        for xx=2:length(chan)
            fimg(:,:,xx-1) = bfMaxIntensity(reader,jj,chan(xx));
        end
        end
        
        
        
        %pre process image
        [nuc2, fimg2] =preprocessImages(nuc,fimg);
        
        
        
        %run routines to segment cells, do stats, and get the output matrix
        try
            if usemask
                if max(max(masks(:,:,jj))) == 0
                    disp('Empty mask. Continuing...');
                    peaks{nimg}=[];
                    statsArray{nimg}=[];
                    nimg = nimg + 1;

                    continue;
                end
                disp(['Using ilastik mask frame ' int2str(jj)]);
                [outdat, ~, statsN] = image2peaks(nuc2, fimg2, masks(:,:,jj));
                
               
                
            else
                disp(['Segmenting frame ' int2str(jj)]);
                [outdat, ~, statsN] = image2peaks(nuc2,fimg2);
            end
        catch err
            disp(['Error with image ' int2str(iFiles) ' continuing...']);
            
            peaks{nimg}=[];
            membrane(nimg) = nan;
            statsArray{nimg}=[];
                    nimg = nimg + 1;

            %rethrow(err);
            continue;
        end
        
        % copy over error string, NOTE different naming conventions in structs userParam
        % vs imgfiles.
       
        if userParam.verboseSegmentCells
            display(userParam.errorStr);
        end
        % compress and save the binary mask for nuclei
   
        peaks=outdat;
       
        
        %This prevents the resulting mat files from becoming too large.
        statsN = rmfield(statsN,'VPixelIdxList');
        statsArray{iFiles}=statsN;
        
        %toc;
    end
    dateSegmentCells = clock;
save([filename '.mat'],'peaks','statsArray','userParam','dateSegmentCells');
clear peaks;
clear statsArray;


end



