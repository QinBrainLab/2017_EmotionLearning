clear all; close all; clc;
temp = load('ELface2_object_vns_PL_ELfacenon2_all4');%
temp = struct2cell(temp);
for i=1:33
   temp{1,1}{1,i}(1,:)=[];
end