clc;
clear;

load('E:\MGZ_data\script\MGZ_database.mat');

%%%% whole brain %%%%%%    
mask=strcat('E:\MGZ_data\define_ROIs\functional_mask\PL_emo_mem_face2\PL_allfwe2.nii');
     
    vol_mask=spm_vol(mask);
    array_mask=spm_read_vols(vol_mask);
    
    for i=1:33
        out_f=strcat('E:\MGZ_data\individualstats_conditions_final_2s\2017\',Database{i,2});
        cd(out_f);
        
        for k=1:2
  
            trial=strcat(out_f,'\fmri\stats_spm8\PL_emotion_2s\stats_spm8_swcar\','spmT_000',num2str(k),'.nii');
            vol_trial=spm_vol(trial);
            array_trial=spm_read_vols(vol_trial);
            PL_whole2value{1,i}(:,k)=array_trial(find(array_mask(:)==1));
            
           
        end
    end
   
    mask=strcat('E:\MGZ_data\define_ROIs\functional_mask\PL_emo_mem_face2\PL_allfwe2.nii');
     
    vol_mask=spm_vol(mask);
    array_mask=spm_read_vols(vol_mask);
    
    for i=1:33
        out_f=strcat('E:\MGZ_data\individualstats_conditions_final_2s\2017\',Database{i,2});
        cd(out_f);
        
        for k=1:3
  
            trial=strcat(out_f,'\fmri\stats_spm8\EL_emotion_facenon2_voice2\stats_spm8_swcar\','spmT_000',num2str(k),'.nii');
            vol_trial=spm_vol(trial);
            array_trial=spm_read_vols(vol_trial);
            EL_whole2value{1,i}(:,k)=array_trial(find(array_mask(:)==1));
            
           
        end
    end