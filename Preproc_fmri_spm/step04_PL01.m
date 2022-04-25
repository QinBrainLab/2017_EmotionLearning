clear;clc;
datapath='/lustre/iCAN/data/2017/';
cd(datapath);
allsubjs=dir('*MGZ');
allsubjs={allsubjs.name};
nsubjs=numel(allsubjs);
for i=[1]
    subjdir=allsubjs{i};
    sprintf(subjdir)
   funcdir=fullfile(datapath,subjdir,'/fmri/PL_01/unnormalized/');
   cd(funcdir);
%      unix(sprintf('ls swmuaI0100.nii'));

   unix(sprintf('fslmerge -a swcarI swmuaI0*.nii'));
%    unix(sprintf('fslmerge -a wmuaI wmuaI0*.nii')); 
%    unix(sprintf('fslmerge -a muaI muaI0*.nii')); 
%    unix(sprintf('fslmerge -a uaI uaI0*.nii')); 
% %   unix(sprintf('rm swmuaI0*.nii'));
% %   unix(sprintf('rm  wmuaI0*.nii'));
% %   unix(sprintf('rm  muaI0*.nii'));
% %   unix(sprintf('rm  uaI0*.nii'));
%   
     swcar=fullfile(datapath,subjdir,'/fmri/PL_01/smoothed_spm8/');
%       cd(swcar)
%       unix(sprintf('fslinfo swcar*'))
     mkdir(swcar)
     unix(sprintf('mv %s %s','swcarI.nii.gz',swcar));
    unix(sprintf('mv %s %s','rp_aI.txt',fullfile(swcar,'rp_I.txt')));
   unix(sprintf('mv %s %s','V*',swcar));
%   
end