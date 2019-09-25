clear all; close all; clc;
PL = load('PL_HIP_PL_EL_all4');%
EL = load('ELfacenon2_HIP_PL_EL_all4');%
PL = struct2cell(PL);
EL = struct2cell(EL);

for i=1:33
    PL_neg=PL{1,1}{1,1}{1,i}(:,1);
    PL_neu=PL{1,1}{1,1}{1,i}(:,2);
    EL_neg=EL{1,1}{1,1}{1,i}(:,2);
    EL_neu=EL{1,1}{1,1}{1,i}(:,3);
    PL_neg_mean= mean(PL_neg);
    PL_neg_std=std(PL_neg);
    PL_neu_mean= mean(PL_neu);
    PL_neu_std=std(PL_neu);
    EL_neg_mean= mean(EL_neg);
    EL_neg_std=std(EL_neg);
    EL_neu_mean= mean(EL_neu);
    EL_neu_std=std(EL_neu);
    
    for k=1:174 %%%%%
        
PL_neg(k)= (PL_neg(k) - PL_neg_mean)/PL_neg_std;
PL_neu(k)= (PL_neu(k) - PL_neu_mean)/PL_neu_std;
EL_neg(k)= (EL_neg(k) - EL_neg_mean)/EL_neg_std;
EL_neu(k)= (EL_neu(k) - EL_neu_mean)/EL_neu_std;
    end
    
    [r_neg,P_neg]=corr(PL_neg,EL_neg);
    [r_neu,P_neu]=corr(PL_neu,EL_neu);
   
    P(i,1)=P_neg;
    P(i,2)=P_neu;
  
    r_neg1(i,1)=r_neg;
    r_neu1(i,1)=r_neu;

end


for j=1:33
r_neg_Z(j)=1/2*log((1+r_neg1(j))/(1-r_neg1(j)));
r_neu_Z(j)=1/2*log((1+r_neu1(j))/(1-r_neu1(j)));
r_Z(j,1)=r_neg_Z(j);
r_Z(j,2)=r_neu_Z(j);
end


