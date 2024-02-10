%% Plate 1

clear all

%Folder of the experiment
nameexp = '/Volumes/storage/Elena/Endometrial_Organoids/230109_Endometrial_Organoids_Induction_2/RawData/REGULAR_CULTURE';

namefolder = 'RC_ST1'; %1

pathtodata = [nameexp filesep namefolder '_Cycle'];
pathtosavedata = nameexp;
mkdir([pathtosavedata, filesep, 'MaxProj'])
%%
allfiles = dir([pathtodata filesep '*.oir']);
platenumber = '2';%namefolder(2);%'2';
nwellsinrow = 6; %4 for 8 well dish, 6 for the 18-well
NZstacks = 3;
NChannels = 5;
Npositions = 3;

coordrow = length(namefolder) + 2; %strfind(allfiles(1).name,'_B0')+1;




sX = 1024;
sY = 1024;


for filenum = 1:length(allfiles)
            
            %File in
            fileIn = allfiles(filenum).name
            
            %For new name
            platenumber = platenumber;
            rownumber = double(fileIn(coordrow))-'A'+1;
            wellinrow = str2num(fileIn(coordrow+2));
            wellnumber = num2str((rownumber - 1)*nwellsinrow+wellinrow);
            posstr = strfind(fileIn,'_G0');
            positionnumber = str2num(fileIn(posstr+(2:4)));
            positionnumber = rem(positionnumber,Npositions);
            if positionnumber == 0
                positionnumber=num2str(Npositions);
            else
                positionnumber=num2str(positionnumber);
            end
            
            fileOut = [pathtosavedata filesep 'MaxProj/P',platenumber,'_W',wellnumber,'_',positionnumber,'_MAXProj.tif']
            

            
            img=bfopen([pathtodata filesep fileIn]);
            nsubimgs = size(img{1});
            nsubimgs = nsubimgs(1);
            NZstacks = nsubimgs/NChannels;
            
            for channelnum = 1:NChannels
                z=1;
                idx = channelnum+(z-1)*NChannels;
                imaux = img{1}{idx,1};
                maxprojchan = imaux;
                
                for z = 2:NZstacks
                    idx = channelnum+(z-1)*NChannels;
                    imaux = img{1}{idx,1};
                    
                    maxprojchan = max(maxprojchan,imaux);
                    
                    
                    
                end
                
                if channelnum==1
                imwrite(maxprojchan,fileOut,'Compression','none');
                else
                    imwrite(maxprojchan,fileOut,'writemode','append','Compression','none');
                end
                    
                
            end
            


end

disp('Finished')

