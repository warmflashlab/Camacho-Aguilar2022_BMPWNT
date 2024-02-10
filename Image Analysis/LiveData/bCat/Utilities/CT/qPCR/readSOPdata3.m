function dat = readSOPdata3(filename)
% modified from readSOPdata2 to output sample names instead of CT value
fid = fopen(filename,'r');

tline = fgetl(fid);

firstlinefound = 0;
q = 1;
while(ischar(tline))
    if firstlinefound == 0
        if strfind(tline,'Sample')
            firstlinefound = 1;
            splitline = strsplit(tline,',');
            ind = find(~cellfun(@isempty,strfind(splitline,'Sample Name')),1,'first');
        end
    else
        splitline = strsplit(tline,',');
        if length(splitline) < 2
            tline = fgetl(fid);
            tline = strrep(tline,',',', ');
            continue;
        end
        str  = (splitline{ind});
        str = strrep(str,' ','');
        str = [str (splitline{ind+1})];
        if str == ' ';
            str = strrep(str,' ','');
        end
        if ~isnumeric(str) && ~isempty(str)
            dat{q} = str;
        end
        q = q + 1;
    end
    tline = fgetl(fid);
    tline = strrep(tline,',',', ');
    
end
