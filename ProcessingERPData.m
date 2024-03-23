nrowsOT=20;%4*5 ROIs OTs
nrowsNC=12;%4*5 ROIs NC
%datapath='/Volumes/Bayet Lab/Projects/Moulson Collaboration/Subjects';
%chanlocs=load('/Volumes/Bayet Lab/Projects/Moulson Collaboration/code/chanlocs_hcgsn129.mat');

%datapath='/Volumes/Bayet Lab/Projects/Moulson Collaboration/Subjects';
%chanlocs=load('/Volumes/Bayet Lab/Projects/Moulson Collaboration/code/chanlocs_hcgsn129.mat');

datapath='Z:\Projects\Moulson Collaboration\Subjects';
chanlocs=load('Z:\Projects\Moulson Collaboration\code\chanlocs_hcgsn129.mat');

%% preallocate filenamebased table for the OT table

Filename=repmat({'NA'},[nrowsOT,1]);
SubjID=repmat({'NA'},[nrowsOT,1]);
Age= NaN(nrowsOT,1);
Gender=[repmat({'Female'},[10,1]);repmat({'Male'},[10,1])];
Race=[repmat({'Other'},[5,1]);repmat({'Own'},[5,1]);repmat({'Other'},[5,1]);repmat({'Own'},[5,1])];
ROI = repmat([{'OTL'};{'OIL'};{'OIZ'};{'OIR'};{'OTR'}],[4,1]);
%ROI =repmat({'NA'},[nrowsOT,1]);
N290_Amp = NaN(nrowsOT,1);
P1_Amp = NaN(nrowsOT,1);
P400_Amp = NaN(nrowsOT,1);
N290_Lat = NaN(nrowsOT,1);
P1_Lat = NaN(nrowsOT,1);
P400_Lat = NaN(nrowsOT,1);
N290_cor = NaN(nrowsOT,1);

allchans = [];

% erp component timewindows
erptimes = [-100:2:998];

erpparamts(1).name='P1';
erpparamts(1).timewindow = [90 170];
erpparamts(1).timewindowidx = find((erptimes >= erpparamts(1).timewindow(1))&(erptimes <= erpparamts(1).timewindow(2)));

erpparamts(2).name='N290';
erpparamts(2).timewindow3 = [250 390];
erpparamts(2).timewindowidx3 = find((erptimes >= erpparamts(2).timewindow3(1))&(erptimes <= erpparamts(2).timewindow3(2)));
erpparamts(2).timewindow6 = [200 340];
erpparamts(2).timewindowidx6 = find((erptimes >= erpparamts(2).timewindow6(1))&(erptimes <= erpparamts(2).timewindow6(2)));
erpparamts(2).timewindow9 = [200 340];
erpparamts(2).timewindowidx9 = find((erptimes >= erpparamts(2).timewindow9(1))&(erptimes <= erpparamts(2).timewindow9(2)));

erpparamts(3).name='P400';
erpparamts(3).timewindow3 = [400 600];
erpparamts(3).timewindowidx3 = find((erptimes >= erpparamts(3).timewindow3(1))&(erptimes <= erpparamts(3).timewindow3(2)));
erpparamts(3).timewindow6 = [350 600];
erpparamts(3).timewindowidx6 = find((erptimes >= erpparamts(3).timewindow6(1))&(erptimes <= erpparamts(3).timewindow6(2)));
erpparamts(3).timewindow9 = [350 600];
erpparamts(3).timewindowidx9 = find((erptimes >= erpparamts(3).timewindow9(1))&(erptimes <= erpparamts(3).timewindow9(2)));


%roi parameters
roiparams(1).label='OTL';
roiparams(1).channellabs={'E50','E57','E58','E59','E63','E64','E65','E68'};
roiparams(1).channelidx=find(ismember({chanlocs.chanlocs.labels},roiparams(1).channellabs));

roiparams(2).label='OIL';
roiparams(2).channellabs={'E66','E69','E73','E74','E70'};
roiparams(2).channelidx=find(ismember({chanlocs.chanlocs.labels},roiparams(2).channellabs));

roiparams(3).label='OIZ';
roiparams(3).channellabs={'E72','E71','E81','E75','E76'};
roiparams(3).channelidx=find(ismember({chanlocs.chanlocs.labels},roiparams(3).channellabs));

roiparams(4).label='OIR';
roiparams(4).channellabs={'E84','E83','E82','E88','E89'};
roiparams(4).channelidx=find(ismember({chanlocs.chanlocs.labels},roiparams(4).channellabs));

roiparams(5).label='OTR';
roiparams(5).channellabs={'E91','E90','E94','E95','E99','E100','E101','E96'};
roiparams(5).channelidx=find(ismember({chanlocs.chanlocs.labels},roiparams(5).channellabs));

subjects = dir(datapath);
foldernames={subjects(:).name};
foldernames=foldernames(~ismember(foldernames,{'.','..'}));%remove the first two "fake" folders


data_matrix_foth_OTL_3=[];
data_matrix_fown_OTL_3=[];
data_matrix_moth_OTL_3=[];
data_matrix_mown_OTL_3=[];

data_matrix_foth_OIL_3=[];
data_matrix_fown_OIL_3=[];
data_matrix_moth_OIL_3=[];
data_matrix_mown_OIL_3=[];

data_matrix_foth_OIZ_3=[];
data_matrix_fown_OIZ_3=[];
data_matrix_moth_OIZ_3=[];
data_matrix_mown_OIZ_3=[];

data_matrix_foth_OIR_3=[];
data_matrix_fown_OIR_3=[];
data_matrix_moth_OIR_3=[];
data_matrix_mown_OIR_3=[];

data_matrix_foth_OTR_3=[];
data_matrix_fown_OTR_3=[];
data_matrix_moth_OTR_3=[];
data_matrix_mown_OTR_3=[];

data_matrix_foth_OTL_6=[];
data_matrix_fown_OTL_6=[];
data_matrix_moth_OTL_6=[];
data_matrix_mown_OTL_6=[];

data_matrix_foth_OIL_6=[];
data_matrix_fown_OIL_6=[];
data_matrix_moth_OIL_6=[];
data_matrix_mown_OIL_6=[];

data_matrix_foth_OIZ_6=[];
data_matrix_fown_OIZ_6=[];
data_matrix_moth_OIZ_6=[];
data_matrix_mown_OIZ_6=[];

data_matrix_foth_OIR_6=[];
data_matrix_fown_OIR_6=[];
data_matrix_moth_OIR_6=[];
data_matrix_mown_OIR_6=[];

data_matrix_foth_OTR_6=[];
data_matrix_fown_OTR_6=[];
data_matrix_moth_OTR_6=[];
data_matrix_mown_OTR_6=[];



data_matrix_foth_OTL_9=[];
data_matrix_fown_OTL_9=[];
data_matrix_moth_OTL_9=[];
data_matrix_mown_OTL_9=[];

data_matrix_foth_OIL_9=[];
data_matrix_fown_OIL_9=[];
data_matrix_moth_OIL_9=[];
data_matrix_mown_OIL_9=[];

data_matrix_foth_OIZ_9=[];
data_matrix_fown_OIZ_9=[];
data_matrix_moth_OIZ_9=[];
data_matrix_mown_OIZ_9=[];

data_matrix_foth_OIR_9=[];
data_matrix_fown_OIR_9=[];
data_matrix_moth_OIR_9=[];
data_matrix_mown_OIR_9=[];

data_matrix_foth_OTR_9=[];
data_matrix_fown_OTR_9=[];
data_matrix_moth_OTR_9=[];
data_matrix_mown_OTR_9=[];

data_matrix_foth_9=[];
data_matrix_fown_9=[];
data_matrix_moth_9=[];
data_matrix_mown_9=[];

data_matrix_foth_6=[];
data_matrix_fown_6=[];
data_matrix_moth_6=[];
data_matrix_mown_6=[];

data_matrix_foth_3=[];
data_matrix_fown_3=[];
data_matrix_moth_3=[];
data_matrix_mown_3=[];

lat_data_table = [];
lat_data_table_by_cond=[];


otl = roiparams(1).channelidx;
oil = roiparams(2).channelidx;
oiz = roiparams(3).channelidx;
otr = roiparams(4).channelidx;
oir = roiparams(5).channelidx;
otlr = [otl otr];
oizlr = [oil oiz oir];

allchans=[otl oil oiz otr oir];

i=1;

while i <= length(foldernames)
 tic
% disp(i)
 
    if foldernames{i} == ".DS_Store"
        i=i+1;
        continue
    end
 
    cd(fullfile(datapath,foldernames{i}));
    Filename=repmat(foldernames(i),[nrowsOT,1]);
    SubjID=repmat({foldernames{i}((end-2):end)},[nrowsOT,1]);
    age_kid=str2double(foldernames{i}(1));
    Age=repmat(age_kid,[nrowsOT,1]);
    
    foth=load('spycamERP_femother.mat');
    fown=load('spycamERP_femown.mat');
    moth=load('spycamERP_maleother.mat');
    mown=load('spycamERP_maleown.mat');
    
    
    %OT and OI ROIs
    for j = 1:5
        P1_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
            mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
        P1_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
            mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
        P1_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
            mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
        P1_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
            mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
        
        % peaks 
