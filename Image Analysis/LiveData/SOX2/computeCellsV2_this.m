% computeCells_this is run after MaxI and Ilastik

%% parameters
clear;
tic;
setAnalysisParam_this;
global analysisParam;
data_direc_IN = analysisParam.data_direc_INPUT;
data_direc_OUT = analysisParam.data_direc_OUTPUT;

%%
file_suffix = '.tif'; % may have to make further adjustments if not using andor .tif files
chan = analysisParam.chan; %first value is nuc channel, following contains other channels
paramfile = analysisParam.userParam; %the paramfile for preprocessing images
positions = [0:analysisParam.nPos-1]; %positions to run (assumes andor dataset naming conventions)
mkdir([data_direc_OUT '/MaxI-OutfilesV2']);
mkdir('scripts&paramfiles');
%%
parfor pos = positions
    outfile = fullfile([data_direc_OUT '/MaxI-OutfilesV2'],['pos' int2str(pos) '.mat']);
segmentCellsAndorMovie_SOX2( data_direc_IN,pos,chan,paramfile,outfile );
end
toc; 
copyfile(which(paramfile),['scripts&paramfiles/UserParamCopy.m']); %saves userParam with dataset
disp('Images and masks processed');

%%
analysisParam.figDir = 'figuresV2';
analysisParam.outDirec = ['MaxI-OutfilesV2'];
 mkdir([analysisParam.figDir]);
 allPeaks = getAllPeaks;
 singleCells = allPeaks2singleCells(allPeaks);
 save('singleCells','singleCells');
 %%
 mkSignalingPlots(singleCells,1);
 %%
 load('singleCells.mat')
 plotCounts_black(singleCells,1)
 %%
 PlotGfp2Rfp2PreTreatment2Control_Elena(singleCells,1,1,1)
 
 %%
 plotError = 1;
 plotlegend=1;
 newplot=1;
 PlotGfp2Rfp2PreTreatment2Control_NoNuclearMarkerNorm(data_direc_OUT,plotError,plotlegend,newplot,1)

 
 




