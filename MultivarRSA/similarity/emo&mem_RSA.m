clear all; close all; clc;
PL = load('PL_HIP_PL_EL_memory_all4');%
EL = load('EL_HIP_PL_EL_memory_all4');%
PL = struct2cell(PL);
EL = struct2cell(EL);
for i=1:33
    PL_forgot_neg=PL{1,1}{1,1}{1,i}(:,2);
    PL_forgot_neu=PL{1,1}{1,1}{1,i}(:,3);
    PL_HC_neg=PL{1,1}{1,1}{1,i}(:,4);
    PL_HC_neu=PL{1,1}{1,1}{1,i}(:,5);
    EL_forgot_neg=EL{1,1}{1,1}{1,i}(:,3);
    EL_forgot_neu=EL{1,1}{1,1}{1,i}(:,4);
    EL_HC_neg=EL{1,1}{1,1}{1,i}(:,5);
    EL_HC_neu=EL{1,1}{1,1}{1,i}(:,6);

    PL_forgot_neg_mean= mean(PL_forgot_neg);
    PL_forgot_neg_std=std(PL_forgot_neg);
    PL_forgot_neu_mean= mean(PL_forgot_neu);
    PL_forgot_neu_std=std(PL_forgot_neu);
    PL_HC_neg_mean= mean(PL_HC_neg);
    PL_HC_neg_std=std(PL_HC_neg);
    PL_HC_neu_mean= mean(PL_HC_neu);
    PL_HC_neu_std=std(PL_HC_neu);
    
    EL_forgot_neg_mean= mean(EL_forgot_neg);
    EL_forgot_neg_std=std(EL_forgot_neg);
    EL_forgot_neu_mean= mean(EL_forgot_neu);
    EL_forgot_neu_std=std(EL_forgot_neu);
    EL_HC_neg_mean= mean(EL_HC_neg);
    EL_HC_neg_std=std(EL_HC_neg);
    EL_HC_neu_mean= mean(EL_HC_neu);
    EL_HC_neu_std=std(EL_HC_neu);
    
    for k=1:174 %%%%%
        
PL_forgot_neg(k)= (PL_forgot_neg(k) - PL_forgot_neg_mean)/PL_forgot_neg_std;
PL_forgot_neu(k)= (PL_forgot_neu(k) - PL_forgot_neu_mean)/PL_forgot_neu_std;
PL_HC_neg(k)= (PL_HC_neg(k) - PL_HC_neg_mean)/PL_HC_neg_std;
PL_HC_neu(k)= (PL_HC_neu(k) - PL_HC_neu_mean)/PL_HC_neu_std;

EL_forgot_neg(k)= (EL_forgot_neg(k) - EL_forgot_neg_mean)/EL_forgot_neg_std;
EL_forgot_neu(k)= (EL_forgot_neu(k) - EL_forgot_neu_mean)/EL_forgot_neu_std;
EL_HC_neg(k)= (EL_HC_neg(k) - EL_HC_neg_mean)/EL_HC_neg_std;
EL_HC_neu(k)= (EL_HC_neu(k) - EL_HC_neu_mean)/EL_HC_neu_std;
    end
    
    [r_forgot_neg,P_forgot_neg]=corr(PL_forgot_neg,EL_forgot_neg);
    [r_forgot_neu,P_forgot_neu]=corr(PL_forgot_neu,EL_forgot_neu);
    [r_HC_neg,P_HC_neg]=corr(PL_HC_neg,EL_HC_neg);
    [r_HC_neu,P_HC_neu]=corr(PL_HC_neu,EL_HC_neu);
    
    P(i,1)=P_forgot_neg;
    P(i,2)=P_forgot_neu;
    P(i,3)=P_HC_neg;
    P(i,4)=P_HC_neu;
    r_forgot_neg1(i,1)=r_forgot_neg;
    r_forgot_neu1(i,1)=r_forgot_neu;
    r_HC_neg1(i,1)=r_HC_neg;
    r_HC_neu1(i,1)=r_HC_neu;
end

for j=1:33
r_forgot_neg_Z(j)=1/2*log((1+r_forgot_neg1(j))/(1-r_forgot_neg1(j)));
r_forgot_neu_Z(j)=1/2*log((1+r_forgot_neu1(j))/(1-r_forgot_neu1(j)));
r_HC_neg_Z(j)=1/2*log((1+r_HC_neg1(j))/(1-r_HC_neg1(j)));
r_HC_neu_Z(j)=1/2*log((1+r_HC_neu1(j))/(1-r_HC_neu1(j)));
r_Z(j,1)=r_forgot_neg_Z(j);
r_Z(j,2)=r_forgot_neu_Z(j);
r_Z(j,3)=r_HC_neg_Z(j);
r_Z(j,4)=r_HC_neu_Z(j);

end
