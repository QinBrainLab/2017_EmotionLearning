filepath='/home/zhuyannan/MGZ_new/individualstats_conditions_final_2s/2017/';
load('/home/zhuyannan/MGZ_new/script/MGZ_database.mat');

infolder= 'LC';    
%outfolder='D2T';
outpath=strcat('/home/zhuyannan/MGZ_new/univariate_results_final/emo_mem_EL_PL_2s/PL_emo_mem/1st/',infolder);
mkdir(fullfile(outpath));
% image1=strcat('con_0001.img');
% image2=strcat('con_0001.hdr');
image=strcat('con_0001.nii');

for i=1:33
    if i==5||i==19||i==25||i==31|i==27 |i==11 |i==4 |i==15||i==18|i==22
        continue;
    else
    Database{i,2}
    cd(fullfile(filepath,Database{i,2},'/fmri/stats_spm8/PL_emo_mem_2s/stats_spm8_swcar'));
%     outimage1=strcat(outpath,'/con_0001_',Database{i,2},'.img');
%     outimage2=strcat(outpath,'/con_0001_',Database{i,2},'.hdr');
        outimage=strcat(outpath,'/con_0001_',Database{i,2},'.nii');
%     unix(sprintf('cp %s  %s',image1,outimage1));
%     unix(sprintf('cp %s  %s',image2,outimage2));
 unix(sprintf('cp %s  %s',image,outimage)); 
    end
    end