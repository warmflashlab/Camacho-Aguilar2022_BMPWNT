function writeMMpos(outfile,Wells,Wspace,npos,posscale,lowerleftpos,labelfile,useonly,fmode)
% function writeMMpos(outfile,Wells,Wspace,npos,posscale,lowerleftpos)
%--------------------------------------------------------------------------
% function to write MicroManager position list.
% outfile -- name of file to write to
% Wells -- 2 component vector specifying number of wells in each direction
%            e.g. 96 well plate use [12 8]
% Wspace -- 2 component vector specifying spacing in each direction. If only
%            one component give will use this in both directions
% npos -- number of positions on either side of center in each direction
%           total pictures=(2*npos+1)^2
% posscale -- single number gives spacing between pictures in each well
% lowerleftpos -- 2 component vecter giving position of lower left well
% label file -- optional file to give names. If not supplied will be
% labeled X1,Y1 etc.
% useonly -- either an Nx2 vector giving X and Y values for wells or 
%            an Nx1 vector giving well numbers (lower left is 1, increases in X and then Y.)
%            WARNING: DOES NOT CHECK FOR DIAGONAL MOVES LIST WELLS IN
%            CORRECT ORDER TO AVOID THIS
% fmode -- mode to use for file. w or a

%set mode to write or append
if ~exist('fmode','var')
    fmode='w';
end

%check for label file, if it exists get the labels
if exist('labelfile','var') && ~isempty(labelfile)
    usedefaultlabel=0;
    [labels nlabels]=processLabelFile(labelfile);
else
    usedefaultlabel=1;
end

fid = fopen(outfile,fmode);

writeMMheader(fid);

if length(Wells)~=2
    error('Wells must be a two component vector');
end

if length(Wspace)==1
    Wspace(2)=Wspace(1);
elseif length(Wspace) > 2
    error('Wspace must be a one or two component vector');
end

%check if only using a subset of wells
if exist('useonly','var') && ~isempty(useonly)
    userestricted=1;
    Nbwells=length(useonly);
else
    userestricted=0;
    Nbwells=prod(Wells);
end

if usedefaultlabel==0 && nlabels~=Nbwells
    disp(['Warning: Number of labels ' int2str(nlabels) ' does not equal number of wells '...
        int2str(Nbwells) '. Using default position labels.']);
    usedefaultlabel=1;
end

for mm=1:Nbwells
    
    %get the indices of the current well
    if userestricted && size(useonly,2)==2%if supplying a list of wells, 2 comp
        iiuse=userestricted(mm,1);
        jj=userestricted(mm,2);
    elseif userestricted && size(useonly,2)==1 %supplying a one component list
        [iiuse jj]=ind2sub(Wells,useonly(mm));
    elseif ~userestricted %doing all wells
        [ii jj]=ind2sub(Wells,mm);
        if mod(jj,2)==0
            iiuse=Wells(1)-ii+1; %don't make diagonal move
        else
            iiuse=ii;
        end
    end
    if usedefaultlabel
        label=['Well: X' int2str(iiuse) ',Y' int2str(jj)];
    else
        label=labels{mm};
    end
    %center pos
    center=lowerleftpos+Wspace.*[iiuse-1 jj-1];
    %get list of pos in this well
    poslist=getWellPosList(center,npos,posscale);
    %write the positions
    for kk=1:length(poslist)
        writeOneWellPos(fid,poslist(kk,:),label);
    end
end



disp(['Wrote ' num2str(length(poslist)) ' positions each in '...
    num2str(Nbwells) ' Wells']);

writeMMfoot(fid);
fclose(fid);
end

function writeOneWellPos(fid,pos,label)
%write a single well position

if length(pos)~=3
    error('In writeOneWellPos: pos must be a 3 component vector');
end

%definition of one position
fprintf(fid,'\t{\n');
fprintf(fid,'\t\t"GRID_COL": 0,\n');
fprintf(fid,'\t\t"DEVICES": [\n');
fprintf(fid,'\t\t{\n');
fprintf(fid,'\t\t"DEVICE": "FocusDrive",\n');
fprintf(fid,'\t\t"AXES": 1,\n');
fprintf(fid,'\t\t"Y": 0,\n');
fprintf(fid,['\t\t"X":' num2str(pos(3)) ',\n']);%edit Z position here
fprintf(fid,'\t\t"Z": 0\n');
fprintf(fid,'\t\t},\n');
fprintf(fid,'\t\t{\n');
fprintf(fid,'\t\t"DEVICE": "XYStage",\n');
fprintf(fid,'\t\t"AXES": 2,\n');
fprintf(fid,['\t\t"Y":' num2str(pos(2)) ',\n']);%edit Y position here
fprintf(fid,['\t\t"X":' num2str(pos(1)) ',\n']);%edit X position here
fprintf(fid,'\t\t"Z": 0\n');
fprintf(fid,'\t\t}\n');
fprintf(fid,'\t\t],\n');
fprintf(fid,'\t\t"PROPERTIES": {},\n');
fprintf(fid,'\t\t"DEFAULT_Z_STAGE": "FocusDrive",\n');
fprintf(fid,['\t\t"LABEL": "' label '",\n']);%edit position label here
fprintf(fid,'\t\t"GRID_ROW": 0,\n');
fprintf(fid,'\t\t"DEFAULT_XY_STAGE": "XYStage"\n');
fprintf(fid,'\t},\n');
fprintf(fid,'\t\t\n');
fprintf(fid,'\t\t\n');
end

function [labels nlabels]=processLabelFile(labelfile)

fid=fopen(labelfile);
qq=1;
tline=fgetl(fid);
while ischar(tline)
    labels{qq}=tline;
    qq=qq+1;
    tline=fgetl(fid);
end
nlabels=qq-1;
end


function poslist=getWellPosList(center,npos,posscale)
%get list of positions from center, number of pos, and scale factor
totalpos=(2*npos+1)^2;
poslist=zeros(totalpos,3);
q=0;
for ii=-npos:1:npos
    for jj=-npos:1:npos
        q=q+1;
        ppos=center+posscale*[ii jj];
        poslist(q,1:2)=ppos;
    end
end
poslist(:,3)=2150.0*ones(totalpos,1); %set zlevels
end


function writeMMheader(fid)
% write this at top of file
fprintf(fid,'{\n');
fprintf(fid,'\t"VERSION": 3,\n');
fprintf(fid,'\t"ID": "Micro-Manager XY-position list",\n');
fprintf(fid,'\t"POSITIONS": [\n');
end

function writeMMfoot(fid)
%write this at bottom
fprintf(fid,'\t]\n');
fprintf(fid,'}\n');
end