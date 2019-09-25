clear;
clc;

%2017
%PL01
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

DataPath2='/fmri/EL/task_design/taskdesign_EL2s_singletrial.m';


for k=1:M
    
    
 for j=1:MxSubid
    
    if subid(k)==j
        tmpSubid=Edat(:,1);
        loc=find(tmpSubid'==j);
        subjectid=Edat(loc,1);
        OnsetTime1=Edat(loc,2);
        OnsetTime2=Edat(loc,3);
        Type=Edat(loc,4);
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
oneset_start=min(OnsetTime1)
OnsetTime_stim1=OnsetTime1-oneset_start;
OnsetTime_stim2=OnsetTime2-oneset_start;
onsets1=OnsetTime_stim1/1000;
onsets2=OnsetTime_stim2/1000;


Outputtaskdesignpath

if (exist(Outputtaskdesignpath,'file'))
     delete(Outputtaskdesignpath);
end

% if(fopen(Outputtaskdesignpath,'a'))
    
fp=fopen(Outputtaskdesignpath,'a');

fprintf(fp, '%s\n', 'sess_name =''EL'';');

   for k=[1:72]
    fprintf(fp, '%s\n',strcat('names{',num2str(k),'}  = [''trial',num2str(k),'''];')); 
    fprintf(fp, '%s\n',[strcat('onsets{',num2str(k),'} = [',num2str(onsets2(k)),'] ;')]);
    fprintf(fp, '%s\n',[strcat('durations{',num2str(k),'} = [2.000];')]);
   end
      
fprintf(fp, '%s\n','names{73}     = [''face_type''];');
fprintf(fp, '%s','onsets{73}    = [');
for i =1:72
    fprintf(fp, '%.3f', onsets1(i));
    fprintf(fp, '%s', ',');
end
fprintf(fp, '%s\n','];');
fprintf(fp, '%s','durations{73} = [');
for i =1:72
    fprintf(fp, '%.3f', 2);
    fprintf(fp, '%s', ',');
end
fprintf(fp, '%s\n','];');


fprintf(fp, '%s\n','rest_exists  = 1;');

fprintf(fp, '%s\n','save task_design.mat sess_name names onsets durations rest_exists');

fclose(fp); 
end

fprintf('Finish taskdesign \n');

