clear all; close all; clc;
PL = load('PPI_PL_Amg_neg_neu_2');%
EL = load('PPI_EL_Amg_neg_neu_2');%
PL = struct2cell(PL);
EL = struct2cell(EL);
for i=1:33
    PL_neg=PL{1,1}{1,1}{1,i}(:,1);
    PL_neu=PL{1,1}{1,1}{1,i}(:,2);

    EL_neg=EL{1,1}{1,1}{1,i}(:,1);
    EL_neu=EL{1,1}{1,1}{1,i}(:,2);
    A(i,1)=mean(EL_neg);
    A(i,2)=mean(EL_neu);
    A(i,3)=mean(PL_neg);
    A(i,4)=mean(PL_neu);
end
