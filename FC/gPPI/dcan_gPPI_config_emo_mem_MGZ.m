% Configuration file for dcan_gPPI.m
% _________________________________________________________________
%Shaozheng Qin adapted for his poject on January 1, 2014 

% Please specify the data server path
paralist.data_server = '/home/zhuyannan/data';

%added by genghaiyang specify the stats server path
paralist.server_path_stats = '/home/zhuyannan/MGZ_new/individualstats_conditions_final_2s';

% Please specify the parent folder of the static data
% For YEAR data structure, use the first one
% For NONE YEAR data structure, use the second one
paralist.parent_folder        = [''];

% Please specify the subject list file (.txt) or a cell array
paralist.subject_list = {
'17-01-11.1MGZ';'17-01-11.2MGZ';'17-01-12.1MGZ';'17-01-12.2MGZ';
                         '17-01-13.1MGZ';'17-01-13.2MGZ';'17-02-13.1MGZ';'17-02-13.2MGZ';
                         '17-02-14.1MGZ';'17-02-14.2MGZ';'17-02-22.1MGZ';'17-02-22.2MGZ';
                         '17-03-07.1MGZ';'17-03-07.2MGZ';'17-03-08.1MGZ';'17-03-08.2MGZ';
                         '17-03-09.1MGZ';'17-03-09.2MGZ';'17-03-21.1MGZ';'17-03-21.2MGZ';
                         '17-03-22.1MGZ';'17-03-22.2MGZ';'17-03-23.1MGZ';'17-03-23.2MGZ';
                         '17-03-24.1MGZ';'17-03-24.2MGZ';'17-03-28.1MGZ';'17-03-28.2MGZ';
                         '17-03-29.1MGZ';'17-03-29.2MGZ';'17-03-30.1MGZ';'17-03-30.2MGZ';};
%{'/home/qinlab/data/genghaiyang/data/sublist/sublist_nback_53.txt'};

% Please specify the stats folder name (eg., stats_spm8) 
paralist.stats_folder = '/EL_emo_mem_facenon2_voice2/stats_spm8_swcar';

% Please specify the .nii file(s) for the ROI(s)
%paralist.roi_file_list = {'/home/qinlab/data/genghaiyang/data/nback/SPM12_results/sub_e18_c18/ppi/roi/MFG.nii'                     
%};
% get .nii list
paralist.roi_nii_folder    = '/home/zhuyannan/MGZ_new/define_ROIs/PPI_ROI_temp';
niidir = dir(paralist.roi_nii_folder);
niidir = niidir(3:end);
niidir = struct2cell(niidir);
niidir = niidir(1,:);
niidir = niidir';
paralist.roi_file_list = fullfile(paralist.roi_nii_folder,'.',niidir);


% Please specify the name of the ROI
paralist.roi_name_list = {'Hip_PL_EL_all4_new'};

% Please specify the task to include
% tasks_to_include = { '1', 'task1', 'task2', 'task3'} -> must exist in all sessions
% tasks_to_include = { '0', 'task1', 'task2', 'task3'} -> does not need to exist in all sessions
paralist.tasks_to_include = {'1','neg_forgot_type', 'neu_forgot_type','neg_remembered_HC_type', 'neu_remembered_HC_type',};

%-------------------------------------------------------------------------%
% Please specify the confound names
paralist.confound_names = {'R1', 'R2', 'R3', 'R4', 'R5', 'R6'};