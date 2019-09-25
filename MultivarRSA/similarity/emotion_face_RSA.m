clear all; close all; clc;
PL = load('PL_HIP_PL_EL_all4');%
EL = load('ELface2_HIP_PL_EL_all4');%
PL = struct2cell(PL);
EL = struct2cell(EL);
for i=1:33
   PL_neg=PL{1,1}{1,1}{1,i}(:,1);
   PL_neu=PL{1,1}{1,1}{1,i}(:,2);
   EL_face_neg=EL{1,1}{1,1}{1,i}(:,1);
   EL_face_neu=EL{1,1}{1,1}{1,i}(:,2);
   EL_voice_neg=EL{1,1}{1,1}{1,i}(:,3);
   EL_voice_neu=EL{1,1}{1,1}{1,i}(:,4);
    PL_neg_mean= mean(PL_neg);
    PL_neg_std=std(PL_neg);
    PL_neu_mean= mean(PL_neu);
    PL_neu_std=std(PL_neu);
    EL_face_neg_mean= mean(EL_face_neg);
    EL_face_neg_std=std(EL_face_neg);
    EL_face_neu_mean= mean(EL_face_neu);
    EL_face_neu_std=std(EL_face_neu);
    EL_voice_neg_mean= mean(EL_voice_neg);
    EL_voice_neg_std=std(EL_voice_neg);
    EL_voice_neu_mean= mean(EL_voice_neu);
    EL_voice_neu_std=std(EL_voice_neu);
    
    for k=1:174 %%%%%
        
PL_neg(k)= (PL_neg(k) - PL_neg_mean)/PL_neg_std;
PL_neu(k)= (PL_neu(k) - PL_neu_mean)/PL_neu_std;
EL_face_neg(k)= (EL_face_neg(k) - EL_face_neg_mean)/EL_face_neg_std;
EL_face_neu(k)= (EL_face_neu(k) - EL_face_neu_mean)/EL_face_neu_std;
EL_voice_neg(k)= (EL_voice_neg(k) - EL_voice_neg_mean)/EL_voice_neg_std;
EL_voice_neu(k)= (EL_voice_neu(k) - EL_voice_neu_mean)/EL_voice_neu_std;
    end
    
    [r_face_neg,P_face_neg]=corr(PL_neg,EL_face_neg);
    [r_face_neu,P_face_neu]=corr(PL_neu,EL_face_neu);
    [r_voice_neg,P_voice_neg]=corr(PL_neg,EL_voice_neg);
    [r_voice_neu,P_voice_neu]=corr(PL_neu,EL_voice_neu);
    
    P(i,1)=P_face_neg;
    P(i,2)=P_face_neu;
    P(i,3)=P_voice_neg;
    P(i,4)=P_voice_neu;
    
    r_face_neg1(i,1)=r_face_neg;
    r_face_neu1(i,1)=r_face_neu;
    r_voice_neg1(i,1)=r_voice_neg;
    r_voice_neu1(i,1)=r_voice_neu;
end


for j=1:33
r_face_neg_Z(j)=1/2*log((1+r_face_neg1(j))/(1-r_face_neg1(j)));
r_face_neu_Z(j)=1/2*log((1+r_face_neu1(j))/(1-r_face_neu1(j)));
r_voice_neg_Z(j)=1/2*log((1+r_voice_neg1(j))/(1-r_voice_neg1(j)));
r_voice_neu_Z(j)=1/2*log((1+r_voice_neu1(j))/(1-r_voice_neu1(j)));
r_Z(j,1)=r_face_neg_Z(j);
r_Z(j,2)=r_face_neu_Z(j);
r_Z(j,3)=r_voice_neg_Z(j);
r_Z(j,4)=r_voice_neu_Z(j);
end