%         P1_peak(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
%             max(max(foth.femother(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
%         P1_peak(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
%             mean(max(fown.femown(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
%         P1_peak(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
%             mean(max(moth.maleother(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
%         P1_peak(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
%             mean(max(mown.maleown(roiparams(j).channelidx,erpparamts(1).timewindowidx)));

        P1_peak_foth = ...
            max(max(foth.femother(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
        P1_peak_fown = ...
            max(max(fown.femown(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
        P1_peak_moth = ...
            max(max(moth.maleother(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
        P1_peak_mown = ...
            max(max(mown.maleown(roiparams(j).channelidx,erpparamts(1).timewindowidx)));

        
        if age_kid == 3
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(2).timewindowidx3)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(2).timewindowidx3)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(2).timewindowidx3)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(2).timewindowidx3)));
            
            N290_cor(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                min(min(foth.femother(roiparams(j).channelidx,erpparamts(2).timewindowidx3)))- ...
                P1_peak_foth;
            
            N290_cor(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                min(min(fown.femown(roiparams(j).channelidx,erpparamts(2).timewindowidx3))) - ...
                P1_peak_fown;
            
            N290_cor(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                min(min(moth.maleother(roiparams(j).channelidx,erpparamts(2).timewindowidx3))) - ...
                P1_peak_moth;
            
            N290_cor(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                min(min(mown.maleown(roiparams(j).channelidx,erpparamts(2).timewindowidx3))) - ...
                P1_peak_mown;
            
            
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(3).timewindowidx3)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(3).timewindowidx3)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(3).timewindowidx3)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(3).timewindowidx3)));
            
        elseif age_kid ==6
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(2).timewindowidx6)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(2).timewindowidx6)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(2).timewindowidx6)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(2).timewindowidx6)));
            
            N290_cor(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                min(min(foth.femother(roiparams(j).channelidx,erpparamts(2).timewindowidx6))) - ...
                P1_peak_foth;
            
            N290_cor(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                min(min(fown.femown(roiparams(j).channelidx,erpparamts(2).timewindowidx6))) - ...
                P1_peak_fown;
            
            N290_cor(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                min(min(moth.maleother(roiparams(j).channelidx,erpparamts(2).timewindowidx6))) - ...
                P1_peak_moth;
            
            N290_cor(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                min(min(mown.maleown(roiparams(j).channelidx,erpparamts(2).timewindowidx6))) - ...
                P1_peak_mown;
            
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(3).timewindowidx6)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(3).timewindowidx6)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(3).timewindowidx6)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(3).timewindowidx6)));
            
            
        elseif age_kid == 9
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(2).timewindowidx9)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(2).timewindowidx9)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(2).timewindowidx9)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(2).timewindowidx9)));
            
            N290_cor(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                min(min(foth.femother(roiparams(j).channelidx,erpparamts(2).timewindowidx9))) - ...
                P1_peak_foth;
            
            N290_cor(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                min(min(fown.femown(roiparams(j).channelidx,erpparamts(2).timewindowidx9))) - ...
                P1_peak_fown;
            
            N290_cor(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                min(min(moth.maleother(roiparams(j).channelidx,erpparamts(2).timewindowidx9))) - ...
                P1_peak_moth;
            
            N290_cor(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                min(min(mown.maleown(roiparams(j).channelidx,erpparamts(2).timewindowidx9))) - ...
                P1_peak_mown;
            
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(3).timewindowidx9)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(3).timewindowidx9)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(3).timewindowidx9)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(3).timewindowidx9)));
        else
            error('Unknown age found')
        end
    
    end
    
    
    
     
    participant_data_table = table(Filename, SubjID, Age, ROI, Gender, Race, P1_Amp, N290_Amp, P400_Amp, N290_cor);
    if i==2
        data_table = participant_data_table;
    else
        data_table = [data_table; participant_data_table]; %#ok<AGROW>
    end

    %extract waveforms

    if age_kid == 3
        
        data_matrix_foth_3=[data_matrix_foth_3;mean(foth.femother(oizlr,:))];
        data_matrix_fown_3=[data_matrix_fown_3;mean(fown.femown(oizlr,:))];
        data_matrix_moth_3=[data_matrix_moth_3;mean(moth.maleother(oizlr,:))];
        data_matrix_mown_3=[data_matrix_mown_3;mean(mown.maleown(oizlr,:))];
       
        data_matrix_foth_OTL_3=[data_matrix_foth_OTL_3;mean(foth.femother(roiparams(1).channelidx,:))];
        data_matrix_fown_OTL_3=[data_matrix_fown_OTL_3;mean(fown.femown(roiparams(1).channelidx,:))];
        data_matrix_moth_OTL_3=[data_matrix_moth_OTL_3;mean(moth.maleother(roiparams(1).channelidx,:))];
        data_matrix_mown_OTL_3=[data_matrix_mown_OTL_3;mean(mown.maleown(roiparams(1).channelidx,:))];

        data_matrix_foth_OIL_3=[data_matrix_foth_OIL_3;mean(foth.femother(roiparams(2).channelidx,:))];
        data_matrix_fown_OIL_3=[data_matrix_fown_OIL_3;mean(fown.femown(roiparams(2).channelidx,:))];
        data_matrix_moth_OIL_3=[data_matrix_moth_OIL_3;mean(moth.maleother(roiparams(2).channelidx,:))];
        data_matrix_mown_OIL_3=[data_matrix_mown_OIL_3;mean(mown.maleown(roiparams(2).channelidx,:))];

        data_matrix_foth_OIZ_3=[data_matrix_foth_OIZ_3;mean(foth.femother(roiparams(3).channelidx,:))];
        data_matrix_fown_OIZ_3=[data_matrix_fown_OIZ_3;mean(fown.femown(roiparams(3).channelidx,:))];
        data_matrix_moth_OIZ_3=[data_matrix_moth_OIZ_3;mean(moth.maleother(roiparams(3).channelidx,:))];
        data_matrix_mown_OIZ_3=[data_matrix_mown_OIZ_3;mean(mown.maleown(roiparams(3).channelidx,:))];

        data_matrix_foth_OIR_3=[data_matrix_foth_OIR_3;mean(foth.femother(roiparams(4).channelidx,:))];
        data_matrix_fown_OIR_3=[data_matrix_fown_OIR_3;mean(fown.femown(roiparams(4).channelidx,:))];
        data_matrix_moth_OIR_3=[data_matrix_moth_OIR_3;mean(moth.maleother(roiparams(4).channelidx,:))];
        data_matrix_mown_OIR_3=[data_matrix_mown_OIR_3;mean(mown.maleown(roiparams(4).channelidx,:))];

        data_matrix_foth_OTR_3=[data_matrix_foth_OTR_3;mean(foth.femother(roiparams(5).channelidx,:))];
        data_matrix_fown_OTR_3=[data_matrix_fown_OTR_3;mean(fown.femown(roiparams(5).channelidx,:))];
        data_matrix_moth_OTR_3=[data_matrix_moth_OTR_3;mean(moth.maleother(roiparams(5).channelidx,:))];
        data_matrix_mown_OTR_3=[data_matrix_mown_OTR_3;mean(mown.maleown(roiparams(5).channelidx,:))];
        
    elseif age_kid == 6
        
        data_matrix_foth_6=[data_matrix_foth_6;mean(foth.femother(oizlr,:))];
        data_matrix_fown_6=[data_matrix_fown_6;mean(fown.femown(oizlr,:))];
        data_matrix_moth_6=[data_matrix_moth_6;mean(moth.maleother(oizlr,:))];
        data_matrix_mown_6=[data_matrix_mown_6;mean(mown.maleown(oizlr,:))];
        
        data_matrix_foth_OTL_6=[data_matrix_foth_OTL_6;mean(foth.femother(roiparams(1).channelidx,:))];
        data_matrix_fown_OTL_6=[data_matrix_fown_OTL_6;mean(fown.femown(roiparams(1).channelidx,:))];
        data_matrix_moth_OTL_6=[data_matrix_moth_OTL_6;mean(moth.maleother(roiparams(1).channelidx,:))];
        data_matrix_mown_OTL_6=[data_matrix_mown_OTL_6;mean(mown.maleown(roiparams(1).channelidx,:))];

        data_matrix_foth_OIL_6=[data_matrix_foth_OIL_6;mean(foth.femother(roiparams(2).channelidx,:))];
        data_matrix_fown_OIL_6=[data_matrix_fown_OIL_6;mean(fown.femown(roiparams(2).channelidx,:))];
        data_matrix_moth_OIL_6=[data_matrix_moth_OIL_6;mean(moth.maleother(roiparams(2).channelidx,:))];
        data_matrix_mown_OIL_6=[data_matrix_mown_OIL_6;mean(mown.maleown(roiparams(2).channelidx,:))];

        data_matrix_foth_OIZ_6=[data_matrix_foth_OIZ_6;mean(foth.femother(roiparams(3).channelidx,:))];
        data_matrix_fown_OIZ_6=[data_matrix_fown_OIZ_6;mean(fown.femown(roiparams(3).channelidx,:))];
        data_matrix_moth_OIZ_6=[data_matrix_moth_OIZ_6;mean(moth.maleother(roiparams(3).channelidx,:))];
        data_matrix_mown_OIZ_6=[data_matrix_mown_OIZ_6;mean(mown.maleown(roiparams(3).channelidx,:))];

        data_matrix_foth_OIR_6=[data_matrix_foth_OIR_6;mean(foth.femother(roiparams(4).channelidx,:))];
        data_matrix_fown_OIR_6=[data_matrix_fown_OIR_6;mean(fown.femown(roiparams(4).channelidx,:))];
        data_matrix_moth_OIR_6=[data_matrix_moth_OIR_6;mean(moth.maleother(roiparams(4).channelidx,:))];
        data_matrix_mown_OIR_6=[data_matrix_mown_OIR_6;mean(mown.maleown(roiparams(4).channelidx,:))];

        data_matrix_foth_OTR_6=[data_matrix_foth_OTR_6;mean(foth.femother(roiparams(5).channelidx,:))];
        data_matrix_fown_OTR_6=[data_matrix_fown_OTR_6;mean(fown.femown(roiparams(5).channelidx,:))];
        data_matrix_moth_OTR_6=[data_matrix_moth_OTR_6;mean(moth.maleother(roiparams(5).channelidx,:))];
        data_matrix_mown_OTR_6=[data_matrix_mown_OTR_6;mean(mown.maleown(roiparams(5).channelidx,:))];
    
    elseif age_kid == 9
        
        data_matrix_foth_9=[data_matrix_foth_9;mean(foth.femother(oizlr,:))];
        data_matrix_fown_9=[data_matrix_fown_9;mean(fown.femown(oizlr,:))];
        data_matrix_moth_9=[data_matrix_moth_9;mean(moth.maleother(oizlr,:))];
        data_matrix_mown_9=[data_matrix_mown_9;mean(mown.maleown(oizlr,:))];
        
        data_matrix_foth_OTL_9=[data_matrix_foth_OTL_9;mean(foth.femother(roiparams(1).channelidx,:))];
        data_matrix_fown_OTL_9=[data_matrix_fown_OTL_9;mean(fown.femown(roiparams(1).channelidx,:))];
        data_matrix_moth_OTL_9=[data_matrix_moth_OTL_9;mean(moth.maleother(roiparams(1).channelidx,:))];
        data_matrix_mown_OTL_9=[data_matrix_mown_OTL_9;mean(mown.maleown(roiparams(1).channelidx,:))];

               
        data_matrix_foth_OIL_9=[data_matrix_foth_OIL_9;mean(foth.femother(roiparams(2).channelidx,:))];
        data_matrix_fown_OIL_9=[data_matrix_fown_OIL_9;mean(fown.femown(roiparams(2).channelidx,:))];
        data_matrix_moth_OIL_9=[data_matrix_moth_OIL_9;mean(moth.maleother(roiparams(2).channelidx,:))];
        data_matrix_mown_OIL_9=[data_matrix_mown_OIL_9;mean(mown.maleown(roiparams(2).channelidx,:))];

        
        data_matrix_foth_OIZ_9=[data_matrix_foth_OIZ_9;mean(foth.femother(roiparams(3).channelidx,:))];
        data_matrix_fown_OIZ_9=[data_matrix_fown_OIZ_9;mean(fown.femown(roiparams(3).channelidx,:))];
        data_matrix_moth_OIZ_9=[data_matrix_moth_OIZ_9;mean(moth.maleother(roiparams(3).channelidx,:))];
        data_matrix_mown_OIZ_9=[data_matrix_mown_OIZ_9;mean(mown.maleown(roiparams(3).channelidx,:))];

        data_matrix_foth_OIR_9=[data_matrix_foth_OIR_9;mean(foth.femother(roiparams(4).channelidx,:))];
        data_matrix_fown_OIR_9=[data_matrix_fown_OIR_9;mean(fown.femown(roiparams(4).channelidx,:))];
        data_matrix_moth_OIR_9=[data_matrix_moth_OIR_9;mean(moth.maleother(roiparams(4).channelidx,:))];
        data_matrix_mown_OIR_9=[data_matrix_mown_OIR_9;mean(mown.maleown(roiparams(4).channelidx,:))];

        data_matrix_foth_OTR_9=[data_matrix_foth_OTR_9;mean(foth.femother(roiparams(5).channelidx,:))];
        data_matrix_fown_OTR_9=[data_matrix_fown_OTR_9;mean(fown.femown(roiparams(5).channelidx,:))];
        data_matrix_moth_OTR_9=[data_matrix_moth_OTR_9;mean(moth.maleother(roiparams(5).channelidx,:))];
        data_matrix_mown_OTR_9=[data_matrix_mown_OTR_9;mean(mown.maleown(roiparams(5).channelidx,:))];

        
    end
    
    p1_timewindow = erpparamts(1).timewindowidx;
    if age_kid == 3  
        n290_timewindow = erpparamts(2).timewindowidx3;
        p400_timewindow = erpparamts(3).timewindowidx3;
    elseif age_kid == 6
        n290_timewindow = erpparamts(2).timewindowidx6;
        p400_timewindow = erpparamts(3).timewindowidx6;
    elseif age_kid == 9
        n290_timewindow = erpparamts(2).timewindowidx9;
        p400_timewindow = erpparamts(3).timewindowidx9;
    end 
    
    %%%%%%%%%%%%%% Peak latency calculations
        % Min N290 (single participant)
        allconds_single_participant= cat(3, mown.maleown, moth.maleother, foth.femother, fown.femown);
        
        [~,min_n290_single_participant]=min(mean(mean(allconds_single_participant(otlr,n290_timewindow,:),3),1));
        peak_lat_N290_single_participant = erptimes(n290_timewindow(min_n290_single_participant));
        
        % Max P400 (single participant)
        [~,max_p400_single_participant]=max(mean(mean(allconds_single_participant(otlr,p400_timewindow,:),3),1));
        peak_lat_P400_single_participant = erptimes(p400_timewindow(max_p400_single_participant));
        
         %Max P1 
        [~,max_p1_single_participant]=max(mean(mean(allconds_single_participant(oizlr,p1_timewindow,:),3),1));
        peak_lat_P1_single_participant = erptimes(p1_timewindow(max_p1_single_participant));
        
    
 
   
       latency_data_table = table(age_kid, peak_lat_P1_single_participant, peak_lat_N290_single_participant, peak_lat_P400_single_participant);
     lat_data_table = [lat_data_table; latency_data_table]; %#ok<AGROW>

     
     
     
     
     %%%%%%%%%% lat by condition
         femown_single_participant= fown.femown;
         femother_single_participant= foth.femother;
         maleown_single_participant= mown.maleown;
         maleother_single_participant= moth.maleother;
         
         %%% femown
        %min n290
        [~,min_n290_single_participant]=min(mean(mean(femown_single_participant(otlr,n290_timewindow,:),3),1));
        peak_lat_N290_single_participant_femown = erptimes(n290_timewindow(min_n290_single_participant));
        
        % Max P400 (single participant)
        [~,max_p400_single_participant]=max(mean(mean(femown_single_participant(otlr,p400_timewindow,:),3),1));
        peak_lat_P400_single_participant_femown = erptimes(p400_timewindow(max_p400_single_participant));
        
         %Max P1 
        [~,max_p1_single_participant]=max(mean(mean(femown_single_participant(oizlr,p1_timewindow,:),3),1));
        peak_lat_P1_single_participant_femown = erptimes(p1_timewindow(max_p1_single_participant));
        
        %%% femother
        % n290
        [~,min_n290_single_participant]=min(mean(mean(femother_single_participant(otlr,n290_timewindow,:),3),1));
        peak_lat_N290_single_participant_femother = erptimes(n290_timewindow(min_n290_single_participant));
        
        % Max P400 (single participant)
        [~,max_p400_single_participant]=max(mean(mean(femother_single_participant(otlr,p400_timewindow,:),3),1));
        peak_lat_P400_single_participant_femother = erptimes(p400_timewindow(max_p400_single_participant));
        
         %Max P1 
        [~,max_p1_single_participant]=max(mean(mean(femother_single_participant(oizlr,p1_timewindow,:),3),1));
        peak_lat_P1_single_participant_femother = erptimes(p1_timewindow(max_p1_single_participant));
        
        %%% maleown
        %n290
        [~,min_n290_single_participant]=min(mean(mean(maleown_single_participant(otlr,n290_timewindow,:),3),1));
        peak_lat_N290_single_participant_maleown = erptimes(n290_timewindow(min_n290_single_participant));
        
        % Max P400 (single participant)
        [~,max_p400_single_participant]=max(mean(mean(maleown_single_participant(otlr,p400_timewindow,:),3),1));
        peak_lat_P400_single_participant_maleown = erptimes(p400_timewindow(max_p400_single_participant));
        
         %Max P1 
        [~,max_p1_single_participant]=max(mean(mean(maleown_single_participant(oizlr,p1_timewindow,:),3),1));
        peak_lat_P1_single_participant_maleown = erptimes(p1_timewindow(max_p1_single_participant));
        
        %%% maleother
        %n290
        
        [~,min_n290_single_participant]=min(mean(mean(maleother_single_participant(otlr,n290_timewindow,:),3),1));
        peak_lat_N290_single_participant_maleother = erptimes(n290_timewindow(min_n290_single_participant));
        
        % Max P400 (single participant)
        [~,max_p400_single_participant]=max(mean(mean(maleother_single_participant(otlr,p400_timewindow,:),3),1));
        peak_lat_P400_single_participant_maleother = erptimes(p400_timewindow(max_p400_single_participant));
        
         %Max P1 
        [~,max_p1_single_participant]=max(mean(mean(maleother_single_participant(oizlr,p1_timewindow,:),3),1));
        peak_lat_P1_single_participant_maleother = erptimes(p1_timewindow(max_p1_single_participant));
        
     
     
     
       latency_data_table_by_cond = table(age_kid, peak_lat_P1_single_participant_femown, peak_lat_N290_single_participant_femown, peak_lat_P400_single_participant_femown,peak_lat_P1_single_participant_femother, peak_lat_N290_single_participant_femother, peak_lat_P400_single_participant_femother,peak_lat_P1_single_participant_maleown, peak_lat_N290_single_participant_maleown, peak_lat_P400_single_participant_maleown,peak_lat_P1_single_participant_maleother, peak_lat_N290_single_participant_maleother, peak_lat_P400_single_participant_maleother);
        lat_data_table_by_cond = [lat_data_table_by_cond; latency_data_table_by_cond]; %#ok<AGROW>

     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
