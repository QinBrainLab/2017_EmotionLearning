clear;clc;
rawpath='/lustre/iCAN/backup/MGZ/raw_data';
cd(rawpath);
files=dir('MGZ*');
filenames={files.name};
 for i=filenames(1,2:11)
       unix(sprintf('dcm2nii -n -g %s',i{:}));
 end