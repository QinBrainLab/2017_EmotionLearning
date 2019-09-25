clear;clc;
load('E:\MGZ_data\script\MGZ_database.mat');

    mask=strcat('E:\MGZ_data\define_ROIs\PPI_ROI\LFFA_object_ns_EL_neg_neu_2.nii');
    vol_mask=spm_vol(mask);
    array_mask=spm_read_vols(vol_mask);
    
    for i=1:33
        out_f=strcat('E:\MGZ_data\individualstats_conditions_final_2s\2017\',Database{i,2});
        cd(out_f);
          
        run=strcat(out_f,'\fmri\stats_spm8\EL_emotion_facenon2_voice2\stats_spm8_swcar_gPPI_h18_l18_0.01_100\PPI_Hip_PL_EL_all4_new\','spmT_PPI_negative_',Database{i,2},'.img');
        vol_run=spm_vol(run);
        array_run=spm_read_vols(vol_run);
        EL_object_ns{1,i}(:,1)=array_run(find(array_mask(:)==1));
        
        run=strcat(out_f,'\fmri\stats_spm8\EL_emotion_facenon2_voice2\stats_spm8_swcar_gPPI_h18_l18_0.01_100\PPI_Hip_PL_EL_all4_new\','spmT_PPI_neutral_',Database{i,2},'.img');
        vol_run=spm_vol(run);
        array_run=spm_read_vols(vol_run);
        EL_object_ns{1,i}(:,2)=array_run(find(array_mask(:)==1));
    end
    
    mask=strcat('E:\MGZ_data\define_ROIs\PPI_ROI\LFFA_object_ns_EL_neg_neu_2.nii');
    vol_mask=spm_vol(mask);
    array_mask=spm_read_vols(vol_mask);
    
    for i=1:33
        out_f=strcat('E:\MGZ_data\individualstats_conditions_final_2s\2017\',Database{i,2});
        cd(out_f);
          
        run=strcat(out_f,'\fmri\stats_spm8\PL_emotion_2s\stats_spm8_swcar_gPPI_h18_l18_0.01_100/PPI_Hip_PL_EL_all4_new\','spmT_PPI_negative_',Database{i,2},'.img');
        vol_run=spm_vol(run);
        array_run=spm_read_vols(vol_run);
        PL_object_ns{1,i}(:,1)=array_run(find(array_mask(:)==1));
        
        run=strcat(out_f,'\fmri\stats_spm8\PL_emotion_2s\stats_spm8_swcar_gPPI_h18_l18_0.01_100/PPI_Hip_PL_EL_all4_new\','spmT_PPI_neutral_',Database{i,2},'.img');
        vol_run=spm_vol(run);
        array_run=spm_read_vols(vol_run);
        PL_object_ns{1,i}(:,2)=array_run(find(array_mask(:)==1));
    end   
    
    mask=strcat('E:\MGZ_data\define_ROIs\PPI_ROI\LFFA_object_ns_EL_neg_neu_2.nii');
    vol_mask=spm_vol(mask);
    array_mask=spm_read_vols(vol_mask);
    
    for i=1:33
        out_f=strcat('E:\MGZ_data\individualstats_conditions_final_2s\2017\',Database{i,2});
        cd(out_f);
        
        run=strcat(out_f,'\fmri\stats_spm8\EL_emo_mem_facenon2_voice2\stats_spm8_swcar_gPPI_h18_l18_0.01_100\PPI_Hip_PL_EL_all4_new\','spmT_PPI_negative_for_',Database{i,2},'.img');
        vol_run=spm_vol(run);
        array_run=spm_read_vols(vol_run);
        EL_object4{1,i}(:,1)=array_run(find(array_mask(:)==1));
        
        run=strcat(out_f,'\fmri\stats_spm8\EL_emo_mem_facenon2_voice2\stats_spm8_swcar_gPPI_h18_l18_0.01_100\PPI_Hip_PL_EL_all4_new\','spmT_PPI_neutral_for_',Database{i,2},'.img');
        vol_run=spm_vol(run);
        array_run=spm_read_vols(vol_run);
        EL_object4{1,i}(:,2)=array_run(find(array_mask(:)==1));
        
        run=strcat(out_f,'\fmri\stats_spm8\EL_emo_mem_facenon2_voice2\stats_spm8_swcar_gPPI_h18_l18_0.01_100\PPI_Hip_PL_EL_all4_new\','spmT_PPI_negative_HC_',Database{i,2},'.img');
        vol_run=spm_vol(run);
        array_run=spm_read_vols(vol_run);
        EL_object4{1,i}(:,3)=array_run(find(array_mask(:)==1));
        
        run=strcat(out_f,'\fmri\stats_spm8\EL_emo_mem_facenon2_voice2\stats_spm8_swcar_gPPI_h18_l18_0.01_100\PPI_Hip_PL_EL_all4_new\','spmT_PPI_neutral_HC_',Database{i,2},'.img');
        vol_run=spm_vol(run);
        array_run=spm_read_vols(vol_run);
        EL_object4{1,i}(:,4)=array_run(find(array_mask(:)==1));
    end
 