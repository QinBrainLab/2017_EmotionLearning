clear all; close all; clc;
PL = load('PL.mat');%
EL = load('EL.mat');%
PL = struct2cell(PL);
EL = struct2cell(EL);

for i=1:33 %subject loop
%     if i==5||i==19||i==25||i==27||i==31
%             continue;
%     else
        for j=1:72 %trial loop
            PL_trial=PL{1,1}{1,1}{1,i}(:,j);
            EL_trial=EL{1,1}{1,1}{1,i}(:,j);

            StdPLTrial=(PL_trial-mean(PL_trial(:))) ./ std(PL_trial(:));
            StdELTrial=(EL_trial-mean(EL_trial(:))) ./ std(EL_trial(:));

            [r_corr,p_corr]=corr(StdPLTrial,StdELTrial);
            R(j,i)=r_corr;
        end
end      
        
for m=1:33
    R_trial=R(:,m);
    r(m,1)= mean(R_trial);
end

for n=1:33
    r_Z(n,1)=1/2*log((1+r(n))/(1-r(n)));
end
