%% LOAD DATA

clear all

% read-in expression for all the genes and save as rnaseq.mat
filename = 'WNTdata_bulkRNASeqExpressionMat_samenamesrepeats.csv';
rnaseq_tab = readtable( filename ); rnaseq_cell = table2cell( rnaseq_tab );
rnaseq.exp_mat = cell2mat(table2cell(rnaseq_tab(:,3:end)));
rnaseq.ensembl_id = rnaseq_cell(:,1);
rnaseq.gene_name = rnaseq_cell(:,2);
rnaseq.treatment_name = rnaseq_tab.Properties.VariableNames(3:end);
rnaseq.treatment_name = {'mTeSR (R1)','WNT6h (R1)','WNT18h (R1)','CHIR6h (R1)','mTeSR (R2)','WNT6h (R2)','WNT18h (R2)','CHIR6h (R2)','CHIR18h (R2)','CHIR18h (R3)'};
% save("rnaseq.mat","rnaseq")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% REMOVE DUPLICATED ENSMBL IDs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cleanrnaseq.exp_mat = zeros(1,size(rnaseq.exp_mat,2));
cleanrnaseq.ensembl_id = cell(1,1);
cleanrnaseq.gene_name = cell(1,1);
cleanrnaseq.treatment_name = rnaseq.treatment_name;

auxcount = 0;

for ii = 1:length(rnaseq.ensembl_id)
    auxENSMBLid = rnaseq.ensembl_id{ii};
    
    if sum(strcmp(auxENSMBLid,cleanrnaseq.ensembl_id))==0
        auxcount = auxcount+1;
        commonENSEMBL = strcmp(auxENSMBLid,rnaseq.ensembl_id);
        
        cleanrnaseq.ensembl_id(auxcount,1) = rnaseq.ensembl_id(commonENSEMBL);
        cleanrnaseq.gene_name(auxcount,1) = rnaseq.gene_name(commonENSEMBL);
        
        cleanrnaseq.exp_mat(auxcount,:) = rnaseq.exp_mat(commonENSEMBL,:);

    end
    
end


rnaseq = cleanrnaseq;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Normalise by sample counts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rnaseq.exp_mat = rnaseq.exp_mat./sum(rnaseq.exp_mat);

rnaseq.exp_mat = rnaseq.exp_mat*1000000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ADDING UP EXPRESSION OF GENES THAT HAVE THE SAME NAME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

newrnaseq.exp_mat = zeros(1,size(rnaseq.exp_mat,2));
newrnaseq.ensembl_id = cell(1,1);
newrnaseq.gene_name = cell(1,1);
newrnaseq.treatment_name = rnaseq.treatment_name;

auxcount = 0;

for ii = 1:length(rnaseq.gene_name)
    auxgenename = rnaseq.gene_name{ii};
    if sum(strcmp(auxgenename,newrnaseq.gene_name))==0
        auxcount = auxcount+1;
        commongenes = strcmp(auxgenename,rnaseq.gene_name);
        
        newrnaseq.ensembl_id(auxcount,1) = {rnaseq.ensembl_id(commongenes)};
        newrnaseq.gene_name(auxcount,1) = {auxgenename};
        
        if sum(commongenes)>1
        newrnaseq.exp_mat(auxcount,:) = sum(rnaseq.exp_mat(commongenes,:));    
        else
            newrnaseq.exp_mat(auxcount,:) = rnaseq.exp_mat(commongenes,:);
        end
    end
    
end


% rnaseq = newrnaseq;

% save("rnaseq_sumcommongenes.mat","newrnaseq")

