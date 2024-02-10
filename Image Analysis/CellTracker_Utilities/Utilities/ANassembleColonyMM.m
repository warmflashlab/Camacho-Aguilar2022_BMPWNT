function fullIm=ANassembleColonyMM(direc,colnum,crop)   %imKeyWord

if ~exist('crop','var')
    crop=0;
end
si=[2048 2048];
%si=[1024 1344];
ff=readMMdirectory(direc);
dims = [ max(ff.pos_x) max(ff.pos_y)];
wavenames=ff.chan;

cc=load('outallControlMM.mat','acoords','plate1');% matfile
ac=cc.acoords;
coldata=cc.plate1.colonies(colnum).data;
%dims=cc.dims;

xmax=max(coldata(:,1)); xmin=min(coldata(:,1));
ymax=max(coldata(:,2)); ymin=min(coldata(:,2));

xsize=xmax-xmin; ysize=ymax-ymin;

rect=[xmin-25 ymin-25 xsize+50 ysize+50];

imnums=unique(coldata(:,end-1));
basenum=min(imnums);
imnums_red=imnums-basenum+1;

coords=ones(length(imnums),2);
for ii=1:length(imnums_red)
    coords(ii,1)=imnums_red(ii);
    while coords(ii,1) > dims(1)
        coords(ii,1)=coords(ii,1)-dims(1);
        coords(ii,2)=coords(ii,2)+1;
    end
end

%[junk, imFiles]=folderFilesFromKeyword(direc,imKeyWord{1});


for jj=1:length(wavenames)
    fullIm{jj}=zeros(si(1)*max(coords(:,1)),si(2)*max(coords(:,2)));
    for ii=1:length(imnums)
        [pos_x pos_y]=sub2ind(dims,imnums(ii));
        
        imname = mkMMfilename(files,pos_x,pos_y,[],[],wavenames(jj));
        currinds=[(coords(ii,1)-1)*si(1)+1 (coords(ii,2)-1)*si(2)+1];
        for kk=2:coords(ii,1)
            currinds(1)=currinds(1)-ac(basenum+(coords(ii,2)-1)*dims(1)+kk).wabove(1);
        end
        for mm=2:coords(ii,2)
            currinds(2)=currinds(2)-ac(basenum+(mm-1)*dims(1)+coords(ii,1)).wside(1);
        end
        currimgind=basenum+(coords(ii,2)-1)*dims(1)+coords(ii,1)-1;
        disp(int2str(currimgind))
        ac(currimgind).absinds=currinds;
       % if jj==1
            %imname=imFiles(currimgind).name;
       % else
         %   imname=strrep(imFiles(currimgind).name,wavenames{1},wavenames{jj});
       % end
        currimg=imread([direc filesep imname]);
        if exist('backIm','var')
            currimg=imsubtract(currimg,backIm);
        end
        fullIm{jj}(currinds(1):(currinds(1)+si(1)-1),currinds(2):(currinds(2)+si(2)-1))=currimg;

    end
            if crop
            fullIm{jj}=imcrop(fullIm{jj},rect);
        end
end