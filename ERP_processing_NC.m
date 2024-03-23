
nrowsNc=16;  %4*4 ROIs Nc

%datapath='Z:\Projects\Moulson Collaboration\Subjects';
%chanlocs=load('Z:\Projects\Moulson Collaboration\code\chanlocs_hcgsn129.mat');

datapath='..\..\Subjects';
chanlocs=load('..\chanlocs_hcgsn129.mat');

Filename=repmat({'NA'},[nrowsNc,1]);
SubjID=repmat({'NA'},[nrowsNc,1]);
Age= NaN(nrowsNc,1);
Gender=[repmat({'Female'},[8,1]);repmat({'Male'},[8,1])];
Race=[repmat({'Other'},[4,1]);repmat({'Own'},[4,1]);repmat({'Other'},[4,1]);repmat({'Own'},[4,1])];
ROI = repmat([{'FZ'};{'CZ'};{'CL'};{'CR'};],[4,1]);
Nc_Amp = NaN(nrowsNc,1);

erptimes = [-100:2:998];

erpparamts(1).name='Nc';
erpparamts(1).timewindow = [350 750];
erpparamts(1).timewindowidx = find((erptimes >= erpparamts(1).timewindow(1))&(erptimes <= erpparamts(1).timewindow(2)));

%roi parameters
roiparams(1).label='FZ';
roiparams(1).channellabs={'E18','E16','E10','E12','E5','E11'};
roiparams(1).channelidx=find(ismember({chanlocs.chanlocs.labels},roiparams(1).channellabs));

roiparams(2).label='CZ';
roiparams(2).channellabs={'E7','E31','E80','E55','E106','CZ'};
roiparams(2).channelidx=find(ismember({chanlocs.chanlocs.labels},roiparams(2).channellabs));

roiparams(3).label='CL';
roiparams(3).channellabs={'E36','E37','E30','E41','E42'};
roiparams(3).channelidx=find(ismember({chanlocs.chanlocs.labels},roiparams(3).channellabs));

roiparams(4).label='CR';
roiparams(4).channellabs={'E105','E87','E93','E103','E104'};
roiparams(4).channelidx=find(ismember({chanlocs.chanlocs.labels},roiparams(4).channellabs));



subjects = dir(datapath);
foldernames={subjects(:).name};
foldernames=foldernames(~ismember(foldernames,{'.','..'}));%remove the first two "fake" folders

data_matrix_foth_FZ_3=[];
data_matrix_fown_FZ_3=[];
data_matrix_moth_FZ_3=[];
data_matrix_mown_FZ_3=[];

data_matrix_foth_CZ_3=[];
data_matrix_fown_CZ_3=[];
data_matrix_moth_CZ_3=[];
data_matrix_mown_CZ_3=[];

data_matrix_foth_CL_3=[];
data_matrix_fown_CL_3=[];
data_matrix_moth_CL_3=[];
data_matrix_mown_CL_3=[];

data_matrix_foth_CR_3=[];
data_matrix_fown_CR_3=[];
data_matrix_moth_CR_3=[];
data_matrix_mown_CR_3=[];

data_matrix_foth_FZ_6=[];
data_matrix_fown_FZ_6=[];
data_matrix_moth_FZ_6=[];
data_matrix_mown_FZ_6=[];

data_matrix_foth_CZ_6=[];
data_matrix_fown_CZ_6=[];
data_matrix_moth_CZ_6=[];
data_matrix_mown_CZ_6=[];

data_matrix_foth_CL_6=[];
data_matrix_fown_CL_6=[];
data_matrix_moth_CL_6=[];
data_matrix_mown_CL_6=[];

data_matrix_foth_CR_6=[];
data_matrix_fown_CR_6=[];
data_matrix_moth_CR_6=[];
data_matrix_mown_CR_6=[];

data_matrix_foth_FZ_9=[];
data_matrix_fown_FZ_9=[];
data_matrix_moth_FZ_9=[];
data_matrix_mown_FZ_9=[];

