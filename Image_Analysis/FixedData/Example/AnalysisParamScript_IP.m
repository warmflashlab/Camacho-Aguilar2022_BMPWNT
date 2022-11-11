global analysisParam;

fprintf(1, '%s called to define params\n',mfilename);

%% Parameters to modify

% Path to your experiment
analysisParam.pathnamesave = '~/GitHub/ImageAnalysis/FixedData/ImageProcessing_v2/Example';
analysisParam.pathnamedata = [analysisParam.pathnamesave,'/MaxProj']; %No need to change usually
% Number of plates
analysisParam.NumofPlates = 2;
% Plate Type
analysisParam.NumofWells = 2;
% Number of images per well
analysisParam.ImagesperWell = 2;
% Names of conditions in each well and plate
analysisParam.NamesConditions ={{'P1_C1','P1_C2'},...
                                {'P2_C1','P2_C2'}};
                

% % Channels in each well of the plate                
ChannelsnamesPlate1 = {'DAPI-405','GENE1-640','GENE2-555','GENE3-488'};
OrderChannelsPlate1 = {1,2,3,4};
Plate1Channels = cell(1,2);
Plate1OrderChannels = cell(1,2);
for ii=1:2
Plate1Channels{ii} = ChannelsnamesPlate1;
Plate1OrderChannels{ii} = OrderChannelsPlate1;
end


ChannelsnamesPlate2 = {'DAPI-405','GENE1-640','GENE2-555','GENE3-488'};
OrderChannelsPlate2 = {1,2,3,4};
Plate2Channels = cell(1,2);
Plate2OrderChannels = cell(1,2);
for ii=1:8
Plate2Channels{ii} = ChannelsnamesPlate2;
Plate2OrderChannels{ii} = OrderChannelsPlate2;
end


analysisParam.Channelsnames = {Plate1Channels,Plate2Channels};
analysisParam.OrderChannels = {Plate1OrderChannels,Plate2OrderChannels};


analysisParam.WellsWithData = {1:2,1:2};
analysisParam.ChannelMaxNum = {};
for ii=1:analysisParam.NumofPlates
    analysisParam.ChannelMaxNum{ii} = cellfun(@length,analysisParam.Channelsnames{ii});
end


%Background images:
%------------------
analysisParam.bgsubstractionopt = 1; %1: use background images given, 2: use min mean background value over images (needs segmentation!), 3: use imopen to substract background, 4: don't substract background
analysisParam.path2BGImages = analysisParam.pathnamedata;
%One image per well and per plate (in this example, the bg image is the
%same for all wells, otherwise you'll need to specify each bg image
bgimagename = 'Background_Exp37_MAXProj.tif';
analysisParam.BGImages = {repmat({bgimagename},1,2),repmat({bgimagename},1,2)};


%Image processing parameters:
%----------------------------
analysisParam.imopendiskradious = 6;
analysisParam.imerodediskradious = 6;
analysisParam.imdilatediskradious = 6;
analysisParam.pwatershed = 1;


%% Other parameters usually not needed to be modified
analysisParam.savingpathforData = [analysisParam.pathnamesave,'/Matlab_Analysis_Segmentation'];
analysisParam.savingpathforImages = [analysisParam.pathnamesave,'/Visualize_Images_BGSubstracted'];
mkdir(analysisParam.savingpathforData)
analysisParam.nCon = cellfun(@length,analysisParam.WellsWithData);

analysisParam.figDir = 'figures';
mkdir([analysisParam.savingpathforData filesep analysisParam.figDir])

%% Create map channels

IP_CreateMapChannels


