clear;clc;
load('MGZ_database.mat');
rawpath='/lustre/iCAN/backup/MGZ/raw_data';
datapath='/lustre/iCAN/data/2017/';
cd(rawpath);
files=dir('MGZ*');
filenames={files.name};

 for i=filenames(1,[2:11]);
      
      cd(i{:});
      subid=regexp(i,'1\d+','match','once');
      index=find(ismember(Database(:,1),subid));
      file_id=Database{index,2};
      
    Spath1=strcat(datapath,file_id,'/DICOM/');
    Spath2=strcat(datapath,file_id,'/fmri/REST_01/unnormalized/');
    Spath3=strcat(datapath,file_id,'/fmri/REST_01/task_design/');
    Spath4=strcat(datapath,file_id,'/fmri/REST_01/REST01_fieldmap/');
    Spath5=strcat(datapath,file_id,'/fmri/REST_02/unnormalized/');
    Spath6=strcat(datapath,file_id,'/fmri/REST_02/task_design/');
    Spath7=strcat(datapath,file_id,'/fmri/REST_02/REST02_fieldmap/');
    Spath8=strcat(datapath,file_id,'/fmri/REST_03/unnormalized/');
    Spath9=strcat(datapath,file_id,'/fmri/REST_03/task_design/');
    Spath10=strcat(datapath,file_id,'/fmri/REST_03/REST03_fieldmap/');
    Spath11=strcat(datapath,file_id,'/fmri/PL_01/unnormalized/');
    Spath12=strcat(datapath,file_id,'/fmri/PL_01/task_design/');
    Spath13=strcat(datapath,file_id,'/fmri/PL_01/PL01_fieldmap/');
    Spath14=strcat(datapath,file_id,'/fmri/PL_02/unnormalized/');
    Spath15=strcat(datapath,file_id,'/fmri/PL_02/task_design/');
    Spath16=strcat(datapath,file_id,'/fmri/PL_02/PL02_fieldmap/');
    Spath17=strcat(datapath,file_id,'/fmri/EL/unnormalized/');
    Spath18=strcat(datapath,file_id,'/fmri/EL/task_design/');
    Spath19=strcat(datapath,file_id,'/fmri/EL/EL_fieldmap/');
    Spath20=strcat(datapath,file_id,'/mri/REST_fieldmap/');
    Spath21=strcat(datapath,file_id,'/mri/DTI_fieldmap/');
    Spath22=strcat(datapath,file_id,'/mri/anatomy/');
    Spath23=strcat(datapath,file_id,'/fmri/DTI/');
    Spath24=strcat(datapath,file_id,'/fmri/DTI/DTI_fieldmap/');

     disp('==================================================================');
     fprintf('converting %s',i{:});
     mkdir(Spath1); mkdir(Spath2); mkdir(Spath3); mkdir(Spath4); mkdir(Spath5);mkdir(Spath6);
     mkdir(Spath7); mkdir(Spath8); mkdir(Spath9);mkdir(Spath10); 
     mkdir(Spath11); mkdir(Spath12); mkdir(Spath13); mkdir(Spath14); mkdir(Spath15);mkdir(Spath16);
     mkdir(Spath17); mkdir(Spath18); mkdir(Spath19);mkdir(Spath20); 
     mkdir(Spath21); mkdir(Spath22); mkdir(Spath23); mkdir(Spath24);
     
     mkdir (strcat(Spath1,i{:}));
     Dicomdir=strcat(rawpath,'/',i{:});
     unix(sprintf('cp %s %s',strcat(Dicomdir,'/*'),strcat(Spath1,i{:}))); 
     
    REST1='*rest1*.nii.gz';
    Soutpath2=strcat(Spath2,'I.nii.gz');
    unix(sprintf('cp %s %s ', REST1,Soutpath2));
    
    REST2='*rest2*.nii.gz';
    Soutpath5=strcat(Spath5,'I.nii.gz');
    unix(sprintf('cp %s %s ', REST2,Soutpath5));
    
    REST3='*rest3*.nii.gz';
    Soutpath8=strcat(Spath8,'I.nii.gz');
    unix(sprintf('cp %s %s ', REST3,Soutpath8));
    
    PL1='*PL1*.nii.gz';
    Soutpath11=strcat(Spath11,'I.nii.gz');
    unix(sprintf('fslroi %s %s 4 361 ', PL1,Soutpath11));
    
    PL2='*PL2*.nii.gz';
    Soutpath14=strcat(Spath14,'I.nii.gz');
    unix(sprintf('fslroi %s %s 4 361 ', PL2,Soutpath14));
    
    EL='*EL*.nii.gz';
    Soutpath17=strcat(Spath17,'I.nii.gz');
    unix(sprintf('fslroi %s %s 4 504 ', EL,Soutpath17));
    
    T1='2017*t1m*.nii.gz';
    Soutpath22=strcat(Spath22,'I.nii.gz');
    unix(sprintf('cp %s %s',T1,Soutpath22));
    
   DTI='*diff*nii.gz';
   unix(sprintf('cp %s %s',DTI,Spath23));
     
   FM1='*fieldmappingrest*nii.gz';
   unix(sprintf('cp %s %s',FM1,Spath4));
   unix(sprintf('cp %s %s',FM1,Spath7));
   unix(sprintf('cp %s %s',FM1,Spath10));
   unix(sprintf('cp %s %s',FM1,Spath13));
   unix(sprintf('cp %s %s',FM1,Spath16));
   unix(sprintf('cp %s %s',FM1,Spath19));
   unix(sprintf('cp %s %s',FM1,Spath20));
   
   FM2='*fieldmappingHARDI*nii.gz';
   unix(sprintf('cp %s %s',FM2,Spath21));
   unix(sprintf('cp %s %s',FM2,Spath24));
   cd('../');
  end



    
    