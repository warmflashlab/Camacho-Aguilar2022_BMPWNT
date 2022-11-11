% computeCells_this is run after MaxI and Ilastik

%% parameters
clear;
tic;
setAnalysisParam_this;
global analysisParam;
data_direc = analysisParam.data_direc;
file_suffix = '.tif'; % may have to make further adjustments if not using andor .tif files
chan = analysisParam.chan; %first value is nuc channel, following contains other channels
paramfile = analysisParam.userParam; %the paramfile for preprocessing images
positions = [0:analysisParam.nPos-1]; %positions to run (assumes andor dataset naming conventions)
mkdir([data_direc '-OutfilesV2']);
mkdir('scripts&paramfiles');
%%
parfor pos = positions;
    outfile = fullfile([data_direc '-OutfilesV2'],['pos' int2str(pos) '.mat']);
segmentCellsAndorMovie_v2(data_direc,pos,chan,paramfile,outfile);
end
toc;
copyfile(which(paramfile),['scripts&paramfiles/UserParamCopy.m']); %saves userParam with dataset
disp('Images and masks processed');

%%
analysisParam.figDir = 'figuresV2';
analysisParam.outDirec = 'MaxI-OutfilesV2';
 mkdir([analysisParam.figDir]);
%  plotMembrane;
 allPeaks = getAllPeaks;
 singleCells = allPeaks2singleCells(allPeaks);
 save('singleCells')
 
  %%
  load('singleCells.mat')
 plotCounts_black(singleCells,1)
 
  %%
analysisParam.figDir = 'figuresV2';
data_direc_OUT='/Volumes/Elena-2020/220921_bCatDynamics_Exp80/Times-3to16h';
size(singleCells)
 mkSignalingPlots_bCat(data_direc_OUT,singleCells,1);
 
 %%
analysisParam.figDir = 'figuresV2';
data_direc_OUT='/Users/elenacamachoaguilar/Dropbox (Personal)/Rice/Experiments/181023_CDX2Commitment_time_6/Data/181019-100Wnt+ldn+sb+iwp2-420181025_30924 PM';

mkSignalingPlots_bCat_Area(data_direc_OUT,singleCells,1);
 
 
 %% New Plots
 analysisParam.figDir = 'figuresV2';
data_direc_OUT='/Users/elenacamachoaguilar/Dropbox (Personal)/Rice/Experiments/181023_CDX2Commitment_time_6/Data/181019-100Wnt+ldn+sb+iwp2-420181025_30924 PM';

PlotGfp2Rfp2PreTreatment2Control_bCat(data_direc_OUT,1,1,1,1)

 %% New Plots
 analysisParam.figDir = 'figuresV2';
data_direc_OUT='/Users/elenacamachoaguilar/Dropbox (Personal)/Rice/Experiments/181023_CDX2Commitment_time_6/Data/181019-100Wnt+ldn+sb+iwp2-420181025_30924 PM';

PlotGfp2Rfp2PreTreatment2Control_NoNucNorm_bCat(data_direc_OUT,1,1,1,1)

%% New Plots: Violing Plot

ViolinPlotsData_NoNucNorm_bCat(1,1)
