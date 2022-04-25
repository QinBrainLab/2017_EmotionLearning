clear;clc;
datapath='/lustre/iCAN/data/2017/';
cd(datapath);
files=dir('*MGZ');
filenames={files.name};
 for i=filenames(1,[5:11]);  % msg/phase=3/4

    path1=strcat(datapath,i{:},'/fmri/REST_01/REST01_fieldmap/');
    path2=strcat(datapath,i{:},'/fmri/REST_02/REST02_fieldmap/');
    path3=strcat(datapath,i{:},'/fmri/REST_03/REST03_fieldmap/');
    path4=strcat(datapath,i{:},'/fmri/PL_01/PL01_fieldmap/');
    path5=strcat(datapath,i{:},'/fmri/PL_02/PL02_fieldmap/');
    path6=strcat(datapath,i{:},'/fmri/EL/EL_fieldmap/');
    

   
      
    disp('==================================================================');
    fprintf('converting %s',i{:});
    

    mag1='*003a1001.nii.gz';
    mag1a='mag_shortTE.nii.gz';
    mag2='*003a2001.nii.gz';
    mag2a='mag_longTE.nii.gz';
    phase='*004a2001.nii.gz';
    phase_a='phase.nii.gz';
     
    cd(path1);
    unix(sprintf('mv %s %s',mag1,mag1a));
    unix(sprintf('mv %s %s',mag2,mag2a));
    unix(sprintf('mv %s %s',phase,phase_a));
  
    
    cd(path2);
    unix(sprintf('mv %s %s',mag1,mag1a));
    unix(sprintf('mv %s %s',mag2,mag2a));
    unix(sprintf('mv %s %s',phase,phase_a));
 
    
    cd(path3);
    unix(sprintf('mv %s %s',mag1,mag1a));
    unix(sprintf('mv %s %s',mag2,mag2a));
    unix(sprintf('mv %s %s',phase,phase_a));
  
    
    cd(path4);
    unix(sprintf('mv %s %s',mag1,mag1a));
    unix(sprintf('mv %s %s',mag2,mag2a));
    unix(sprintf('mv %s %s',phase,phase_a));
   
    
    cd(path5);
    unix(sprintf('mv %s %s',mag1,mag1a));
    unix(sprintf('mv %s %s',mag2,mag2a));
    unix(sprintf('mv %s %s',phase,phase_a));

    cd(path6);
    unix(sprintf('mv %s %s',mag1,mag1a));
    unix(sprintf('mv %s %s',mag2,mag2a));
    unix(sprintf('mv %s %s',phase,phase_a));
    
    cd('../../../../');
    
end




    
    