%      %%%%%%%%%%%%%%%%%%%% N290 P1 peak-peak correction
%      
%      N290_cor =  
%      
%      
%      %%%%%%%%%%%%%%% save data to table
%      
%     participant_data_table = table(Filename, SubjID, Age, ROI, Gender, Race, P1_Amp, N290_Amp, P400_Amp, N290_cor);
%     if i==2
%         data_table = participant_data_table;
%     else
%         data_table = [data_table; participant_data_table]; %#ok<AGROW>
%     end
     
     i=i+1; 
     toc      
end

%writetable(data_table,'../../data_table.csv')

%save('lat_data_table.mat','lat_data_table')
save('lat_data_table_by_cond.mat','lat_data_table_by_cond')

% 
%writetable(lat_data_table,'/Volumes/Bayet Lab/Projects/Moulson Collaboration/processed data/lat_data_table.csv')

%writetable(data_table,'/home/kira/ShareDrives/BayetLab/Projects/Moulson Collaboration/processed data/data_table.csv')

data_matrix_occ_avg_9 = mean(cat(3,data_matrix_foth_OIL_9,data_matrix_fown_OIL_9,data_matrix_moth_OIL_9,data_matrix_mown_OIL_9,...
          data_matrix_foth_OIZ_9, data_matrix_fown_OIZ_9,data_matrix_moth_OIZ_9, data_matrix_mown_OIZ_9,...
          data_matrix_foth_OIR_9, data_matrix_fown_OIR_9, data_matrix_moth_OIR_9, data_matrix_mown_OIR_9),3);

data_matrix_occ_avg_6 = mean(cat(3,data_matrix_foth_OIL_6,data_matrix_fown_OIL_6,data_matrix_moth_OIL_6,data_matrix_mown_OIL_6,...
          data_matrix_foth_OIZ_6, data_matrix_fown_OIZ_6,data_matrix_moth_OIZ_6, data_matrix_mown_OIZ_6,...
          data_matrix_foth_OIR_6, data_matrix_fown_OIR_6, data_matrix_moth_OIR_6, data_matrix_mown_OIR_6),3);

data_matrix_occ_avg_3 = mean(cat(3,data_matrix_foth_OIL_3,data_matrix_fown_OIL_3,data_matrix_moth_OIL_3,data_matrix_mown_OIL_3,...
          data_matrix_foth_OIZ_3, data_matrix_fown_OIZ_3,data_matrix_moth_OIZ_3, data_matrix_mown_OIZ_3,...
          data_matrix_foth_OIR_3, data_matrix_fown_OIR_3, data_matrix_moth_OIR_3, data_matrix_mown_OIR_3),3);

%disp(data_table)
%save('data_table.mat','data_table')

%save data matrices for plotting

%writetable(data_table,'/Volumes/Bayet Lab/Projects/Moulson Collaboration/processed data/data_table.csv')

%writetable(data_table,'/home/kira/ShareDrives/BayetLab/Projects/Moulson Collaboration/processed data/data_table.csv')



























return 

%%%%%%%%%%%%%%%%%%% PLOT OCC 9MO 


f1 = figure; 
lwplot=2;
figure(f1); 
set(gca,'FontSize',36)


