%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-Main function: trial_by_trial_rsa_wholebrain.m
%-Created bt Jared and Shaozheng on 08-08-2013
%-Modified and unified by Shaozheng Qin on December 2, 2013
%-Added parellell processing by Shaozheng Qin on December 4, 2013
%-Revised by Yunzhe Liu for Memory Suppression Task on September 8, 2014 (win 8)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function rsa_wholebrain_usingt (ConfigFile)

CurrentDir = pwd;
ConfigFile = strtrim(ConfigFile);
if ~exist(ConfigFile,'file')
    fprintf('Error: cnnot find the configuration file ... \n');
    return;
end
ConfigFile = ConfigFile(1:end-2);
eval(ConfigFile);

ServerPath   = strtrim(paralist.ServerPath);
StatsPath = strtrim(paralist.StatsPath) ;
SubjectList  = strtrim(paralist.SubjectList);
MapType      = strtrim(paralist.MapType);
%SessCon      = paralist.SessCon;
MaskFile     = strtrim(paralist.MaskFile);
OutputDir    = strtrim(paralist.OutputDir);
SearchShape  = strtrim(paralist.SearchShape);
SearchRadius = paralist.SearchRadius;

disp('-------------- Contents of the Parameter List --------------------');
disp(paralist);
disp('------------------------------------------------------------------');
clear paralist;
disp('==================================================================');
disp('rsa_trialwise_wholebrain.m is running');
fprintf('Current directory is: %s\n', pwd);
%fprintf('Config file is: %s\n', ConfigFile);
disp('------------------------------------------------------------------');
disp('==================================================================');
fprintf('\n');

Subjects = SubjectList;
NumSubj = length(Subjects);
%nSS = SessCon(1);
%nCon = SessCon(2);

for iSubj = 1:NumSubj
    display(strcat('Processing subject: ', Subjects{iSubj}, '; ', int2str(iSubj), '/', int2str(length(Subjects))));
    DataDir = fullfile(ServerPath, Subjects{iSubj},StatsPath);
    
    spm_mat = load(fullfile(DataDir, 'SPM.mat'));
    SPM = spm_mat.SPM;
    
    nt_neg = 1;     t_neg=65;
    nt_neu = 129; t_neu=193;
    
    nt_neg_trial_num = [1,3,5,7,9,11,13,15];
    t_neg_trial_num=[2,4,6,8,10,12,14,16];
    nt_neu_trial_num =[17,19,21,23,25,27,29,31];
    t_neu_trial_num=[18,20,22,24,26,28,30,32];
    
    CorrIndex=[];
    
    for i = 1:size(SPM.xCon,2)
        t_name= regexp(SPM.xCon(1,i).name,'trial\w+','match','once');...
            t_num=t_name(6:end);
        t_num=str2num(t_num);
        if ismember(t_num,nt_neg_trial_num)==1
            CorrIndex(nt_neg,1)=i; nt_neg=nt_neg+1;
        elseif ismember(t_num,t_neg_trial_num)==1
            CorrIndex(t_neg,1)=i; t_neg=t_neg+1;
        elseif ismember(t_num,nt_neu_trial_num)==1
            CorrIndex(nt_neu,1)=i; nt_neu=nt_neu+1;
        elseif ismember(t_num,t_neu_trial_num)==1
            CorrIndex(t_neu,1)=i; t_neu=t_neu+1;
        end
    end
    
    NumMap = size(CorrIndex,1);
    VY = cell(NumMap, 1);
    MapName = cell(NumMap, 1);
    
    switch lower(MapType)
        case 'tmap'
            for i = 1:NumMap
                VY{i} = fullfile(DataDir, SPM.xCon(CorrIndex(i)).Vspm.fname);
                MapName{i} = SPM.xCon(CorrIndex(i)).name;
            end
        case 'conmap'
            for i = 1:NumMap
                VY{i} = fullfile(DataDir, SPM.xCon(CorrIndex(i)).Vcon.fname);
                MapName{i} = SPM.xCon(CorrIndex(i)).name;
            end
    end
    
    if isempty(MaskFile)
        VM = fullfile(DataDir, SPM.VM.fname);
    else
        VM = MaskFile;
    end
    
    OutputFolder = fullfile(OutputDir, Subjects{iSubj});
    if ~exist(OutputFolder, 'dir')
        mkdir(OutputFolder);
    end
    %k = 1;
    
    for i=[1:32]
        for j = 8*(i-1)+1:8*(i-1)+8
            display(strcat('...Computing map: ', int2str(i), '..writing out ...'));
            for k = j+1:8*(i-1)+8
                
                if i<=8
                    FileEnd = strcat('rsa_NTneg_run',num2str(i), '_',int2str(CorrIndex(j)),'_', int2str(CorrIndex(k)));
                end
                
                if 8<i && i<=16
                    FileEnd = strcat('rsa_Tneg_run',num2str(i-8), '_',int2str(CorrIndex(j)),'_', int2str(CorrIndex(k)));
                end
                
                if 16<i && i<=24
                    FileEnd = strcat('rsa_NTneu_run',num2str(i-16), '_',int2str(CorrIndex(j)),'_', int2str(CorrIndex(k)));
                end
                
                if 24<i && i<=32
                    FileEnd = strcat('rsa_Tneu_run',num2str(i-24), '_',int2str(CorrIndex(j)),'_', int2str(CorrIndex(k)));
                end
                
                OutputFile = fullfile(OutputFolder, FileEnd);
                SearchOpt = struct('def', 'sphere', 'spec', 6);
                SearchOpt.def = SearchShape;
                SearchOpt.spec = SearchRadius;
                
                CurrentMaps = cell(2,1);
                CurrentMaps{1} = VY{j};
                CurrentMaps{2} = VY{k};
                
                scsnl_searchlight_qin(CurrentMaps, VM, SearchOpt, 'pearson_correlation', OutputFile);
            end
        end
    end
    % display(strcat('Averaging maps subject: ', Subjects{iSubj}, '; ', int2str(iSubj), '/', int2str(length(Subjects))));
    %fprintf('Averaging Subject %s', int2str(iSubj), ' of %s', int2str(NumSubj), ' : %s', Subjects{iSubj});
    % average_nonconsec_correlation_maps(numPairs, OutputFolder);
end

disp('-----------------------------------------------------------------');
fprintf('Changing back to the directory: %s \n', CurrentDir);
cd(CurrentDir);
disp('Wholebrain RSA is done.');
clear all;
%close all;

%matlabpool('close');

end

