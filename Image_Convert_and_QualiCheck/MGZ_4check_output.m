clear; clc;
rawpath='/lustre/iCAN/backup/MGZ/raw_data';
datapath='/lustre/iCAN/data/2017/';
load('MGZ_database.mat')

cd(rawpath);
files=dir('MGZ*');
filenames={files.name};
for i= filenames(1,[1:11])
    cd(i{:});
    subid=regexp(i,'1\d+','match','once');
    index=find(ismember(Database(:,1),subid));
    file_id=Database{index,2};
    Spath1=strcat(datapath,file_id,'/fmri/REST_01/unnormalized/I.nii.gz');
    Spath2=strcat(datapath,file_id,'/fmri/REST_02/unnormalized/I.nii.gz');
    Spath3=strcat(datapath,file_id,'/fmri/REST_03/unnormalized/I.nii.gz');
    Spath4=strcat(datapath,file_id,'/fmri/PL_01/unnormalized/I.nii.gz');
    Spath5=strcat(datapath,file_id,'/fmri/PL_02/unnormalized/I.nii.gz');
    Spath6=strcat(datapath,file_id,'/fmri/EL/unnormalized/I.nii.gz');
    Spath7=strcat(datapath,file_id,'/mri/anatomy/I.nii.gz');
    Spath8=strcat(datapath,file_id,'/fmri/DTI/*.nii.gz');
    Spath9=strcat(datapath,file_id,'/mri/DTI_fieldmap/*.nii.gz');
    Spath10=strcat(datapath,file_id,'/mri/REST_fieldmap/*.nii.gz');
    
    disp('==================================================================');
    fprintf('checking %s',file_id);
 
  

%     unix(sprintf('fslinfo %s',Spath1))
    unix(sprintf('ls %s',Spath1))
    unix(sprintf('ls %s',Spath2))
    unix(sprintf('ls %s',Spath3))
    unix(sprintf('ls %s',Spath4))
    unix(sprintf('ls %s',Spath5))
    unix(sprintf('ls %s',Spath6))
    unix(sprintf('ls %s',Spath7))
    unix(sprintf('ls %s',Spath8))
    unix(sprintf('ls %s',Spath9))
    unix(sprintf('ls %s',Spath10))
    
   
  cd('../');
end