h(1)=plot(erptimes, mean(data_matrix_foth_9),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_9),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_9),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(4)=plot(erptimes, mean(data_matrix_mown_9),'LineWidth',lwplot,'color',[.8 .6 .7]);
plot(erptimes,zeros(size(erptimes)),':k')
title('Occipital 9 Months')
%%legend(h,{'Female Other','Female Own','Male Other','Male Own'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([-100 1000])
ylim([-15 25])




%%%% PLOT AVG PER AGE, BROKEN DOWN BY CONDITION

return

f9 = figure; 
lwplot=2;
figure(f9); 
set(gca,'FontSize',36)

subplot(3,1,1)
h(1)=plot(erptimes, mean(data_matrix_foth_3),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_3),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_3),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(4)=plot(erptimes, mean(data_matrix_mown_3),'LineWidth',lwplot,'color',[.8 .6 .7]);
plot(erptimes,zeros(size(erptimes)),':k')
title('3 Months')

hold off 
xlim([-100 1000])
ylim([-15 25])

%%%
subplot(3,1,2)
h(1)=plot(erptimes, mean(data_matrix_foth_6),'LineWidth',lwplot,'color',[.0 .0 .0]); hold on
h(2)=plot(erptimes, mean(data_matrix_fown_6),'LineWidth',lwplot,'color',[.9 .6 .0])
h(3)=plot(erptimes, mean(data_matrix_moth_6),'LineWidth',lwplot,'color',[.0 .6 .5])
h(4)=plot(erptimes, mean(data_matrix_mown_6),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('6 Months')


hold off 
xlim([-100 1000])
ylim([-15 25])

subplot(3,1,3)
h(1)=plot(erptimes, mean(data_matrix_foth_9),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
h(2)=plot(erptimes, mean(data_matrix_fown_9),'LineWidth',lwplot,'color',[.9 .6 .0])
h(3)=plot(erptimes, mean(data_matrix_moth_9),'LineWidth',lwplot,'color',[.0 .6 .5])
h(4)=plot(erptimes, mean(data_matrix_mown_9),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('9 Months')
%legend(h,{'Female Other','Female Own','Male Other','Male Own'})
%legend boxoff 
hold off 
xlim([-100 1000])
ylim([-15 25])






return

f1 = figure; 
lwplot=2;
figure(f1); 
set(gca,'FontSize',36)

subplot(5,3,1)
h(1)=plot(erptimes, mean(data_matrix_foth_OTL_3),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_OTL_3),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_OTL_3),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(4)=plot(erptimes, mean(data_matrix_mown_OTL_3),'LineWidth',lwplot,'color',[.8 .6 .7]);
plot(erptimes,zeros(size(erptimes)),':k')
title('OTL 3 Months')
%%legend(h,{'Female Other','Female Own','Male Other','Male Own'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([-100 1000])
ylim([-15 25])

%%%
subplot(5,3,4)
h(1)=plot(erptimes, mean(data_matrix_foth_OIL_3),'LineWidth',lwplot,'color',[.0 .0 .0]); hold on
h(2)=plot(erptimes, mean(data_matrix_fown_OIL_3),'LineWidth',lwplot,'color',[.9 .6 .0])
h(3)=plot(erptimes, mean(data_matrix_moth_OIL_3),'LineWidth',lwplot,'color',[.0 .6 .5])
h(4)=plot(erptimes, mean(data_matrix_mown_OIL_3),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OIL 3 Months')
%legend(h,{'Female Other','Female Own','Male Other','Male Own'})
%legend boxoff 

hold off 
xlim([-100 1000])
ylim([-15 25])

subplot(5,3,7)
plot(erptimes, mean(data_matrix_foth_OIZ_3),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
h(1)=plot(erptimes, mean(data_matrix_fown_OIZ_3),'LineWidth',lwplot,'color',[.9 .6 .0])
h(2)=plot(erptimes, mean(data_matrix_moth_OIZ_3),'LineWidth',lwplot,'color',[.0 .6 .5])
h(3)=plot(erptimes, mean(data_matrix_mown_OIZ_3),'LineWidth',lwplot,'color',[.8 .6 .7])
h(4)=plot(erptimes,zeros(size(erptimes)),':k')
title('OIZ 3 Months')
%legend(h,{'Female Other','Female Own','Male Other','Male Own'})
%legend boxoff 
hold off 
xlim([-100 1000])
ylim([-15 25])

subplot(5,3,10)

h(1)=plot(erptimes, mean(data_matrix_foth_OIR_3),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
h(2)=plot(erptimes, mean(data_matrix_fown_OIR_3),'LineWidth',lwplot,'color',[.9 .6 .0])
h(3)=plot(erptimes, mean(data_matrix_moth_OIR_3),'LineWidth',lwplot,'color',[.0 .6 .5])
h(4)=plot(erptimes, mean(data_matrix_mown_OIR_3),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OIR 3 Months')
%legend(h,{'Female Other','Female Own','Male Other','Male Own'})
%legend boxoff 
hold off
xlim([-100 1000])
ylim([-15 25])

subplot(5,3,13)
h(1)=plot(erptimes, mean(data_matrix_foth_OTR_3),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
h(2)=plot(erptimes, mean(data_matrix_fown_OTR_3),'LineWidth',lwplot,'color',[.9 .6 .0])
h(3)=plot(erptimes, mean(data_matrix_moth_OTR_3),'LineWidth',lwplot,'color',[.0 .6 .5])
h(4)=plot(erptimes, mean(data_matrix_mown_OTR_3),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OTR 3 Months')
%legend(h,{'Female Other','Female Own','Male Other','Male Own'})
%legend boxoff 
hold off
xlim([-100 1000])
ylim([-15 25])

subplot(5,3,2)

plot(erptimes, mean(data_matrix_foth_OTL_6),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
plot(erptimes, mean(data_matrix_fown_OTL_6),'LineWidth',lwplot,'color',[.9 .6 .0])
plot(erptimes, mean(data_matrix_moth_OTL_6),'LineWidth',lwplot,'color',[.0 .6 .5])
plot(erptimes, mean(data_matrix_mown_OTL_6),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OTL 6 Months')
%%legend('Female Other','Female Own','Male Other','Male Own')

hold off 
xlim([-100 1000])
ylim([-15 25])
%%%

subplot(5,3,5)

plot(erptimes, mean(data_matrix_foth_OIL_6),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
plot(erptimes, mean(data_matrix_fown_OIL_6),'LineWidth',lwplot,'color',[.9 .6 .0])
plot(erptimes, mean(data_matrix_moth_OIL_6),'LineWidth',lwplot,'color',[.0 .6 .5])
plot(erptimes, mean(data_matrix_mown_OIL_6),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OIL 6 Months')
%%legend('Female Other','Female Own','Male Other','Male Own')

hold off 
xlim([-100 1000])
ylim([-15 25])

subplot(5,3,8)

plot(erptimes, mean(data_matrix_foth_OIZ_6),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
plot(erptimes, mean(data_matrix_fown_OIZ_6),'LineWidth',lwplot,'color',[.9 .6 .0])
plot(erptimes, mean(data_matrix_moth_OIZ_6),'LineWidth',lwplot,'color',[.0 .6 .5])
plot(erptimes, mean(data_matrix_mown_OIZ_6),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OIZ 6 Months')
%%legend('Female Other','Female Own','Male Other','Male Own')

hold off 
xlim([-100 1000])
ylim([-15 25])

subplot( 5,3,11)

plot(erptimes, mean(data_matrix_foth_OIR_6),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
plot(erptimes, mean(data_matrix_fown_OIR_6),'LineWidth',lwplot,'color',[.9 .6 .0])
plot(erptimes, mean(data_matrix_moth_OIR_6),'LineWidth',lwplot,'color',[.0 .6 .5])
plot(erptimes, mean(data_matrix_mown_OIR_6),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OIR 6 Months')
%%legend('Female Other','Female Own','Male Other','Male Own')

hold off
xlim([-100 1000])
ylim([-15 25])

subplot(5,3,14)

plot(erptimes, mean(data_matrix_foth_OTR_6),'LineWidth',lwplot,'color',[.0 .0 .0])

hold on
plot(erptimes, mean(data_matrix_fown_OTR_6),'LineWidth',lwplot,'color',[.9 .6 .0])
plot(erptimes, mean(data_matrix_moth_OTR_6),'LineWidth',lwplot,'color',[.0 .6 .5])
plot(erptimes, mean(data_matrix_mown_OTR_6),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OTR 6 Months')
%%legend('Female Other','Female Own','Male Other','Male Own')

hold off
xlim([-100 1000])
ylim([-10 25])

subplot(5,3,3)

plot(erptimes, mean(data_matrix_foth_OTL_9),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
plot(erptimes, mean(data_matrix_fown_OTL_9),'LineWidth',lwplot,'color',[.9 .6 .0])
plot(erptimes, mean(data_matrix_moth_OTL_9),'LineWidth',lwplot,'color',[.0 .6 .5])
plot(erptimes, mean(data_matrix_mown_OTL_9),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OTL 9 Months')
%%legend('Female Other','Female Own','Male Other','Male Own')

hold off 
xlim([-100 1000])
ylim([-15 25])
%%%

subplot(5,3,6)

plot(erptimes, mean(data_matrix_foth_OIL_9),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
plot(erptimes, mean(data_matrix_fown_OIL_9),'LineWidth',lwplot,'color',[.9 .6 .0])
plot(erptimes, mean(data_matrix_moth_OIL_9),'LineWidth',lwplot,'color',[.0 .6 .5])
plot(erptimes, mean(data_matrix_mown_OIL_9),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OIL 9 Months')
%%legend('Female Other','Female Own','Male Other','Male Own')
hold off 
xlim([-100 1000])
ylim([-15 25])

subplot(5,3,9)

plot(erptimes, mean(data_matrix_foth_OIZ_9),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
plot(erptimes, mean(data_matrix_fown_OIZ_9),'LineWidth',lwplot,'color',[.9 .6 .0])
plot(erptimes, mean(data_matrix_moth_OIZ_9),'LineWidth',lwplot,'color',[.0 .6 .5])
plot(erptimes, mean(data_matrix_mown_OIZ_9),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OIZ 9 Months')
%%legend('Female Other','Female Own','Male Other','Male Own')

hold off 
xlim([-100 1000])
ylim([-15 25])

subplot(5,3,12)

plot(erptimes, mean(data_matrix_foth_OIR_9),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
plot(erptimes, mean(data_matrix_fown_OIR_9),'LineWidth',lwplot,'color',[.9 .6 .0])
plot(erptimes, mean(data_matrix_moth_OIR_9),'LineWidth',lwplot,'color',[.0 .6 .5])
plot(erptimes, mean(data_matrix_mown_OIR_9),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OIR 9 Months')
%%legend('Female Other','Female Own','Male Other','Male Own')

hold off
xlim([-100 1000])
ylim([-15 25])

subplot(5,3,15)
plot(erptimes, mean(data_matrix_foth_OTR_9),'LineWidth',lwplot,'color',[.0 .0 .0])
hold on
plot(erptimes, mean(data_matrix_fown_OTR_9),'LineWidth',lwplot,'color',[.9 .6 .0])
plot(erptimes, mean(data_matrix_moth_OTR_9),'LineWidth',lwplot,'color',[.0 .6 .5])
plot(erptimes, mean(data_matrix_mown_OTR_9),'LineWidth',lwplot,'color',[.8 .6 .7])
plot(erptimes,zeros(size(erptimes)),':k')
title('OTR 9 Months')
%%legend('Female Other','Female Own','Male Other','Male Own')

hold off
xlim([-100 1000])
ylim([-15 25])

return

otl = roiparams(1).channelidx;
oil = roiparams(2).channelidx;
oiz = roiparams(3).channelidx;
otr = roiparams(4).channelidx;
oir = roiparams(5).channelidx;
otlr = [otl otr]
oizlr = [oil oiz oir]

allchans=[otl oil oiz otr oir];

EGI=load('/Volumes/Bayet Lab/Projects/Moulson Collaboration/code/chanlocs_hcgsn129.mat');
hFig1=figure;set(hFig1, 'Position', [1 1 250 250]); hold on;
set(0,'DefaultAxesFontName', 'Arial')
set(gca,'FontSize',15)
hold on
%topoplot([], EGI.chanlocs(allchans), 'electcolor','blue','electrodes','ptslabels','plotrad',0.8,  'whitebk','on' ,'emarker',{'.','k',30});
topoplot([], EGI.chanlocs(otl), 'electrodes','ptslabels','plotrad',0.8,  'whitebk','on' ,'emarker',{'.','b',30});
topoplot([], EGI.chanlocs(oil), 'electrodes','ptslabels','plotrad',0.8,  'whitebk','on' ,'emarker',{'.','k',30});
topoplot([], EGI.chanlocs(oiz), 'electrodes','ptslabels','plotrad',0.8,  'whitebk','on' ,'emarker',{'.','r',30});
topoplot([], EGI.chanlocs(otr), 'electrodes','ptslabels','plotrad',0.8,  'whitebk','on' ,'emarker',{'.','g',30});
topoplot([], EGI.chanlocs(oir), 'electrodes','ptslabels','plotrad',0.8,  'whitebk','on' ,'emarker',{'.','m',30});
title('')

return







%%%%%%%%%%%%%%%%%%%%  AVERAGE WAFEFORM OVER ALL CONDITIONS SEP BY AGE DATA

 data_matrix_3 = (...
 data_matrix_foth_OIL_3 + data_matrix_fown_OIL_3 + data_matrix_moth_OIL_3 + data_matrix_mown_OIL_3 +... 
 data_matrix_foth_OIZ_3 + data_matrix_fown_OIZ_3 + data_matrix_moth_OIZ_3 + data_matrix_mown_OIZ_3 +...
 data_matrix_foth_OIR_3 + data_matrix_fown_OIR_3 + data_matrix_moth_OIR_3 + data_matrix_mown_OIR_3 ...
 )/12

 data_matrix_6 = (...
 data_matrix_foth_OIL_6 + data_matrix_fown_OIL_6 + data_matrix_moth_OIL_6 + data_matrix_mown_OIL_6 +... 
 data_matrix_foth_OIZ_6 + data_matrix_fown_OIZ_6 + data_matrix_moth_OIZ_6 + data_matrix_mown_OIZ_6 +...
 data_matrix_foth_OIR_6 + data_matrix_fown_OIR_6 + data_matrix_moth_OIR_6 + data_matrix_mown_OIR_6 ...
 )/12

 data_matrix_9 = (...
 data_matrix_foth_OIL_9 + data_matrix_fown_OIL_9 + data_matrix_moth_OIL_9 + data_matrix_mown_OIL_9 +... 
 data_matrix_foth_OIZ_9 + data_matrix_fown_OIZ_9 + data_matrix_moth_OIZ_9 + data_matrix_mown_OIZ_9 +...
 data_matrix_foth_OIR_9 + data_matrix_fown_OIR_9 + data_matrix_moth_OIR_9 + data_matrix_mown_OIR_9 ...
 )/12

%%%%%%%%%%%%%%%%%%%%  AVERAGE WAFEFORM OVER ALL CONDITIONS SEP BY AGE FIG
%%%%%%%%%%%%%%%%%%%%  (one line, not wildly useful)

f3 = figure; 
lwplot=2;
figure(f3); 
set(gca,'FontSize',36)

subplot(3,1,1)
h(1)=plot(erptimes, mean(data_matrix_3),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
plot(erptimes,zeros(size(erptimes)),':k')
title('3 Months')
%%legend(h,{'Female Other','Female Own','Male Other','Male Own'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([-100 1000])
ylim([-15 25])

subplot(3,1,2)
h(1)=plot(erptimes, mean(data_matrix_6),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
plot(erptimes,zeros(size(erptimes)),':k')
title('6 Months')
%%legend(h,{'Female Other','Female Own','Male Other','Male Own'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([-100 1000])
ylim([-15 25])

subplot(3,1,3)
h(1)=plot(erptimes, mean(data_matrix_9),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
plot(erptimes,zeros(size(erptimes)),':k')
title('9 Months')
%%legend(h,{'Female Other','Female Own','Male Other','Male Own'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([-100 1000])
ylim([-15 25])

return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% AVG WAVEFORM FOR EACH KID, BY AGE


data_matrix_occ_avg_9 = mean(cat(3,data_matrix_foth_OIL_9,data_matrix_fown_OIL_9,data_matrix_moth_OIL_9,data_matrix_mown_OIL_9,...
          data_matrix_foth_OIZ_9, data_matrix_fown_OIZ_9,data_matrix_moth_OIZ_9, data_matrix_mown_OIZ_9,...
          data_matrix_foth_OIR_9, data_matrix_fown_OIR_9, data_matrix_moth_OIR_9, data_matrix_mown_OIR_9),3);

data_matrix_occ_avg_6 = mean(cat(3,data_matrix_foth_OIL_6,data_matrix_fown_OIL_6,data_matrix_moth_OIL_6,data_matrix_mown_OIL_6,...
          data_matrix_foth_OIZ_6, data_matrix_fown_OIZ_6,data_matrix_moth_OIZ_6, data_matrix_mown_OIZ_6,...
          data_matrix_foth_OIR_6, data_matrix_fown_OIR_6, data_matrix_moth_OIR_6, data_matrix_mown_OIR_6),3);

data_matrix_occ_avg_3 = mean(cat(3,data_matrix_foth_OIL_3,data_matrix_fown_OIL_3,data_matrix_moth_OIL_3,data_matrix_mown_OIL_3,...
          data_matrix_foth_OIZ_3, data_matrix_fown_OIZ_3,data_matrix_moth_OIZ_3, data_matrix_mown_OIZ_3,...
          data_matrix_foth_OIR_3, data_matrix_fown_OIR_3, data_matrix_moth_OIR_3, data_matrix_mown_OIR_3),3);


f4 = figure; 
lwplot=2;
figure(f4); 
set(gca,'FontSize',36)

subplot(3,1,1)
plot(erptimes, data_matrix_occ_avg_3,'LineWidth',0.5,'color',[.0 .0 .0]); hold on;
plot(erptimes,zeros(size(erptimes)),':k')
title('3 Months')
%%legend(h,{'Female Other','Female Own','Male Other','Male Own'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off;
xlim([-100 1000])
ylim([-15 25])

subplot(3,1,2)
plot(erptimes, data_matrix_occ_avg_6,'LineWidth',0.5,'color',[.0 .0 .0]);hold on
plot(erptimes,zeros(size(erptimes)),':k')
title('6 Months')
%%legend(h,{'Female Other','Female Own','Male Other','Male Own'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([-100 1000])
ylim([-15 25])

subplot(3,1,3)
plot(erptimes, data_matrix_occ_avg_9,'LineWidth',0.5,'color',[.0 .0 .0]);hold on
plot(erptimes,zeros(size(erptimes)),':k')
title('9 Months')
%%legend(h,{'Female Other','Female Own','Male Other','Male Own'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([-100 1000])
ylim([-15 25])


return

while i <= length(foldernames)
 tic
% disp(i)
 
    if foldernames{i} == ".DS_Store"
        i=i+1;
        continue
    end
 
    cd(fullfile(datapath,foldernames{i}));
    Filename=repmat(foldernames(i),[nrowsOT,1]);
    SubjID=repmat({foldernames{i}((end-2):end)},[nrowsOT,1]);
    age_kid=str2double(foldernames{i}(1));
    Age=repmat(age_kid,[nrowsOT,1]);
    
    foth=load('spycamERP_femother.mat');
    fown=load('spycamERP_femown.mat');
    moth=load('spycamERP_maleother.mat');
    mown=load('spycamERP_maleown.mat');
    
    
    %OT and OI ROIs
%     for j = 1:5
%         P1_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
%             mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
%         P1_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
%             mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
%         P1_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
%             mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
%         P1_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
%             mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
%         
%         if age_kid == 3
%             N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
%                 mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(2).timewindowidx3)));
%             N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
%                 mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(2).timewindowidx3)));
%             N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
%                 mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(2).timewindowidx3)));
%             N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
%                 mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(2).timewindowidx3)));
%             
%             P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
%                 mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(3).timewindowidx3)));
%             P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
%                 mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(3).timewindowidx3)));
%             P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
%                 mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(3).timewindowidx3)));
%             P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
%                 mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(3).timewindowidx3)));
%             
%         elseif age_kid ==6
%              N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
%                 mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(2).timewindowidx6)));
%             N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
%                 mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(2).timewindowidx6)));
%             N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
%                 mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(2).timewindowidx6)));
%             N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
%                 mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(2).timewindowidx6)));
%             
%             P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
%                 mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(3).timewindowidx6)));
%             P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
%                 mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(3).timewindowidx6)));
%             P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
%                 mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(3).timewindowidx6)));
%             P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
%                 mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(3).timewindowidx6)));
%         elseif age_kid == 9
%              N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
%                 mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(2).timewindowidx9)));
%             N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
%                 mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(2).timewindowidx9)));
%             N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
%                 mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(2).timewindowidx9)));
%             N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
%                 mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(2).timewindowidx9)));
%             
%             P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
%                 mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(3).timewindowidx9)));
%             P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
%                 mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(3).timewindowidx9)));
%             P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
%                 mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(3).timewindowidx9)));
%             P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
%                 mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(3).timewindowidx9)));
%         else
%             error('Unknown age found')
%         end
%     
%     end
    
    
    
     %display(data_table(i))
    participant_data_table = table(Filename, SubjID, Age, ROI, Gender, Race, P1_Amp, N290_Amp, P400_Amp);
    if i==2
        data_table = participant_data_table;
    else
        data_table = [data_table; participant_data_table]; %#ok<AGROW>
    end

    %extract waveforms

    if age_kid == 3
       
        data_matrix_foth_OTL_3=[data_matrix_foth_OTL_3;mean(foth.femother(roiparams(1).channelidx,:))];
        data_matrix_fown_OTL_3=[data_matrix_fown_OTL_3;mean(fown.femown(roiparams(1).channelidx,:))];
        data_matrix_moth_OTL_3=[data_matrix_moth_OTL_3;mean(moth.maleother(roiparams(1).channelidx,:))];
        data_matrix_mown_OTL_3=[data_matrix_mown_OTL_3;mean(mown.maleown(roiparams(1).channelidx,:))];

        data_matrix_foth_OIL_3=[data_matrix_foth_OIL_3;mean(foth.femother(roiparams(2).channelidx,:))];
        data_matrix_fown_OIL_3=[data_matrix_fown_OIL_3;mean(fown.femown(roiparams(2).channelidx,:))];
        data_matrix_moth_OIL_3=[data_matrix_moth_OIL_3;mean(moth.maleother(roiparams(2).channelidx,:))];
        data_matrix_mown_OIL_3=[data_matrix_mown_OIL_3;mean(mown.maleown(roiparams(2).channelidx,:))];

        data_matrix_foth_OIZ_3=[data_matrix_foth_OIZ_3;mean(foth.femother(roiparams(3).channelidx,:))];
        data_matrix_fown_OIZ_3=[data_matrix_fown_OIZ_3;mean(fown.femown(roiparams(3).channelidx,:))];
        data_matrix_moth_OIZ_3=[data_matrix_moth_OIZ_3;mean(moth.maleother(roiparams(3).channelidx,:))];
        data_matrix_mown_OIZ_3=[data_matrix_mown_OIZ_3;mean(mown.maleown(roiparams(3).channelidx,:))];

        data_matrix_foth_OIR_3=[data_matrix_foth_OIR_3;mean(foth.femother(roiparams(4).channelidx,:))];
        data_matrix_fown_OIR_3=[data_matrix_fown_OIR_3;mean(fown.femown(roiparams(4).channelidx,:))];
        data_matrix_moth_OIR_3=[data_matrix_moth_OIR_3;mean(moth.maleother(roiparams(4).channelidx,:))];
        data_matrix_mown_OIR_3=[data_matrix_mown_OIR_3;mean(mown.maleown(roiparams(4).channelidx,:))];

        data_matrix_foth_OTR_3=[data_matrix_foth_OTR_3;mean(foth.femother(roiparams(5).channelidx,:))];
        data_matrix_fown_OTR_3=[data_matrix_fown_OTR_3;mean(fown.femown(roiparams(5).channelidx,:))];
        data_matrix_moth_OTR_3=[data_matrix_moth_OTR_3;mean(moth.maleother(roiparams(5).channelidx,:))];
        data_matrix_mown_OTR_3=[data_matrix_mown_OTR_3;mean(mown.maleown(roiparams(5).channelidx,:))];
        
        data_matrix_grand_average_3 = mean(cat(3,data_matrix_foth_OIL_3,data_matrix_fown_OIL_3,data_matrix_moth_OIL_3,data_matrix_mown_OIL_3,...
          data_matrix_foth_OIZ_3, data_matrix_fown_OIZ_3,data_matrix_moth_OIZ_3, data_matrix_mown_OIZ_3,...
          data_matrix_foth_OIR_3, data_matrix_fown_OIR_3, data_matrix_moth_OIR_3, data_matrix_mown_OIR_3,...
          data_matrix_foth_OTL_3, data_matrix_fown_OTL_3,data_matrix_moth_OTL_3,data_matrix_mown_OTL_3,...
          data_matrix_foth_OTR_3, data_matrix_fown_OTR_3, data_matrix_moth_OTR_3, data_matrix_mown_OTR_3),3);

        
    elseif age_kid == 6
        
        data_matrix_foth_OTL_6=[data_matrix_foth_OTL_6;mean(foth.femother(roiparams(1).channelidx,:))];
        data_matrix_fown_OTL_6=[data_matrix_fown_OTL_6;mean(fown.femown(roiparams(1).channelidx,:))];
        data_matrix_moth_OTL_6=[data_matrix_moth_OTL_6;mean(moth.maleother(roiparams(1).channelidx,:))];
        data_matrix_mown_OTL_6=[data_matrix_mown_OTL_6;mean(mown.maleown(roiparams(1).channelidx,:))];

        data_matrix_foth_OIL_6=[data_matrix_foth_OIL_6;mean(foth.femother(roiparams(2).channelidx,:))];
        data_matrix_fown_OIL_6=[data_matrix_fown_OIL_6;mean(fown.femown(roiparams(2).channelidx,:))];
        data_matrix_moth_OIL_6=[data_matrix_moth_OIL_6;mean(moth.maleother(roiparams(2).channelidx,:))];
        data_matrix_mown_OIL_6=[data_matrix_mown_OIL_6;mean(mown.maleown(roiparams(2).channelidx,:))];

        data_matrix_foth_OIZ_6=[data_matrix_foth_OIZ_6;mean(foth.femother(roiparams(3).channelidx,:))];
        data_matrix_fown_OIZ_6=[data_matrix_fown_OIZ_6;mean(fown.femown(roiparams(3).channelidx,:))];
        data_matrix_moth_OIZ_6=[data_matrix_moth_OIZ_6;mean(moth.maleother(roiparams(3).channelidx,:))];
        data_matrix_mown_OIZ_6=[data_matrix_mown_OIZ_6;mean(mown.maleown(roiparams(3).channelidx,:))];

        data_matrix_foth_OIR_6=[data_matrix_foth_OIR_6;mean(foth.femother(roiparams(4).channelidx,:))];
        data_matrix_fown_OIR_6=[data_matrix_fown_OIR_6;mean(fown.femown(roiparams(4).channelidx,:))];
        data_matrix_moth_OIR_6=[data_matrix_moth_OIR_6;mean(moth.maleother(roiparams(4).channelidx,:))];
        data_matrix_mown_OIR_6=[data_matrix_mown_OIR_6;mean(mown.maleown(roiparams(4).channelidx,:))];

        data_matrix_foth_OTR_6=[data_matrix_foth_OTR_6;mean(foth.femother(roiparams(5).channelidx,:))];
        data_matrix_fown_OTR_6=[data_matrix_fown_OTR_6;mean(fown.femown(roiparams(5).channelidx,:))];
        data_matrix_moth_OTR_6=[data_matrix_moth_OTR_6;mean(moth.maleother(roiparams(5).channelidx,:))];
        data_matrix_mown_OTR_6=[data_matrix_mown_OTR_6;mean(mown.maleown(roiparams(5).channelidx,:))];
    
    elseif age_kid == 9
        
        data_matrix_foth_OTL_9=[data_matrix_foth_OTL_9;mean(foth.femother(roiparams(1).channelidx,:))];
        data_matrix_fown_OTL_9=[data_matrix_fown_OTL_9;mean(fown.femown(roiparams(1).channelidx,:))];
        data_matrix_moth_OTL_9=[data_matrix_moth_OTL_9;mean(moth.maleother(roiparams(1).channelidx,:))];
        data_matrix_mown_OTL_9=[data_matrix_mown_OTL_9;mean(mown.maleown(roiparams(1).channelidx,:))];

               
        data_matrix_foth_OIL_9=[data_matrix_foth_OIL_9;mean(foth.femother(roiparams(2).channelidx,:))];
        data_matrix_fown_OIL_9=[data_matrix_fown_OIL_9;mean(fown.femown(roiparams(2).channelidx,:))];
        data_matrix_moth_OIL_9=[data_matrix_moth_OIL_9;mean(moth.maleother(roiparams(2).channelidx,:))];
        data_matrix_mown_OIL_9=[data_matrix_mown_OIL_9;mean(mown.maleown(roiparams(2).channelidx,:))];

        
        data_matrix_foth_OIZ_9=[data_matrix_foth_OIZ_9;mean(foth.femother(roiparams(3).channelidx,:))];
        data_matrix_fown_OIZ_9=[data_matrix_fown_OIZ_9;mean(fown.femown(roiparams(3).channelidx,:))];
        data_matrix_moth_OIZ_9=[data_matrix_moth_OIZ_9;mean(moth.maleother(roiparams(3).channelidx,:))];
        data_matrix_mown_OIZ_9=[data_matrix_mown_OIZ_9;mean(mown.maleown(roiparams(3).channelidx,:))];

        data_matrix_foth_OIR_9=[data_matrix_foth_OIR_9;mean(foth.femother(roiparams(4).channelidx,:))];
        data_matrix_fown_OIR_9=[data_matrix_fown_OIR_9;mean(fown.femown(roiparams(4).channelidx,:))];
        data_matrix_moth_OIR_9=[data_matrix_moth_OIR_9;mean(moth.maleother(roiparams(4).channelidx,:))];
        data_matrix_mown_OIR_9=[data_matrix_mown_OIR_9;mean(mown.maleown(roiparams(4).channelidx,:))];

        data_matrix_foth_OTR_9=[data_matrix_foth_OTR_9;mean(foth.femother(roiparams(5).channelidx,:))];
        data_matrix_fown_OTR_9=[data_matrix_fown_OTR_9;mean(fown.femown(roiparams(5).channelidx,:))];
        data_matrix_moth_OTR_9=[data_matrix_moth_OTR_9;mean(moth.maleother(roiparams(5).channelidx,:))];
        data_matrix_mown_OTR_9=[data_matrix_mown_OTR_9;mean(mown.maleown(roiparams(5).channelidx,:))];

        
     end
    
     i=i+1; 
     toc           
