clc;
clear;
close all;

Outpath = '\example_data\'
% OutpathResults='D:\memory_generalization\memory_genenralization(FMRI)\SCL_analysis\result1\'
hz=1000;
n=2;
duration=n*hz;
trialnum=36;%%%each conditionn



TsFilename=dir(strcat(Outpath,'*.mat'));
 NumFile=length(TsFilename);
 
 for sub=1:NumFile
     load(strcat(Outpath,TsFilename(sub).name));
     strcat(Outpath,TsFilename(sub).name)
     rawdata=data(:,1);
     savename=TsFilename(sub).name;

N=size(rawdata);
signal=rawdata(1:N(1));


% figure;
b=[1 1 1 1 1 1]/6;
Signal_Filter=filter(b,1,signal);
% subplot(2,1,1);
% plot(signal(1:end));
% axis([0 N(1) min(rawdata) max(rawdata)])
% title(strcat('Orignal',savename(1:end-4)));


% subplot(2,1,2);
% plot(Signal_Filter(1:end));
% axis([0 N(1) min(rawdata) max(rawdata)])
% title(strcat('After Filter',savename(1:end-4)));

filterdata=Signal_Filter;

%%%%%%%%condition negative 11 channel2%%%%%%%%%%%%%%%%%%%%
ch2info=data(:,2);

ch2info_open0=[0;ch2info];
ch2info_end0=[ch2info;0];
ad_ch2info=ch2info_open0-ch2info_end0;

%figure;
%plot(ad_ch2info);

num11=find(ad_ch2info==-5);

%%%%%%%%condition negative 11 channel2%%%%%%%%%%%%%%%%%%%%
ch4info=data(:,4);

ch4info_open0=[0;ch4info];
ch4info_end0=[ch4info;0];
ad_ch4info=ch4info_open0-ch4info_end0;

%figure;
%plot(ad_ch4info);

num22=find(ad_ch4info==-5);

for i=1:36%trialnum
    consub11(i)=mean(filterdata(num11(i):num11(i)+duration-1));
    
end
for i=1:36%trialnum
     consub22(i)=mean(filterdata(num22(i):num22(i)+duration-1));
end
con11(sub,:)=consub11;
con22(sub,:)=consub22;
subname(sub,:)=savename;
meancon11(sub)=mean(consub11);
meancon22(sub)=mean(consub22);

 end

  