data_matrix_foth_CZ_9=[];
data_matrix_fown_CZ_9=[];
data_matrix_moth_CZ_9=[];
data_matrix_mown_CZ_9=[];

data_matrix_foth_CL_9=[];
data_matrix_fown_CL_9=[];
data_matrix_moth_CL_9=[];
data_matrix_mown_CL_9=[];

data_matrix_foth_CR_9=[];
data_matrix_fown_CR_9=[];
data_matrix_moth_CR_9=[];
data_matrix_mown_CR_9=[];

lat_data_table = [];
nc_lat_data_table_by_cond=[];

FZ = roiparams(1).channelidx;
CZ = roiparams(2).channelidx;
CL = roiparams(3).channelidx;
CR = roiparams(4).channelidx;

roiall = [FZ CZ CL CR];

i=1;

count = 1;

while i <= length(foldernames)

% disp(i)
 
    if foldernames{i} == ".DS_Store"
        i=i+1;
        continue
    end
 
    cd(fullfile(datapath,foldernames{i}));
    Filename=repmat(foldernames(i),[nrowsNc,1]);
    SubjID=repmat({foldernames{i}((end-2):end)},[nrowsNc,1]);
    age_kid=str2double(foldernames{i}(1));
    Age=repmat(age_kid,[nrowsNc,1]);
    
    foth=load('spycamERP_femother.mat');
    fown=load('spycamERP_femown.mat');
    moth=load('spycamERP_maleother.mat');
    mown=load('spycamERP_maleown.mat');

    for j= 1:4
        Nc_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Other')) = ...
            mean(mean(foth.femother(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
        Nc_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Female')&strcmp(Race,'Own')) = ...
            mean(mean(fown.femown(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
        Nc_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Other')) = ...
            mean(mean(moth.maleother(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
        Nc_Amp(strcmp(ROI,roiparams(j).label)&strcmp(Gender,'Male')&strcmp(Race,'Own')) = ...
            mean(mean(mown.maleown(roiparams(j).channelidx,erpparamts(1).timewindowidx)));
    
    participant_data_table = table(Filename, SubjID, Age, ROI, Gender, Race, Nc_Amp );
    if i==2
        data_table = participant_data_table;
    else
        data_table = [data_table; participant_data_table]; %#ok<AGROW>

    end

    if age_kid==3
        data_matrix_foth_FZ_3=[data_matrix_foth_FZ_3;mean(foth.femother(roiparams(1).channelidx,:))];
        data_matrix_fown_FZ_3=[data_matrix_fown_FZ_3;mean(fown.femown(roiparams(1).channelidx,:))];
        data_matrix_moth_FZ_3=[data_matrix_moth_FZ_3;mean(moth.maleother(roiparams(1).channelidx,:))];
        data_matrix_mown_FZ_3=[data_matrix_mown_FZ_3;mean(mown.maleown(roiparams(1).channelidx,:))];

        data_matrix_foth_CZ_3=[data_matrix_foth_CZ_3;mean(foth.femother(roiparams(2).channelidx,:))];
        data_matrix_fown_CZ_3=[data_matrix_fown_CZ_3;mean(fown.femown(roiparams(2).channelidx,:))];
        data_matrix_moth_CZ_3=[data_matrix_moth_CZ_3;mean(moth.maleother(roiparams(2).channelidx,:))];
        data_matrix_mown_CZ_3=[data_matrix_mown_CZ_3;mean(mown.maleown(roiparams(2).channelidx,:))];

        data_matrix_foth_CL_3=[data_matrix_foth_CL_3;mean(foth.femother(roiparams(3).channelidx,:))];
        data_matrix_fown_CL_3=[data_matrix_fown_CL_3;mean(fown.femown(roiparams(3).channelidx,:))];
        data_matrix_moth_CL_3=[data_matrix_moth_CL_3;mean(moth.maleother(roiparams(3).channelidx,:))];
        data_matrix_mown_CL_3=[data_matrix_mown_CL_3;mean(mown.maleown(roiparams(3).channelidx,:))];

        data_matrix_foth_CR_3=[data_matrix_foth_CR_3;mean(foth.femother(roiparams(4).channelidx,:))];
        data_matrix_fown_CR_3=[data_matrix_fown_CR_3;mean(fown.femown(roiparams(4).channelidx,:))];
        data_matrix_moth_CR_3=[data_matrix_moth_CR_3;mean(moth.maleother(roiparams(4).channelidx,:))];
        data_matrix_mown_CR_3=[data_matrix_mown_CR_3;mean(mown.maleown(roiparams(4).channelidx,:))];

        
        elseif age_kid == 6
        data_matrix_foth_FZ_6=[data_matrix_foth_FZ_6;mean(foth.femother(roiparams(1).channelidx,:))];
        data_matrix_fown_FZ_6=[data_matrix_fown_FZ_6;mean(fown.femown(roiparams(1).channelidx,:))];
        data_matrix_moth_FZ_6=[data_matrix_moth_FZ_6;mean(moth.maleother(roiparams(1).channelidx,:))];
        data_matrix_mown_FZ_6=[data_matrix_mown_FZ_6;mean(mown.maleown(roiparams(1).channelidx,:))];

        data_matrix_foth_CZ_6=[data_matrix_foth_CZ_6;mean(foth.femother(roiparams(2).channelidx,:))];
        data_matrix_fown_CZ_6=[data_matrix_fown_CZ_6;mean(fown.femown(roiparams(2).channelidx,:))];
        data_matrix_moth_CZ_6=[data_matrix_moth_CZ_6;mean(moth.maleother(roiparams(2).channelidx,:))];
        data_matrix_mown_CZ_6=[data_matrix_mown_CZ_6;mean(mown.maleown(roiparams(2).channelidx,:))];

        data_matrix_foth_CL_6=[data_matrix_foth_CL_6;mean(foth.femother(roiparams(3).channelidx,:))];
        data_matrix_fown_CL_6=[data_matrix_fown_CL_6;mean(fown.femown(roiparams(3).channelidx,:))];
        data_matrix_moth_CL_6=[data_matrix_moth_CL_6;mean(moth.maleother(roiparams(3).channelidx,:))];
        data_matrix_mown_CL_6=[data_matrix_mown_CL_6;mean(mown.maleown(roiparams(3).channelidx,:))];

        data_matrix_foth_CR_6=[data_matrix_foth_CR_6;mean(foth.femother(roiparams(4).channelidx,:))];
        data_matrix_fown_CR_6=[data_matrix_fown_CR_6;mean(fown.femown(roiparams(4).channelidx,:))];
        data_matrix_moth_CR_6=[data_matrix_moth_CR_6;mean(moth.maleother(roiparams(4).channelidx,:))];
        data_matrix_mown_CR_6=[data_matrix_mown_CR_6;mean(mown.maleown(roiparams(4).channelidx,:))];

        elseif age_kid == 9
        data_matrix_foth_FZ_9=[data_matrix_foth_FZ_9;mean(foth.femother(roiparams(1).channelidx,:))];
        data_matrix_fown_FZ_9=[data_matrix_fown_FZ_9;mean(fown.femown(roiparams(1).channelidx,:))];
        data_matrix_moth_FZ_9=[data_matrix_moth_FZ_9;mean(moth.maleother(roiparams(1).channelidx,:))];
        data_matrix_mown_FZ_9=[data_matrix_mown_FZ_9;mean(mown.maleown(roiparams(1).channelidx,:))];

        data_matrix_foth_CZ_9=[data_matrix_foth_CZ_9;mean(foth.femother(roiparams(2).channelidx,:))];
        data_matrix_fown_CZ_9=[data_matrix_fown_CZ_9;mean(fown.femown(roiparams(2).channelidx,:))];
        data_matrix_moth_CZ_9=[data_matrix_moth_CZ_9;mean(moth.maleother(roiparams(2).channelidx,:))];
        data_matrix_mown_CZ_9=[data_matrix_mown_CZ_9;mean(mown.maleown(roiparams(2).channelidx,:))];

        data_matrix_foth_CL_9=[data_matrix_foth_CL_9;mean(foth.femother(roiparams(3).channelidx,:))];
        data_matrix_fown_CL_9=[data_matrix_fown_CL_9;mean(fown.femown(roiparams(3).channelidx,:))];
        data_matrix_moth_CL_9=[data_matrix_moth_CL_9;mean(moth.maleother(roiparams(3).channelidx,:))];
        data_matrix_mown_CL_9=[data_matrix_mown_CL_9;mean(mown.maleown(roiparams(3).channelidx,:))];

        data_matrix_foth_CR_9=[data_matrix_foth_CR_9;mean(foth.femother(roiparams(4).channelidx,:))];
        data_matrix_fown_CR_9=[data_matrix_fown_CR_9;mean(fown.femown(roiparams(4).channelidx,:))];
        data_matrix_moth_CR_9=[data_matrix_moth_CR_9;mean(moth.maleother(roiparams(4).channelidx,:))];
        data_matrix_mown_CR_9=[data_matrix_mown_CR_9;mean(mown.maleown(roiparams(4).channelidx,:))];
    end 
    
    end
    
    
    Nc_timewindow = erpparamts(1).timewindowidx;
    
    %%%%%%%%%%%%%% Peak latency calculations
    % Min Nc (single participant)
    allconds_single_participant= cat(3, mown.maleown, moth.maleother, foth.femother, fown.femown);
    
    [~,min_nc_single_participant]=min(mean(mean(allconds_single_participant(roiall,Nc_timewindow,:),3),1));
    peak_lat_Nc_single_participant = erptimes(Nc_timewindow(min_nc_single_participant));
    
    
    latency_data_table = table(age_kid,  peak_lat_Nc_single_participant);
    lat_data_table = [lat_data_table; latency_data_table]; %#ok<AGROW>
    
    
    %%%%%%%%%% lat by condition
    femown_single_participant= fown.femown;
    femother_single_participant= foth.femother;
    maleown_single_participant= mown.maleown;
    maleother_single_participant= moth.maleother;
    
    %%% femown
    
    [~,min_nc_single_participant]=min(mean(mean(femown_single_participant(roiall,Nc_timewindow,:),3),1));
    peak_lat_Nc_single_participant_femown = erptimes(Nc_timewindow(min_nc_single_participant));
    
    
    %%% femother
    
    [~,min_nc_single_participant]=min(mean(mean(femother_single_participant(roiall,Nc_timewindow,:),3),1));
    peak_lat_Nc_single_participant_femother = erptimes(Nc_timewindow(min_nc_single_participant));
    
    
    %%% maleown
    
    [~,min_nc_single_participant]=min(mean(mean(maleown_single_participant(roiall,Nc_timewindow,:),3),1));
    peak_lat_Nc_single_participant_maleown = erptimes(Nc_timewindow(min_nc_single_participant));
    
    %%% maleother
    
    [~,min_nc_single_participant]=min(mean(mean(maleother_single_participant(roiall,Nc_timewindow,:),3),1));
    peak_lat_Nc_single_participant_maleother = erptimes(Nc_timewindow(min_nc_single_participant));
    
    
    latency_data_table_by_cond = table(age_kid, peak_lat_Nc_single_participant_femown, peak_lat_Nc_single_participant_femother, peak_lat_Nc_single_participant_maleown,  peak_lat_Nc_single_participant_maleother);
    nc_lat_data_table_by_cond = [nc_lat_data_table_by_cond; latency_data_table_by_cond]; %#ok<AGROW>
    

    i=i+1;
    
    
end

%save('lat_data_table.mat','lat_data_table')
save('Nc_lat_data_table_by_cond.mat','lat_data_table_by_cond')

return


% Condition x roi x age line plots


f1 = figure; 
lwplot=1;
figure(f1); 
set(gca,'FontSize',36)

subplot(3,4,1)
h(1)=plot(erptimes, mean(data_matrix_foth_FZ_3),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_FZ_3),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_FZ_3),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(3)=plot(erptimes, mean(data_matrix_mown_FZ_3),'LineWidth',lwplot,'color',[.8 .6 .7]);

plot(erptimes,zeros(size(erptimes)),':k')
title('Fz 3 Months')
%legend({'Female Other Race','Female Own Race','Male Own Race'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([0 1000])
ylim([-15 25])


subplot(3,4,2)
h(1)=plot(erptimes, mean(data_matrix_foth_CZ_3),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_CZ_3),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_CZ_3),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(3)=plot(erptimes, mean(data_matrix_mown_CZ_3),'LineWidth',lwplot,'color',[.8 .6 .7]);

plot(erptimes,zeros(size(erptimes)),':k')
title('Cz 3 Months')
%legend({'Female Other Race','Female Own Race','Male Own Race'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([0 1000])
ylim([-15 25])


subplot(3,4,3)
h(1)=plot(erptimes, mean(data_matrix_foth_CL_3),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_CL_3),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_CL_3),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(3)=plot(erptimes, mean(data_matrix_mown_CL_3),'LineWidth',lwplot,'color',[.8 .6 .7]);

plot(erptimes,zeros(size(erptimes)),':k')
title('CL 3 Months')
%legend({'Female Other Race','Female Own Race','Male Own Race'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([0 1000])
ylim([-15 25])


subplot(3,4,4)
h(1)=plot(erptimes, mean(data_matrix_foth_CR_3),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_CR_3),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_CR_3),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(3)=plot(erptimes, mean(data_matrix_mown_CR_3),'LineWidth',lwplot,'color',[.8 .6 .7]);

plot(erptimes,zeros(size(erptimes)),':k')
title('CR 3 Months')
%legend({'Female Other Race','Female Own Race','Male Own Race'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([0 1000])
ylim([-15 25])


subplot(3,4,5)
h(1)=plot(erptimes, mean(data_matrix_foth_FZ_6),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_FZ_6),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_FZ_6),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(3)=plot(erptimes, mean(data_matrix_mown_FZ_6),'LineWidth',lwplot,'color',[.8 .6 .7]);

plot(erptimes,zeros(size(erptimes)),':k')
title('Fz 6 Months')
%legend({'Female Other Race','Female Own Race','Male Own Race'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([0 1000])
ylim([-15 25])


subplot(3,4,6)
h(1)=plot(erptimes, mean(data_matrix_foth_CZ_6),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_CZ_6),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_CZ_6),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(3)=plot(erptimes, mean(data_matrix_mown_CZ_6),'LineWidth',lwplot,'color',[.8 .6 .7]);

plot(erptimes,zeros(size(erptimes)),':k')
title('Cz 6 Months')
%legend({'Female Other Race','Female Own Race','Male Own Race'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([0 1000])
ylim([-15 25])


subplot(3,4,7)
h(1)=plot(erptimes, mean(data_matrix_foth_CL_6),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_CL_6),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_CL_6),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(3)=plot(erptimes, mean(data_matrix_mown_CL_6),'LineWidth',lwplot,'color',[.8 .6 .7]);

plot(erptimes,zeros(size(erptimes)),':k')
title('CL 6 Months')
%legend({'Female Other Race','Female Own Race','Male Own Race'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([0 1000])
ylim([-15 25])


subplot(3,4,8)
h(1)=plot(erptimes, mean(data_matrix_foth_CR_6),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_CR_6),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_CR_6),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(3)=plot(erptimes, mean(data_matrix_mown_CR_6),'LineWidth',lwplot,'color',[.8 .6 .7]);

plot(erptimes,zeros(size(erptimes)),':k')
title('CR 6 Months')
%legend({'Female Other Race','Female Own Race','Male Own Race'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([0 1000])
ylim([-15 25])






subplot(3,4,9)
h(1)=plot(erptimes, mean(data_matrix_foth_FZ_9),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_FZ_9),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_FZ_9),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(3)=plot(erptimes, mean(data_matrix_mown_FZ_9),'LineWidth',lwplot,'color',[.8 .6 .7]);

plot(erptimes,zeros(size(erptimes)),':k')
title('Fz 9 Months')
%legend({'Female Other Race','Female Own Race','Male Own Race'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([0 1000])
ylim([-15 25])


subplot(3,4,10)
h(1)=plot(erptimes, mean(data_matrix_foth_CZ_9),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_CZ_9),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_CZ_9),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(3)=plot(erptimes, mean(data_matrix_mown_CZ_9),'LineWidth',lwplot,'color',[.8 .6 .7]);

plot(erptimes,zeros(size(erptimes)),':k')
title('Cz 9 Months')
%legend({'Female Other Race','Female Own Race','Male Own Race'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([0 1000])
ylim([-15 25])


subplot(3,4,11)
h(1)=plot(erptimes, mean(data_matrix_foth_CL_9),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_CL_9),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_CL_9),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(3)=plot(erptimes, mean(data_matrix_mown_CL_9),'LineWidth',lwplot,'color',[.8 .6 .7]);

plot(erptimes,zeros(size(erptimes)),':k')
title('CL 9 Months')
%legend({'Female Other Race','Female Own Race','Male Own Race'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([0 1000])
ylim([-15 25])


subplot(3,4,12)
h(1)=plot(erptimes, mean(data_matrix_foth_CR_9),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_CR_9),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_CR_9),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(3)=plot(erptimes, mean(data_matrix_mown_CR_9),'LineWidth',lwplot,'color',[.8 .6 .7]);

plot(erptimes,zeros(size(erptimes)),':k')
title('CR 9 Months')
%legend({'Female Other Race','Female Own Race','Male Other Race','Male Own Race'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([0 1000])
ylim([-15 25])



return







return

f1 = figure; 
lwplot=2;
figure(f1); 
set(gca,'FontSize',36)


for j= 1:96
    
    h(j) = plot(erptimes,data_matrix_mown_FZ_3(j,:),'LineWidth',lwplot);hold on
    
end

plot(erptimes,zeros(size(erptimes)),':k')
        
%title('Fz 3 Months')
%legend(h,{'Female Other','Female Own','Male Other','Male Own'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([-100 1000])
ylim([-15 25])







return





f1 = figure; 
lwplot=2;
figure(f1); 
set(gca,'FontSize',36)

%subplot(5,3,1)
h(1)=plot(erptimes, mean(data_matrix_foth_FZ_3),'LineWidth',lwplot,'color',[.0 .0 .0]);hold on
h(2)=plot(erptimes, mean(data_matrix_fown_FZ_3),'LineWidth',lwplot,'color',[.9 .6 .0]);
h(3)=plot(erptimes, mean(data_matrix_moth_FZ_3),'LineWidth',lwplot,'color',[.0 .6 .5]);
h(4)=plot(erptimes, mean(data_matrix_mown_FZ_3),'LineWidth',lwplot,'color',[.8 .6 .7]);
plot(erptimes,zeros(size(erptimes)),':k')
title('Fz 3 Months')
legend(h,{'Female Other','Female Own','Male Other','Male Own'},'Location', 'southoutside','Orientation','horizontal')
%legend boxoff 
hold off 
xlim([-100 1000])
ylim([-15 25])












return


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