end

return



for j = 1:5
%         P1_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
%             mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
%         P1_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
%             mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
%         P1_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
%             mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
%         P1_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
%             mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
        
        if age_kid == 3
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                mean(min(foth.femother(roiparams(j).channelidx,erpparamts(2).timewindowidx3)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                min(mean(fown.femown(roiparams(j).channelidx,erpparamts(2).timewindowidx3)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                min(mean(moth.maleother(roiparams(j).channelidx,erpparamts(2).timewindowidx3)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                min(mean(mown.maleown(roiparams(j).channelidx,erpparamts(2).timewindowidx3)));
            
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                max(mean(foth.femother(roiparams(j).channelidx,erpparamts(3).timewindowidx3)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                max(mean(fown.femown(roiparams(j).channelidx,erpparamts(3).timewindowidx3)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                max(mean(moth.maleother(roiparams(j).channelidx,erpparamts(3).timewindowidx3)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                max(mean(mown.maleown(roiparams(j).channelidx,erpparamts(3).timewindowidx3)));
            
        elseif age_kid ==6
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(2).timewindowidx6)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(2).timewindowidx6)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(2).timewindowidx6)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(2).timewindowidx6)));
            
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(3).timewindowidx6)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(3).timewindowidx6)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(3).timewindowidx6)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(3).timewindowidx6)));
        elseif age_kid == 9
             N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(2).timewindowidx9)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(2).timewindowidx9)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(2).timewindowidx9)));
            N290_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(2).timewindowidx9)));
            
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
                mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(3).timewindowidx9)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
                mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(3).timewindowidx9)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
                mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(3).timewindowidx9)));
            P400_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
                mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(3).timewindowidx9)));
        else
            error('Unknown age found')
        end


