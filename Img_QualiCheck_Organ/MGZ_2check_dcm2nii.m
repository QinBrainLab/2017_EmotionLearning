clear;clc;
rawpath='/lustre/iCAN/backup/MGZ/raw_data';
cd(rawpath);
files=dir('MGZ*');
filenames={files.name};

n=1;
 for i=filenames(1,1:11)
     cd(i{:});
     a1=unix(sprintf('ls *fieldmappingrest*.nii.gz'));
     a2=unix(sprintf('ls *rest1*.nii.gz'));
     a3=unix(sprintf('ls *PL1*.nii.gz'));
     a4=unix(sprintf('ls *PL2*.nii.gz'));
     a5=unix(sprintf('ls *rest2*nii.gz'));
     a6=unix(sprintf('ls *EL*.nii.gz'));
     a7=unix(sprintf('ls *rest3*nii.gz'));
     a8=unix(sprintf('ls *t1m*nii.gz'));
     a9=unix(sprintf('ls *fieldmappingHARDI*.nii.gz'));
     a10=unix(sprintf('ls *diff*nii.gz'));
     
     check(n,1:10)=[a1,a2,a3,a4,a5,a6,a7,a8,a9,a10];
     
     n=n+1;
     cd('../');
 end

 