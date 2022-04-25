%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-Configuration file for trial_by_trial_rsa_wholebrain.m
%-Created bt Jared and Shaozheng in Summer, 2013
%-Modified and unified by Shaozheng Qin on December 2, 2013
%-Added parellell processing by Shaozheng Qin on December 4, 2013
%-Revised by Yunzhe Liu for Memory Suppression Task on September 8, 2014 (win 8)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
% Please specify the path to the folder holding subjects
paralist.ServerPath = '/lustre/iCAN/home/zhuangliping/DEP_MS/individualstats/2015';
paralist.StatsPath='/fmri/stats_spm8/DEP_MS_new/stats_spm8_swcar';

%paralist.RawDataPath = '/fs/musk1';


%/fs/musk2/2011/11-07-20.2/fmri/stats_spm8/addevent_stats_spm8_swaor_glb_noderiv_single_trial
% Plese specify the list of subjects or a cell array
  load('/lustre/iCAN/home/zhuangliping/DEP_MS/scripts/DEP_database.mat');
  a=1;
 for i =[67]
  paralist.SubjectList{a,1}=DEP_database{i,2};
  a=a+1;
 end
 
%paralist.SubjectList = {'15-04-14.6DEP'};%previously list.txt

% Please specify the stats folder name from SPM analysis
% paralist.StatsFolder = 'stats_spm8_1runs_swar_noderiv_single_trial';

% Please specify whether to use t map or beta map ('tmap' or 'conmap')
paralist.MapType = 'tmap';

% Please specify the index of tmap or contrast map (only 2 allowed)
% If the second t map is spmT_0003.img, the number is 3 (from 003) in the 
% second slot
paralist.SessCon = [1, 2]; %Number of sessions and number of contrasts each session
%paralist.MapIndex = [1:1:32];
%previously paralist.MapIndex = [1,3];

% Please specify the mask file, if it is empty, it uses the default one from SPM.mat
paralist.MaskFile = '/lustre/iCAN/SPM/spm8/apriori/grey.nii';

% Please specify the path to the folder holding analysis results
paralist.OutputDir = '/lustre/iCAN/home/zhuangliping/DEP_MS/RSA/RSA_RUN_TNT';

%--------------------------------------------------------------------------
paralist.SearchShape = 'sphere';
paralist.SearchRadius = 6; % in mm
%--------------------------------------------------------------------------
