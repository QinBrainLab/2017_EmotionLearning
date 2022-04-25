function step01_PL01(magdir,magfilter,phasedir,phasefilter,funcdir,funcfilter,t1dir,t1filter,DataType,filemapmfile)
%% this function creates VDM (voxel-distortion map) file based on the phase image and magnitude images, using
% the 'presubtracted phase and magnitude data' module in SPM8 and SPM12;

%% inputs:
% 1) magdir: the directory for magnitude image of shorter TE; magfilter: prefix of the magitude image
% 2) phasedir: the directory for phase image; phasefilter: prefix of the phase image
% 3) funcdir: the directory of functional images the researchers want to preprocess;  funcfilter: prefix of the functional images
% 4) filemapmfile: a .m file contains all the parameters for the fieldmap data. This file would be different across studies, pertinent to the scanner and sequence you use for data collection. Always it could be got from your technician, absolute path
% 5) t1dir and t1filter: the high-resolution anatomic image for each subjects, it is optional, you can leave a ~ if you don't want to align anatomic image to DVM for quality check. If you want to do this, t1 image should be in its absolute path

%% output
% When the function is finished, you will find an file prefixed 'VDM' in the same folder as the phase image; this is the VDM needed in later preprocessing

%% developed by Changming Chen, at Beijing Normal University and Xinyang Normal University
% 2016-9-24

clear matlabbatch;
[magimage, ~] = selectfiles_changming(magdir, magfilter, DataType);
[phaseimage, ~] = selectfiles_changming(phasedir, phasefilter, DataType);
[funcimages, ~] = selectfiles_changming(funcdir, funcfilter, DataType);
[a1,~,~]=fileparts(mfilename('fullpath'));
spmver=spm('version');
if strfind(spmver,'SPM12')
    load(fullfile(a1,'fieldmap_00createvdm12.mat'));
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.phase = {[phaseimage{1},',1']};
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.magnitude = {[magimage{1},',1']};
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsfile = {filemapmfile};
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.session.epi ={[funcimages{1},',1']};   % use the first volume of the functional images here, just for quality inspection, please see SPM instruction
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.matchvdm = 1;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.sessname = 'session';
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.writeunwarped = 0;
    if exist(t1dir,'var') & exist(t1filter,'var')
        [t1, ~] = selectfiles_changming(t1dir, t1filter, DataType);
        matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.anat = {[t1,',1']};
        matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.matchanat = 1;
    else
        matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.anat = {''};
        matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.matchanat = 0;
    end
    save('fieldmap_00createvdm_xxx','matlabbatch');
elseif strfind(spmver,'SPM8')
end
spm_jobman('run',matlabbatch);
end

function [InputImgFile, SelectErr] = selectfiles_changming(FileDir, PrevPrefix, DataType)
% adapted from 'preprocessfmri_selectfiles' in Shaozheng Qin's Lab
ListFile = dir(fullfile(FileDir, [PrevPrefix, '*.gz']));
if ~isempty(ListFile)
    try
        unix(sprintf('gunzip -fq %s', fullfile(FileDir, [PrevPrefix, '*.gz'])));
    catch
    end
end
SelectErr = 0;
switch DataType
    case 'img'
        InputImgFile = spm_select('ExtFPList', FileDir, ['^', PrevPrefix, '.*.img']);
    case 'nii'
        InputImgFile = spm_select('ExtFPList', FileDir, ['^', PrevPrefix, '.*.nii']);
        V = spm_vol(InputImgFile);
        if size(V(1).private.dat.dim,2)==4
            nframes = V(1).private.dat.dim(4);
            InputImgFile = spm_select('ExtFPList', FileDir, ['^', PrevPrefix, '.*.nii'], (1:nframes));
            clear V nframes;
        end
end
InputImgFile = deblank(cellstr(InputImgFile));
if isempty(InputImgFile{1})
    SelectErr = 1;
    error(['No data   ',fullfile(FileDir,[PrevPrefix,'*']),'  was found!!']);
    return;
end
end