end
    
    
     %display(data_table(i))
    participant_data_table = table(Filename, SubjID, Age, ROI, Gender, Race, P1_Amp, N290_Amp, P400_Amp);
    if i==2
        data_table = participant_data_table;
    else
        data_table = [data_table; participant_data_table]; %#ok<AGROW>
    end



return

%%%%%%%%%%%%%%%%%%%%%%% LATENCY CODE

% Min N290 3 mo (single participant)
allconds_single_participant= cat(3, mown.maleown, moth.maleother, foth.femother, fown.femown);
[~,min_idx_single_participant]=min(mean(mean(allconds_single_participant(otlr,erpparamts(2).timewindowidx3,:),3),1));
peak_lat_3_N290_single_participant = erptimes(erpparamts(2).timewindowidx3(min_idx_single_participant))

%Min N290 6mo
allconds_single_participant= cat(3, mown.maleown, moth.maleother, foth.femother, fown.femown);
[~,min_idx_single_participant]=min(mean(mean(allconds_single_participant(otlr,erpparamts(2).timewindowidx6,:),3),1));
peak_lat_6_N290_single_participant = erptimes(erpparamts(2).timewindowidx6(min_idx_single_participant))

%Min N290 9mo
allconds_single_participant= cat(3, mown.maleown, moth.maleother, foth.femother, fown.femown);
[~,min_idx_single_participant]=min(mean(mean(allconds_single_participant(otlr,erpparamts(2).timewindowidx9,:),3),1));
peak_lat_9_N290_single_participant = erptimes(erpparamts(2).timewindowidx9(min_idx_single_participant))

%%%%%%%%%%%%%%%%

% Min P400 3 mo (single participant)
allconds_single_participant= cat(3, mown.maleown, moth.maleother, foth.femother, fown.femown);
[~,min_idx_single_participant]=min(mean(mean(allconds_single_participant(otlr,erpparamts(3).timewindowidx3,:),3),1));
peak_lat_3_P400_single_participant = erptimes(erpparamts(3).timewindowidx3(min_idx_single_participant))

%Min P400 6mo
allconds_single_participant= cat(3, mown.maleown, moth.maleother, foth.femother, fown.femown);
[~,min_idx_single_participant]=min(mean(mean(allconds_single_participant(otlr,erpparamts(3).timewindowidx6,:),3),1));
peak_lat_6_P400_single_participant = erptimes(erpparamts(3).timewindowidx6(min_idx_single_participant))

%Min P400 9mo
allconds_single_participant= cat(3, mown.maleown, moth.maleother, foth.femother, fown.femown);
[~,min_idx_single_participant]=min(mean(mean(allconds_single_participant(otlr,erpparamts(3).timewindowidx9,:),3),1));
peak_lat_9_P400_single_participant = erptimes(erpparamts(3).timewindowidx9(min_idx_single_participant))











% [m2,i2]=min(mean(fown.femown(roiparams(2).channelidx,erpparamts(2).timewindowidx3)))
% peak_lat_roi2_3_N290 = erptimes(erpparamts(2).timewindowidx3(i2))
% [m3,i3]=min(mean(fown.femown(roiparams(3).channelidx,erpparamts(2).timewindowidx3)))
% peak_lat_roi3_3_N290 = erptimes(erpparamts(2).timewindowidx3(i3))
% [m4,i4]=min(mean(fown.femown(roiparams(4).channelidx,erpparamts(2).timewindowidx3)))
% peak_lat_roi4_3_N290 = erptimes(erpparamts(2).timewindowidx3(i4))
% [m5,i5]=min(mean(fown.femown(roiparams(5).channelidx,erpparamts(2).timewindowidx3)))
% peak_lat_roi5_3_N290 = erptimes(erpparamts(2).timewindowidx3(i5))
% mean_fown_N290_3 = mean([peak_lat_roi1_3_N290,peak_lat_roi2_3_N290,peak_lat_roi3_3_N290,peak_lat_roi4_3_N290,peak_lat_roi5_3_N290])

