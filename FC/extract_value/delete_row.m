clear all; close all; clc;
temp = load('PPI_EL_object_vns_neg_neu_21');%
temp = struct2cell(temp);
for i=1:33
   temp{1,1}{1,i}(1,:)=[];
end