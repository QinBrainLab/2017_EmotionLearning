granddir='/lustre/iCAN/data/2017';
filemapmfile='/lustre/iCAN/home/zhuyannan/MGZ_new/pre/MGZ_pre_PL01/pm_defaults_Prisma_ep2d_224_64.m';
%sliceorder=load('sliceorder.mat');
load sliceorder;
tr=2;
DataType='nii';
vdmfilter='vdm5';
magfilter='mag_short';   %mag.nii
phasefilter='phase';  % phase.nii
t1filter='I';
funcfilter='I';
cd(granddir);
allsubjs=dir('*MGZ');
allsubjs={allsubjs.name};
nsubjs=numel(allsubjs);
for i=[1]
    % i=1:84 (10.10 done)
    subjdir=allsubjs{i};
     sprintf(subjdir)
    %% need to customize with your own paths...
    magdir=fullfile(granddir,subjdir,'fmri/PL_01/PL01_fieldmap/');%!
    phasedir=fullfile(granddir,subjdir,'/fmri/PL_01/PL01_fieldmap/');%!
    t1dir=fullfile(granddir,subjdir,'/mri/anatomy/');
    funcdir=fullfile(granddir,subjdir,'/fmri/PL_01/unnormalized/');%!
    vdmdir=fullfile(granddir,subjdir,'/fmri/PL_01/PL01_fieldmap/');%!
    %%============================
    step01_PL01(magdir,magfilter,phasedir,phasefilter,funcdir,funcfilter,t1dir,t1filter,DataType,filemapmfile);
    step02_PL01(vdmdir,vdmfilter,funcdir,funcfilter,t1dir,t1filter,sliceorder,tr,DataType);
    step03_PL01(vdmdir,vdmfilter,funcdir,funcfilter,t1dir,t1filter,sliceorder,tr,DataType);
end