%% CLEAN DATA WITH MAX COUNTS <10
size(newrnaseq.exp_mat)
% rnaseq.exp_mat = round(rnaseq.exp_mat)
genestokeep = find(max(newrnaseq.exp_mat')>10);%<- rowSums(counts(gse_de)) > 1  #at least 1 count
rnaseq_clean = newrnaseq;
rnaseq_clean.exp_mat = rnaseq_clean.exp_mat(genestokeep,:);
rnaseq_clean.ensembl_id = rnaseq_clean.ensembl_id(genestokeep);
rnaseq_clean.gene_name = rnaseq_clean.gene_name(genestokeep);
size(rnaseq_clean.exp_mat)  %removed 16117 rows


%% NORMALIZE TO MTESR & TAKE LOGARITHM
% rnaseq_actbnorm = rnaseq;
% ACTBcomp = strcmp('ACTB',rnaseq.gene_name);
% rnaseq_actbnorm.exp_mat = rnaseq_actbnorm.exp_mat.*rnaseq_actbnorm.exp_mat(ACTBcomp,1)./rnaseq_actbnorm.exp_mat(ACTBcomp,:);
rnaseqlog = rnaseq_clean;
rnaseqlog.exp_mat(:,1:4) = rnaseqlog.exp_mat(:,1:4)./rnaseqlog.exp_mat(:,1);
rnaseqlog.exp_mat(:,5:9) = rnaseqlog.exp_mat(:,5:9)./rnaseqlog.exp_mat(:,5);
rnaseqlog.exp_mat = rnaseqlog.exp_mat(:,1:9);
rnaseqlog.treatment_name =rnaseqlog.treatment_name(1:9);
rnaseqlog.exp_mat = log2(rnaseqlog.exp_mat+1);


%% Find WNTs
% highestvariancegenesnames = rnaseq_actbnorm.gene_name(highestvariancegenes);
% highestvariancegenesnames = rsnorm(highestvariancegenes);


WNTSpresent = {};
numberWNTSpresent = [];

count = 1;
for ii = 1:size(rnaseqlog.exp_mat,1)
    auxname = rnaseqlog.gene_name{ii};
    if ~isempty(strfind(auxname,'WNT'))
%         if isempty(strfind(WNTSpresent,auxname))
        WNTSpresent{count} = auxname;
        numberWNTSpresent(count) = ii;
        count=count+1;
%         else
%         WNTSpresent{count} = [auxname,'-',num2str(sum(cell2mat(strfind(WNTSpresent,auxname))))];
%         numberWNTSpresent(count) = ii;
%         count=count+1;
%         end
            
    end
%     else
%         WNTSpresent{count} = [auxname,'-',num2str(sum(strfind(auxname,'WNT'))+1)];
%         numberWNTSpresent(count) = ii;
%         count=count+1;
%     end
    
end

figure;
set(gcf,'Position',[10 10 800 700])
cdata = rnaseqlog.exp_mat(numberWNTSpresent,:);%./max(rnaseqlog.exp_mat(numberWNTSpresent,:)')';
% cdata(:,1:4) = cdata(:,1:4)./cdata(:,1);
xvalues = WNTSpresent;
yvalues = rnaseqlog.treatment_name;
% figure
h = heatmap(yvalues,xvalues,cdata);
colormap(flipud(bone))

fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',18)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(fig,'-property','FontName'),'FontName','Arial')
mkdir('figures')
saveas(fig,['figures/RNAseqNorm_NormCounts'],'fig')
saveas(fig,['figures/RNAseqNorm_NormCounts'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures/RNAseqNorm_NormCounts'],'pdf')

%% Find WNTs
% highestvariancegenesnames = rnaseq_actbnorm.gene_name(highestvariancegenes);
% highestvariancegenesnames = rsnorm(highestvariancegenes);


WNTSpresent = {};
numberWNTSpresent = [];

count = 1;
for ii = 1:size(rnaseqlog.exp_mat,1)
    auxname = rnaseqlog.gene_name{ii};
    if ~isempty(strfind(auxname,'WNT'))
%         if isempty(strfind(WNTSpresent,auxname))
        WNTSpresent{count} = auxname;
        numberWNTSpresent(count) = ii;
        count=count+1;
%         else
%         WNTSpresent{count} = [auxname,'-',num2str(sum(cell2mat(strfind(WNTSpresent,auxname))))];
%         numberWNTSpresent(count) = ii;
%         count=count+1;
%         end
            
    end
%     else
%         WNTSpresent{count} = [auxname,'-',num2str(sum(strfind(auxname,'WNT'))+1)];
%         numberWNTSpresent(count) = ii;
%         count=count+1;
%     end
    
end

figure;
set(gcf,'Position',[10 10 800 300])
% cdata = rnaseqlog.exp_mat(numberWNTSpresent,:);%./max(rnaseqlog.exp_mat(numberWNTSpresent,:)')';
cdata = (rnaseqlog.exp_mat(numberWNTSpresent([1,3]),1:4) + rnaseqlog.exp_mat(numberWNTSpresent([1,3]),5:8))/2;
% cdata(:,1:4) = cdata(:,1:4)./cdata(:,1);
xvalues = WNTSpresent([1,3]);
yvalues = {'mTeSR','WNT6h','WNT18h','CHIR6h'};
% figure
h = heatmap(yvalues,xvalues,cdata);
colormap(flipud(bone))

fig = gcf;
fig.Color = 'w';
fig.InvertHardcopy = 'off';
set(findall(fig,'-property','FontSize'),'FontSize',30)
% set(findall(gcf,'-property','LineWidth'),'LineWidth',3)
set(findall(fig,'-property','FontName'),'FontName','Arial')
mkdir('figures')
saveas(fig,['figures/RNAseqNormAvg_NormCounts'],'fig')
saveas(fig,['figures/RNAseqNormAvg_NormCounts'],'svg')

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(fig,'filename','-dpdf','-r0')

saveas(fig,['figures/RNAseqNormAvg_NormCounts'],'pdf')

