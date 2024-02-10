function fullImage=StitchPreviewMM(files,acoords,chan,scale,xrange,yrange,bIm,nIm)

if ~exist('xrange','var') || isempty(xrange)
    xrange = files.pos_x;
end

if ~exist('yrange','var') || isempty(yrange)
    yrange = files.pos_y;
end

if ~exist('chan','var') || isempty(chan)
    chan='DAPI';
end

if ~exist('scale','var') || isempty(scale)
    scale = 0.2;
end

q=1;
for ii=xrange(end):-1:xrange(1)
    for jj=yrange(1):yrange(end)
        
        tmp = mkMMfilename(files,ii,jj,[],[],{chan});
        img = imread(tmp{1});
        
        if exist('bIm','var') && exist('nIm','var')
            img=imsubtract(img,bIm);
            img=immultiply(im2double(img),nIm);
            img=uint16(65536*img);
        end
        
        img =imresize(img,scale);
        
        
        if q == 1
            si = size(img);
            fullImage=zeros(length(xrange)*si(1),length(yrange)*si(2));
        end
        
        ind = sub2ind([length(files.pos_x) length(files.pos_y)],ii+1,jj+1);
        xy=ceil(scale*acoords(ind).absinds);
        
        if q==1
            xy0=xy;
        end
        
        xy=xy-xy0+1;
        
        disp(tmp{1});
        xy(xy<1)=1;
        fullImage(xy(2):(xy(2)+si(2)-1),xy(1):(xy(1)+si(1)-1))=img';
        q=q+1;
    end
end



