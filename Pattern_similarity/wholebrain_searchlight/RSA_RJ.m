%% parameter
clear;clc;
VM = '/home/zhuyannan/toolbox/SPM/spm8/apriori/grey.nii';
SearchOpt = struct('def', 'sphere', 'spec', 6);
SearchOpt.def ='sphere';
SearchOpt.spec = 6;
%% file
NiiPath='/home/zhuyannan/MGZ_new/RSA_wholebrain_searchlight_t/conditions/';
cd(NiiPath);
spm_dir=dir('*L*');
spm={spm_dir.name}';
OutputFolder1=('/home/zhuyannan/MGZ_new/RSA_wholebrain_searchlight_t/results/neg/');
OutputFolder2=('/home/zhuyannan/MGZ_new/RSA_wholebrain_searchlight_t/results/neu/');
mkdir(OutputFolder1);mkdir(OutputFolder2);
sub_file=cell(1);
load('/home/zhuyannan/MGZ_new/script/MGZ_database.mat');
%% prepare sub_file
a=1;
for i=[1:4,6:18,20:24,26,28:30,32,33]
    sub_id=Database{i,2};  
    for j=1:length(spm)
        sub_file(a,j)=strcat(NiiPath,spm{j,1},'/',{sub_id},'_',spm{j,1},'.nii');
    end
    a=a+1;
end
%% calculate RSA      
for k =2:length(sub_file)
    fprintf('Current sub: %s\n',sub_file{k,1});
    for m = [1,2]
        for n=m+2
            CurrentMaps = cell(2,1);
            CurrentMaps{1}=strcat(sub_file{k,m}) ;
            CurrentMaps{2} =strcat(sub_file{k,n});
            file_name1=regexp(sub_file{k,m},'17*.*voice_\w+','match');
            file_name2=regexp(sub_file{k,n},'17*.*PL_\w+','match');
            FileEnd = strcat('rsa-',file_name1{1,1},'-',file_name2{1,1});
            if m==1
               OutputFile = fullfile(OutputFolder1, FileEnd);
            else 
               OutputFile = fullfile(OutputFolder2, FileEnd); 
            end
            scsnl_searchlight_qin(CurrentMaps, VM, SearchOpt, 'pearson_correlation', OutputFile);
        end
    end
end   
    

