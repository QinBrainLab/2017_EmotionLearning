clear
clc
%Config 

list={'17-03-23.1MGZ';};

%Secssion={'PL_01' 'PL_02' 'EL' 'REST_01' 'REST_02' 'REST_03'};
Secssion={ 'EL'  'REST_03'};

%Secssion={'EM' 'WM' 'FH'};%Finish
%Secssion={'RS' 'BART'};
%Secssion={'RS'};

year='2017';

%ServerPath=strcat('/lustre/iCAN/data/wuliyun/data/individualstats/',year);
ServerPath=strcat('/lustre/iCAN/data/',year);

DataSavePath= '/lustre/iCAN/home/zhuyannan/MGZ_new/headmovements/';

[temp, secssionnum]=size(Secssion);


for secss=1:secssionnum
%
[Numoflist,col]=size(list);

otherdir=strcat('/fmri/',Secssion{secss},'/smoothed_spm8');

for iSubj = 1:Numoflist
    Sublist=cell2mat(list(iSubj))
            
    DataDir{iSubj} =  strcat(ServerPath, '/',Sublist,otherdir);
    
    headmovementname= strcat(DataDir{iSubj},'/','rp_I.txt');
    
    headmoveTRs=load(headmovementname);
    
     headmoveTRs(:,4:6)=headmoveTRs(:,4:6)*180/pi;
    
    [trs,measurements]=size(headmoveTRs);
%     AllheadmoveTRs(:,:,iSubj)=headmoveTRs;
    
    figure;
    
    plot(headmoveTRs);
    
x=1:trs;
     plot(x,headmoveTRs(:,1),'r-');
     hold on;
      plot(x,headmoveTRs(:,2),'g-');
     hold on;
      plot(x,headmoveTRs(:,3),'b-');
     hold on;
     
      plot(x,headmoveTRs(:,4),'r--');
     hold on;
      plot(x,headmoveTRs(:,5),'g--');
     hold on;
      plot(x,headmoveTRs(:,6),'b--');
     hold on;
     
   legend('x','y','z','r1','r2','r3')

xlabel(strcat(num2str(trs),'__TRs'));
ylabel('Six Headmovements');
% title(strcat(roi_names{k}),'Time series');
title(strcat(Secssion{secss},'__',Sublist,'_','Six Head Movements Measurements'));
saveas(gcf,strcat(DataSavePath,'_',Secssion{secss},Sublist,'.jpg'));
    
   
end


%  AllheadmoveTRs(:,:,iSubj)
%  [trs,measurements,subnums]=size(AllheamoveTRS);

end
