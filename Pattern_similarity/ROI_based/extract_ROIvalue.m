clc;
clear;

load('/lustre/iCAN/home/zhuyannan/MGZ_new/script/MGZ_database.mat');

%%%%% ROI Hippocampus %%%%%%
    mask=strcat('/lustre/iCAN/home/zhuyannan/MGZ_new/define_ROIs/aal_ROI/HIP_aal.nii');

    vol_mask=spm_vol(mask);
    array_mask=spm_read_vols(vol_mask);
    
    for i=1:33
        out_f=strcat('/lustre/iCAN/home/zhuyannan/MGZ_new/individualstats_conditions_2s/2017/',Database{i,2});
        cd(out_f);
        
        for k=1:72
            if k<10 
            trial=strcat(out_f,'/fmri/stats_spm8/EL_emotion/stats_spm8_swcar/','spmT_000',num2str(k),'.nii');
            vol_trial=spm_vol(trial);
            array_trial=spm_read_vols(vol_trial);
            HIPvalue{1,i}(:,k)=array_trial(find(array_mask(:)==1));
            
            else
                
            trial=strcat(out_f,'/fmri/stats_spm8/EL_emotion/stats_spm8_swcar/','spmT_00',num2str(k),'.nii');
            vol_trial=spm_vol(trial);
            array_trial=spm_read_vols(vol_trial);
            HIPvalue{1,i}(:,k)=array_trial(find(array_mask(:)==1));
            end
        end
    end

    
