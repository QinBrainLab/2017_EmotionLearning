clear;
clc;

%2017
%EL
subid=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33] ;
subname={'17-01-10.1MGZ';'17-01-11.1MGZ';'17-01-11.2MGZ';'17-01-12.1MGZ';'17-01-12.2MGZ';
'17-01-13.1MGZ';'17-01-13.2MGZ';'17-02-13.1MGZ';'17-02-13.2MGZ';'17-02-14.1MGZ';
'17-02-14.2MGZ';'17-02-22.1MGZ';'17-02-22.2MGZ';'17-03-07.1MGZ';'17-03-07.2MGZ';
'17-03-08.1MGZ';'17-03-08.2MGZ';'17-03-09.1MGZ';'17-03-09.2MGZ';'17-03-21.1MGZ';
'17-03-21.2MGZ';'17-03-22.1MGZ';'17-03-22.2MGZ';'17-03-23.1MGZ';'17-03-23.2MGZ';
'17-03-24.1MGZ';'17-03-24.2MGZ';'17-03-28.1MGZ';'17-03-28.2MGZ';'17-03-29.1MGZ';
'17-03-29.2MGZ';'17-03-30.1MGZ';'17-03-30.2MGZ';};

MxSubid=33;%!!
DataPath1='/lustre/iCAN/data/2017/';

Edat=load ('EL_cons_33_2s.txt');


%+++++++++++Need to change before++++++++++++

[SubN,temp]=size(subid');
%Per subject 72 trails
trails=72;
%Subnum
M=SubN;

DataPath2='/fmri/EL/task_design/taskdesign_emotion_EL_voice2s.m';


for k=1:M
    
    
 for j=1:MxSubid
    
    if subid(k)==j
        tmpSubid=Edat(:,1);
        loc=find(tmpSubid'==j);
        subjectid=Edat(loc,1);
        OnsetTime1=Edat(loc,2);
        OnsetTime2=Edat(loc,3);
        Type=Edat(loc,5);
        k
        j
        subjectid
           
        if(j==subjectid(1))
          index=find(subid==j);
          Outputtaskdesignpathtmp_taskdesign=strcat(DataPath1, subname(index),'/fmri/EL/task_design');
          strtaskdir=Outputtaskdesignpathtmp_taskdesign{1};
          mkdir(strtaskdir);
          Outputtaskdesignpathtmp=strcat(DataPath1, subname(index),DataPath2);
          Outputtaskdesignpath=cell2mat(Outputtaskdesignpathtmp);
          Outputtaskdesignpath
          
          break; 
                 
        end
    end

end   
%ï¿½ï¿½È¥ï¿½ï¿½Ê¼Öµ
OnsetTime_stim1=OnsetTime1-OnsetTime1(1);
OnsetTime_stim2=OnsetTime2-OnsetTime1(1);
onsets1=[];
onsets2=[];
onsets3=[];



face_type=find(Type==1|Type==2|Type==3|Type==4|Type==5|Type==6|Type==7|Type==8);
neg_type=find(Type==1|Type==2|Type==3|Type==4);
neu_type=find(Type==5|Type==6|Type==7|Type==8);


[size_face_type,t1]=size(face_type);
[size_neg_type,t2]=size(neg_type);
[size_neu_type,t3]=size(neu_type);


        for i=1:size_face_type
             onsets1(i)=OnsetTime_stim1(face_type(i));
        end
        
        for i=1:size_neg_type
             onsets2(i)=OnsetTime_stim2(neg_type(i));
        end

        for i=1:size_neu_type
             onsets3(i)=OnsetTime_stim2(neu_type(i));
        end


onsets1=onsets1/1000;
onsets2=onsets2/1000;
onsets3=onsets3/1000;

% 
% if onsets1(1)<0
%     fprintf('**************************The first onset time is unormal, onsets1(1) is \n');
%     onsets1(1)
% end
% 
% if onsets2(1)<0
%     fprintf('**************************The first onset time is unormal,  onsets2(1) is \n'); 
%     onsets2(1)
% end
% if onsets3(1)<0
%     fprintf('**************************The first onset time is unormal,  onsets3(1) is \n'); 
%     onsets3(1)
% end
% if onsets4(1)<0
%     fprintf('**************************The first onset time is unormal,  onsets4(1) is \n'); 
%     onsets4(1)
% end
% if onsets5(1)<0
%     fprintf('**************************The first onset time is unormal,  onsets5(1) is \n'); 
%     onsets5(1)
% end
% if onsets6(1)<0
%     fprintf('**************************The first onset time is unormal,  onsets6(1) is \n'); 
%     onsets6(1)
% end

Outputtaskdesignpath

if (exist(Outputtaskdesignpath,'file'))
     delete(Outputtaskdesignpath);
end

% if(fopen(Outputtaskdesignpath,'a'))
    
fp=fopen(Outputtaskdesignpath,'a');

fprintf(fp, '%s\n', 'sess_name =''EL'';');

fprintf(fp, '%s\n','names{1}     = [''face_type''];');
fprintf(fp, '%s','onsets{1}    = [');
for i =1:size(face_type)
    fprintf(fp, '%.3f', onsets1(i));
    fprintf(fp, '%s', ',');
end
fprintf(fp, '%s\n','];');
fprintf(fp, '%s','durations{1} = [');
for i =1:size(face_type)
    fprintf(fp, '%.3f', 2);
    fprintf(fp, '%s', ',');
end
fprintf(fp, '%s\n','];');


fprintf(fp, '%s\n','names{2}     = [''neg_type''];');
fprintf(fp, '%s','onsets{2}    = [');
for i =1:size(neg_type)
    fprintf(fp, '%.3f', onsets2(i));
    fprintf(fp, '%s', ',');
end
fprintf(fp, '%s\n','];');
fprintf(fp, '%s','durations{2} = [');
for i =1:size(neg_type)
    fprintf(fp, '%.3f', 2);
    fprintf(fp, '%s', ',');
end
fprintf(fp, '%s\n','];');


fprintf(fp, '%s\n','names{3}     = [''neu_type''];');
fprintf(fp, '%s','onsets{3}    = [');
for i =1:size(neu_type)
    fprintf(fp, '%.3f', onsets3(i));
    fprintf(fp, '%s', ',');
end
fprintf(fp, '%s\n','];');
fprintf(fp, '%s','durations{3} = [');
for i =1:size(neu_type)
    fprintf(fp, '%.3f', 2);
    fprintf(fp, '%s', ',');
end
fprintf(fp, '%s\n','];');

fprintf(fp, '%s\n','rest_exists  = 1;');

fprintf(fp, '%s\n','save task_design.mat sess_name names onsets durations rest_exists');

fclose(fp); 
end

fprintf('Finish taskdesign \n');

