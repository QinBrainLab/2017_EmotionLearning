function step03_PL01(vdmdir,vdmfilter,funcdir,funcfilter,t1dir,t1filter,sliceorder,tr,DataType)

[funcimages, ~] = selectfiles_changming(funcdir, funcfilter, DataType);
 [t1, ~] = selectfiles_changming(t1dir, t1filter, DataType);
spmver=spm('version');
[a,~,~]=fileparts(mfilename('fullpath'));
 if strfind(spmver,'SPM12')
   
   cd(funcdir);
   unix(sprintf('fslsplit uaI.nii uaI -t'));
   unix(sprintf('gunzip uaI*.nii.gz'));
   
    %% run bias4epi
    p1=spm_select('ExtFPList', funcdir, ['^', 'BiasField', '.*.nii'] );  
    p2 = spm_select('ExtFPList', funcdir, ['^', 'uaI0', '.*.nii']);
    N=size(p2,1);
for i=1:N
    P=strvcat(p1(1,:),p2(i,:));
    fname=p2(i,:);
    [path,name,ext]=fileparts(fname);
    Q=fullfile(path,['m' name ext]);
    disp(['Writing: ' fname])
    f='i2.*i1';
    flags={[],[],[1],[4]};
    Q=spm_imcalc(P,Q,f,flags);
    clc
end        
%     
    %% segment the anatomical images
    
    clear matlabbatch;
    matlabbatch{1}.spm.spatial.preproc.channel.vols =t1;
    matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
    matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
    matlabbatch{1}.spm.spatial.preproc.channel.write = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {[spm('dir'),filesep,'tpm',filesep,'TPM.nii,1']};
    matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 1;
    matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {[spm('dir'),filesep,'tpm',filesep,'TPM.nii,2']};
    matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 1;
    matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {[spm('dir'),filesep,'tpm',filesep,'TPM.nii,3']};
    matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;
    matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {[spm('dir'),filesep,'tpm',filesep,'TPM.nii,4']};
    matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;
    matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {[spm('dir'),filesep,'tpm',filesep,'TPM.nii,5']};
    matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;
    matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {[spm('dir'),filesep,'tpm',filesep,'TPM.nii,6']};
    matlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus = 2;
    matlabbatch{1}.spm.spatial.preproc.tissue(6).native = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(6).warped = [0 0];
    matlabbatch{1}.spm.spatial.preproc.warp.mrf = 1;
    matlabbatch{1}.spm.spatial.preproc.warp.cleanup = 1;
    matlabbatch{1}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
    matlabbatch{1}.spm.spatial.preproc.warp.affreg = 'mni';
    matlabbatch{1}.spm.spatial.preproc.warp.fwhm = 0;
    matlabbatch{1}.spm.spatial.preproc.warp.samp = 3;
    matlabbatch{1}.spm.spatial.preproc.warp.write = [0 1];
    matlabbatch{2}.spm.spatial.normalise.write.subj.def(1) = cfg_dep('Segment: Forward Deformations', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','fordef', '()',{':'}));
    muafiles=dir([funcdir,filesep,'muaI0*']);
    muafiles={muafiles.name};
    muafiles=strcat(funcdir,filesep,muafiles',',1');
    matlabbatch{2}.spm.spatial.normalise.write.subj.resample =muafiles;
    matlabbatch{2}.spm.spatial.normalise.write.woptions.bb = [-90 -126 -72
        90 90 108];
    matlabbatch{2}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
    matlabbatch{2}.spm.spatial.normalise.write.woptions.interp = 4;
    matlabbatch{2}.spm.spatia1l.normalise.write.woptions.prefix = 'w';
    matlabbatch{3}.spm.spatial.smooth.data(1) = cfg_dep('Normalise: Write: Normalised Images (Subj 1)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
    matlabbatch{3}.spm.spatial.smooth.fwhm = [6 6 6];
    matlabbatch{3}.spm.spatial.smooth.dtype = 0;
    matlabbatch{3}.spm.spatial.smooth.im = 0;
    matlabbatch{3}.spm.spatial.smooth.prefix = 's';
    save(fullfile(funcdir,'fieldmap_02segtosmooth12'),'matlabbatch');
    spm_jobman('run',matlabbatch);
 end
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