% Min N290 foth 3 mo
[m1,i1]=min(min(foth.femother(roiparams(1).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi1_3_N290 = erptimes(erpparamts(2).timewindowidx3(i1))
[m2,i2]=min(min(foth.femother(roiparams(2).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi2_3_N290 = erptimes(erpparamts(2).timewindowidx3(i2))
[m3,i3]=min(min(foth.femother(roiparams(3).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi3_3_N290 = erptimes(erpparamts(2).timewindowidx3(i3))
[m4,i4]=min(min(foth.femother(roiparams(4).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi4_3_N290 = erptimes(erpparamts(2).timewindowidx3(i4))
[m5,i5]=min(min(foth.femother(roiparams(5).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi5_3_N290 = erptimes(erpparamts(2).timewindowidx3(i5))

mean_foth_N290_3 = mean([peak_lat_roi1_3_N290,peak_lat_roi2_3_N290,peak_lat_roi3_3_N290,peak_lat_roi4_3_N290,peak_lat_roi5_3_N290])

% Min N290 mown 3 mo
[m1,i1]=min(min(mown.maleown(roiparams(1).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi1_3_N290 = erptimes(erpparamts(2).timewindowidx3(i1))
[m2,i2]=min(min(mown.maleown(roiparams(2).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi2_3_N290 = erptimes(erpparamts(2).timewindowidx3(i2))
[m3,i3]=min(min(mown.maleown(roiparams(3).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi3_3_N290 = erptimes(erpparamts(2).timewindowidx3(i3))
[m4,i4]=min(min(mown.maleown(roiparams(4).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi4_3_N290 = erptimes(erpparamts(2).timewindowidx3(i4))
[m5,i5]=min(min(mown.maleown(roiparams(5).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi5_3_N290 = erptimes(erpparamts(2).timewindowidx3(i5))

mean_mown_N290_3 = mean([peak_lat_roi1_3_N290,peak_lat_roi2_3_N290,peak_lat_roi3_3_N290,peak_lat_roi4_3_N290,peak_lat_roi5_3_N290])

% Min N290 moth 3 mo
[m1,i1]=min(min(moth.maleother(roiparams(1).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi1_3_N290 = erptimes(erpparamts(2).timewindowidx3(i1))
[m2,i2]=min(min(moth.maleother(roiparams(2).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi2_3_N290 = erptimes(erpparamts(2).timewindowidx3(i2))
[m3,i3]=min(min(moth.maleother(roiparams(3).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi3_3_N290 = erptimes(erpparamts(2).timewindowidx3(i3))
[m4,i4]=min(min(moth.maleother(roiparams(4).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi4_3_N290 = erptimes(erpparamts(2).timewindowidx3(i4))
[m5,i5]=min(min(moth.maleother(roiparams(5).channelidx,erpparamts(2).timewindowidx3)))
peak_lat_roi5_3_N290 = erptimes(erpparamts(2).timewindowidx3(i5))

mean_moth_N290_3 = mean([peak_lat_roi1_3_N290,peak_lat_roi2_3_N290,peak_lat_roi3_3_N290,peak_lat_roi4_3_N290,peak_lat_roi5_3_N290])

% Min N290 3 mo

mean_N290_lat_3mo = mean([mean_foth_N290_3,mean_fown_N290_3,mean_moth_N290_3,mean_mown_N290_3])


%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Min N290 fown 6 mo
[m1,i1]=min(min(fown.femown(roiparams(1).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi1_6_N290 = erptimes(erpparamts(2).timewindowidx6(i1))
[m2,i2]=min(min(fown.femown(roiparams(2).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi2_6_N290 = erptimes(erpparamts(2).timewindowidx6(i2))
[m3,i3]=min(min(fown.femown(roiparams(3).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi3_6_N290 = erptimes(erpparamts(2).timewindowidx6(i3))
[m4,i4]=min(min(fown.femown(roiparams(4).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi4_6_N290 = erptimes(erpparamts(2).timewindowidx6(i4))
[m5,i5]=min(min(fown.femown(roiparams(5).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi5_6_N290 = erptimes(erpparamts(2).timewindowidx6(i5))

mean_fown_N290_6 = mean([peak_lat_roi1_6_N290,peak_lat_roi2_6_N290,peak_lat_roi3_6_N290,peak_lat_roi4_6_N290,peak_lat_roi5_6_N290])

% Min N290 foth 6 mo
[m1,i1]=min(min(foth.femother(roiparams(1).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi1_6_N290 = erptimes(erpparamts(2).timewindowidx6(i1))
[m2,i2]=min(min(foth.femother(roiparams(2).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi2_6_N290 = erptimes(erpparamts(2).timewindowidx6(i2))
[m3,i3]=min(min(foth.femother(roiparams(3).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi3_6_N290 = erptimes(erpparamts(2).timewindowidx6(i3))
[m4,i4]=min(min(foth.femother(roiparams(4).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi4_6_N290 = erptimes(erpparamts(2).timewindowidx6(i4))
[m5,i5]=min(min(foth.femother(roiparams(5).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi5_6_N290 = erptimes(erpparamts(2).timewindowidx6(i5))

mean_foth_N290_6 = mean([peak_lat_roi1_6_N290,peak_lat_roi2_6_N290,peak_lat_roi3_6_N290,peak_lat_roi4_6_N290,peak_lat_roi5_6_N290])

% Min N290 mown 6 mo
[m1,i1]=min(min(mown.maleown(roiparams(1).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi1_6_N290 = erptimes(erpparamts(2).timewindowidx6(i1))
[m2,i2]=min(min(mown.maleown(roiparams(2).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi2_6_N290 = erptimes(erpparamts(2).timewindowidx6(i2))
[m3,i3]=min(min(mown.maleown(roiparams(3).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi3_6_N290 = erptimes(erpparamts(2).timewindowidx6(i3))
[m4,i4]=min(min(mown.maleown(roiparams(4).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi4_6_N290 = erptimes(erpparamts(2).timewindowidx6(i4))
[m5,i5]=min(min(mown.maleown(roiparams(5).channelidx,erpparamts(2).timewindowidx6)))
peak_lat_roi5_6_N290 = erptimes(erpparamts(2).timewindowidx6(i5))

mean_mown_N290_6 = mean([peak_lat_roi1_6_N290,peak_lat_roi2_6_N290,peak_lat_roi3_6_N290,peak_lat_roi4_6_N290,peak_lat_roi5_6_N290])

% Min N290 moth 6 mo
[m1,i1]=min(mean(moth.maleother(otlr,erpparamts(2).timewindowidx6)))
peak_lat_moth_6_N290 = erptimes(erpparamts(2).timewindowidx6(i1))

mean_moth_N290_6 = mean([peak_lat_moth_6_N290])

% Min N290 6 mo

mean_N290_lat_6mo = mean([mean_foth_N290_6,mean_fown_N290_6,mean_moth_N290_6,mean_mown_N290_6])

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Min N290 fown 9 mo
[m1,i1]=min(mean(fown.femown(otlr,erpparamts(2).timewindowidx9)))
peak_lat_fown_9_N290 = erptimes(erpparamts(2).timewindowidx9(i1))
% [m2,i2]=min(min(fown.femown(roiparams(2).channelidx,erpparamts(2).timewindowidx9)))
% peak_lat_roi2_9_N290 = erptimes(erpparamts(2).timewindowidx3(i2))
% [m3,i3]=min(min(fown.femown(roiparams(3).channelidx,erpparamts(2).timewindowidx9)))
% peak_lat_roi3_9_N290 = erptimes(erpparamts(2).timewindowidx3(i3))
% [m4,i4]=min(min(fown.femown(roiparams(4).channelidx,erpparamts(2).timewindowidx9)))
% peak_lat_roi4_9_N290 = erptimes(erpparamts(2).timewindowidx3(i4))
% [m5,i5]=min(min(fown.femown(roiparams(5).channelidx,erpparamts(2).timewindowidx9)))
% peak_lat_roi5_9_N290 = erptimes(erpparamts(2).timewindowidx9(i5))

mean_fown_N290_9 = mean([peak_lat_roi1_9_N290,peak_lat_roi2_9_N290,peak_lat_roi3_9_N290,peak_lat_roi4_9_N290,peak_lat_roi5_9_N290])

% Min N290 foth 9 mo
[m1,i1]=min(min(foth.femother(roiparams(1).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi1_9_N290 = erptimes(erpparamts(2).timewindowidx9(i1))
[m2,i2]=min(min(foth.femother(roiparams(2).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi2_9_N290 = erptimes(erpparamts(2).timewindowidx9(i2))
[m3,i3]=min(min(foth.femother(roiparams(3).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi3_9_N290 = erptimes(erpparamts(2).timewindowidx9(i3))
[m4,i4]=min(min(foth.femother(roiparams(4).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi4_9_N290 = erptimes(erpparamts(2).timewindowidx9(i4))
[m5,i5]=min(min(foth.femother(roiparams(5).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi5_9_N290 = erptimes(erpparamts(2).timewindowidx9(i5))

mean_foth_N290_9 = mean([peak_lat_roi1_9_N290,peak_lat_roi2_9_N290,peak_lat_roi3_9_N290,peak_lat_roi4_9_N290,peak_lat_roi5_9_N290])

% Min N290 mown 9 mo
[m1,i1]=min(min(mown.maleown(roiparams(1).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi1_9_N290 = erptimes(erpparamts(2).timewindowidx9(i1))
[m2,i2]=min(min(mown.maleown(roiparams(2).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi2_9_N290 = erptimes(erpparamts(2).timewindowidx9(i2))
[m3,i3]=min(min(mown.maleown(roiparams(3).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi3_9_N290 = erptimes(erpparamts(2).timewindowidx9(i3))
[m4,i4]=min(min(mown.maleown(roiparams(4).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi4_9_N290 = erptimes(erpparamts(2).timewindowidx9(i4))
[m5,i5]=min(min(mown.maleown(roiparams(5).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi5_9_N290 = erptimes(erpparamts(2).timewindowidx9(i5))

mean_mown_N290_9 = mean([peak_lat_roi1_9_N290,peak_lat_roi2_9_N290,peak_lat_roi3_9_N290,peak_lat_roi4_9_N290,peak_lat_roi5_9_N290])

% Min N290 moth 9 mo
[m1,i1]=min(min(moth.maleother(roiparams(1).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi1_9_N290 = erptimes(erpparamts(2).timewindowidx9(i1))
[m2,i2]=min(min(moth.maleother(roiparams(2).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi2_9_N290 = erptimes(erpparamts(2).timewindowidx9(i2))
[m3,i3]=min(min(moth.maleother(roiparams(3).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi3_9_N290 = erptimes(erpparamts(2).timewindowidx9(i3))
[m4,i4]=min(min(moth.maleother(roiparams(4).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi4_9_N290 = erptimes(erpparamts(2).timewindowidx9(i4))
[m5,i5]=min(min(moth.maleother(roiparams(5).channelidx,erpparamts(2).timewindowidx9)))
peak_lat_roi5_9_N290 = erptimes(erpparamts(2).timewindowidx9(i5))

mean_moth_N290_9 = mean([peak_lat_roi1_9_N290,peak_lat_roi2_9_N290,peak_lat_roi3_9_N290,peak_lat_roi4_9_N290,peak_lat_roi5_9_N290])

% Min N290 9 mo

mean_N290_lat_9mo = mean([mean_foth_N290_9,mean_fown_N290_9,mean_moth_N290_9,mean_mown_N290_9])


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Max P400 fown 3 mo
[m1,i1]=max(max(fown.femown(roiparams(1).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi1_3_P400 = erptimes(erpparamts(3).timewindowidx3(i1))
[m2,i2]=max(max(fown.femown(roiparams(2).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi2_3_P400 = erptimes(erpparamts(3).timewindowidx3(i2))
[m3,i3]=max(max(fown.femown(roiparams(3).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi3_3_P400 = erptimes(erpparamts(3).timewindowidx3(i3))
[m4,i4]=max(max(fown.femown(roiparams(4).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi4_3_P400 = erptimes(erpparamts(3).timewindowidx3(i4))
[m5,i5]=max(max(fown.femown(roiparams(5).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi5_3_P400 = erptimes(erpparamts(3).timewindowidx3(i5))

mean_fown_P400_3 = mean([peak_lat_roi1_3_P400,peak_lat_roi2_3_P400,peak_lat_roi3_3_P400,peak_lat_roi4_3_P400,peak_lat_roi5_3_P400])

% Max P400 foth 3 mo
[m1,i1]=max(max(foth.femother(roiparams(1).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi1_3_P400 = erptimes(erpparamts(3).timewindowidx3(i1))
[m2,i2]=max(max(foth.femother(roiparams(2).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi2_3_P400 = erptimes(erpparamts(3).timewindowidx3(i2))
[m3,i3]=max(max(foth.femother(roiparams(3).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi3_3_P400 = erptimes(erpparamts(3).timewindowidx3(i3))
[m4,i4]=max(max(foth.femother(roiparams(4).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi4_3_P400 = erptimes(erpparamts(3).timewindowidx3(i4))
[m5,i5]=max(max(foth.femother(roiparams(5).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi5_3_P400 = erptimes(erpparamts(3).timewindowidx3(i5))

mean_foth_P400_3 = mean([peak_lat_roi1_3_P400,peak_lat_roi2_3_P400,peak_lat_roi3_3_P400,peak_lat_roi4_3_P400,peak_lat_roi5_3_P400])

% Max P400 mown 3 mo
[m1,i1]=max(max(mown.maleown(roiparams(1).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi1_3_P400 = erptimes(erpparamts(3).timewindowidx3(i1))
[m2,i2]=max(max(mown.maleown(roiparams(2).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi2_3_P400 = erptimes(erpparamts(3).timewindowidx3(i2))
[m3,i3]=max(max(mown.maleown(roiparams(3).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi3_3_P400 = erptimes(erpparamts(3).timewindowidx3(i3))
[m4,i4]=max(max(mown.maleown(roiparams(4).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi4_3_P400 = erptimes(erpparamts(3).timewindowidx3(i4))
[m5,i5]=max(max(mown.maleown(roiparams(5).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi5_3_P400 = erptimes(erpparamts(3).timewindowidx3(i5))

mean_mown_P400_3 = mean([peak_lat_roi1_3_P400,peak_lat_roi2_3_P400,peak_lat_roi3_3_P400,peak_lat_roi4_3_P400,peak_lat_roi5_3_P400])

% Max P400 moth 3 mo
[m1,i1]=max(max(moth.maleother(roiparams(1).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi1_3_P400 = erptimes(erpparamts(3).timewindowidx3(i1))
[m2,i2]=max(max(moth.maleother(roiparams(2).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi2_3_P400 = erptimes(erpparamts(3).timewindowidx3(i2))
[m3,i3]=max(max(moth.maleother(roiparams(3).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi3_3_P400 = erptimes(erpparamts(3).timewindowidx3(i3))
[m4,i4]=max(max(moth.maleother(roiparams(4).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi4_3_P400 = erptimes(erpparamts(3).timewindowidx3(i4))
[m5,i5]=max(max(moth.maleother(roiparams(5).channelidx,erpparamts(3).timewindowidx3)))
peak_lat_roi5_3_P400 = erptimes(erpparamts(3).timewindowidx3(i5))

mean_moth_P400_3 = mean([peak_lat_roi1_3_P400,peak_lat_roi2_3_P400,peak_lat_roi3_3_P400,peak_lat_roi4_3_P400,peak_lat_roi5_3_P400])

% Max P400 3 mo

mean_P400_lat_3mo = mean([mean_foth_P400_3,mean_fown_P400_3,mean_moth_P400_3,mean_mown_P400_3])


%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Max P400 fown 6 mo
[m1,i1]=max(max(fown.femown(roiparams(1).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi1_6_P400 = erptimes(erpparamts(3).timewindowidx6(i1))
[m2,i2]=max(max(fown.femown(roiparams(2).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi2_6_P400 = erptimes(erpparamts(3).timewindowidx6(i2))
[m3,i3]=max(max(fown.femown(roiparams(3).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi3_6_P400 = erptimes(erpparamts(3).timewindowidx6(i3))
[m4,i4]=max(max(fown.femown(roiparams(4).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi4_6_P400 = erptimes(erpparamts(3).timewindowidx6(i4))
[m5,i5]=max(max(fown.femown(roiparams(5).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi5_6_P400 = erptimes(erpparamts(3).timewindowidx6(i5))

mean_fown_P400_6 = mean([peak_lat_roi1_6_P400,peak_lat_roi2_6_P400,peak_lat_roi3_6_P400,peak_lat_roi4_6_P400,peak_lat_roi5_6_P400])

% Max P400 foth 6 mo
[m1,i1]=max(max(foth.femother(roiparams(1).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi1_6_P400 = erptimes(erpparamts(3).timewindowidx6(i1))
[m2,i2]=max(max(foth.femother(roiparams(2).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi2_6_P400 = erptimes(erpparamts(3).timewindowidx6(i2))
[m3,i3]=max(max(foth.femother(roiparams(3).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi3_6_P400 = erptimes(erpparamts(3).timewindowidx6(i3))
[m4,i4]=max(max(foth.femother(roiparams(4).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi4_6_P400 = erptimes(erpparamts(3).timewindowidx6(i4))
[m5,i5]=max(max(foth.femother(roiparams(5).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi5_6_P400 = erptimes(erpparamts(3).timewindowidx6(i5))

mean_foth_P400_6 = mean([peak_lat_roi1_6_P400,peak_lat_roi2_6_P400,peak_lat_roi3_6_P400,peak_lat_roi4_6_P400,peak_lat_roi5_6_P400])

% Max P400 mown 6 mo
[m1,i1]=max(max(mown.maleown(roiparams(1).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi1_6_P400 = erptimes(erpparamts(3).timewindowidx6(i1))
[m2,i2]=max(max(mown.maleown(roiparams(2).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi2_6_P400 = erptimes(erpparamts(3).timewindowidx6(i2))
[m3,i3]=max(max(mown.maleown(roiparams(3).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi3_6_P400 = erptimes(erpparamts(3).timewindowidx6(i3))
[m4,i4]=max(max(mown.maleown(roiparams(4).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi4_6_P400 = erptimes(erpparamts(3).timewindowidx6(i4))
[m5,i5]=max(max(mown.maleown(roiparams(5).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi5_6_P400 = erptimes(erpparamts(3).timewindowidx6(i5))

mean_mown_P400_6 = mean([peak_lat_roi1_6_P400,peak_lat_roi2_6_P400,peak_lat_roi3_6_P400,peak_lat_roi4_6_P400,peak_lat_roi5_6_P400])

% Max P400 moth 6 mo
[m1,i1]=max(max(moth.maleother(roiparams(1).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi1_6_P400 = erptimes(erpparamts(3).timewindowidx6(i1))
[m2,i2]=max(max(moth.maleother(roiparams(3).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi2_6_P400 = erptimes(erpparamts(3).timewindowidx6(i2))
[m3,i3]=max(max(moth.maleother(roiparams(3).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi3_6_P400 = erptimes(erpparamts(3).timewindowidx6(i3))
[m4,i4]=max(max(moth.maleother(roiparams(4).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi4_6_P400 = erptimes(erpparamts(3).timewindowidx6(i4))
[m5,i5]=max(max(moth.maleother(roiparams(5).channelidx,erpparamts(3).timewindowidx6)))
peak_lat_roi5_6_P400 = erptimes(erpparamts(3).timewindowidx6(i5))

mean_moth_P400_6 = mean([peak_lat_roi1_6_P400,peak_lat_roi2_6_P400,peak_lat_roi3_6_P400,peak_lat_roi4_6_P400,peak_lat_roi5_6_P400])

% Max P400 6 mo

mean_P400_lat_6mo = mean([mean_foth_P400_6,mean_fown_P400_6,mean_moth_P400_6,mean_mown_P400_6])

%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Max P400 fown 9 mo
[m1,i1]=max(max(fown.femown(roiparams(1).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi1_9_P400 = erptimes(erpparamts(3).timewindowidx3(i1))
[m2,i2]=max(max(fown.femown(roiparams(2).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi2_9_P400 = erptimes(erpparamts(3).timewindowidx3(i2))
[m3,i3]=max(max(fown.femown(roiparams(3).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi3_9_P400 = erptimes(erpparamts(3).timewindowidx3(i3))
[m4,i4]=max(max(fown.femown(roiparams(4).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi4_9_P400 = erptimes(erpparamts(3).timewindowidx3(i4))
[m5,i5]=max(max(fown.femown(roiparams(5).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi5_9_P400 = erptimes(erpparamts(3).timewindowidx9(i5))

mean_fown_P400_9 = mean([peak_lat_roi1_9_P400,peak_lat_roi2_9_P400,peak_lat_roi3_9_P400,peak_lat_roi4_9_P400,peak_lat_roi5_9_P400])

% Max P400 foth 9 mo
[m1,i1]=max(max(foth.femother(roiparams(1).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi1_9_P400 = erptimes(erpparamts(3).timewindowidx9(i1))
[m2,i2]=max(max(foth.femother(roiparams(2).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi2_9_P400 = erptimes(erpparamts(3).timewindowidx9(i2))
[m3,i3]=max(max(foth.femother(roiparams(3).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi3_9_P400 = erptimes(erpparamts(3).timewindowidx9(i3))
[m4,i4]=max(max(foth.femother(roiparams(4).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi4_9_P400 = erptimes(erpparamts(3).timewindowidx9(i4))
[m5,i5]=max(max(foth.femother(roiparams(5).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi5_9_P400 = erptimes(erpparamts(3).timewindowidx9(i5))

mean_foth_P400_9 = mean([peak_lat_roi1_9_P400,peak_lat_roi2_9_P400,peak_lat_roi3_9_P400,peak_lat_roi4_9_P400,peak_lat_roi5_9_P400])

% Max P400 mown 9 mo
[m1,i1]=max(max(mown.maleown(roiparams(1).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi1_9_P400 = erptimes(erpparamts(3).timewindowidx9(i1))
[m2,i2]=max(max(mown.maleown(roiparams(2).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi2_9_P400 = erptimes(erpparamts(3).timewindowidx9(i2))
[m3,i3]=max(max(mown.maleown(roiparams(3).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi3_9_P400 = erptimes(erpparamts(3).timewindowidx9(i3))
[m4,i4]=max(max(mown.maleown(roiparams(4).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi4_9_P400 = erptimes(erpparamts(3).timewindowidx9(i4))
[m5,i5]=max(max(mown.maleown(roiparams(5).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi5_9_P400 = erptimes(erpparamts(3).timewindowidx9(i5))

mean_mown_P400_9 = mean([peak_lat_roi1_9_P400,peak_lat_roi2_9_P400,peak_lat_roi3_9_P400,peak_lat_roi4_9_P400,peak_lat_roi5_9_P400])

% Max P400 moth 9 mo
[m1,i1]=max(max(moth.maleother(roiparams(1).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi1_9_P400 = erptimes(erpparamts(3).timewindowidx9(i1))
[m2,i2]=max(max(moth.maleother(roiparams(2).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi2_9_P400 = erptimes(erpparamts(3).timewindowidx9(i2))
[m3,i3]=max(max(moth.maleother(roiparams(3).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi3_9_P400 = erptimes(erpparamts(3).timewindowidx9(i3))
[m4,i4]=max(max(moth.maleother(roiparams(4).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi4_9_P400 = erptimes(erpparamts(3).timewindowidx9(i4))
[m5,i5]=max(max(moth.maleother(roiparams(5).channelidx,erpparamts(3).timewindowidx9)))
peak_lat_roi5_9_P400 = erptimes(erpparamts(3).timewindowidx9(i5))

mean_moth_P400_9 = mean([peak_lat_roi1_9_P400,peak_lat_roi2_9_P400,peak_lat_roi3_9_P400,peak_lat_roi4_9_P400,peak_lat_roi5_9_P400])

% Max N290 9 mo

mean_P400_lat_9mo = mean([mean_foth_P400_9,mean_fown_P400_9,mean_moth_P400_9,mean_mown_P400_9])



