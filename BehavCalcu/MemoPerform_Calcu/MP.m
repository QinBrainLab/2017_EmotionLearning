%% face-item
sub = struct('a1',[],'a2',[],'a3',[],'a4',[]);
% d1:all confidence (face-item);
% d2:leave out unsure(face-item);
% d3:HC(face-item);
n = 88;
result(88:n) = sub;
for j = 88:n
    if j < 10
        name = ['S0',num2str(j)];
    else
        name = ['S',num2str(j)];
    end

% all confidence
    A = xlsread('po2'),name);
    countnum1 = zeros(1,3);
    pos1 = find(A(:,1)== 11);
    temp1 = A(pos1,:);
    pos2 = find(A(:,1)== 22);
    temp2 = A(pos2,:);
   
    pos3 = temp1(:,4)==1;
    pos4 = temp2(:,4)==1;
    countnum1(1,1) = sum(pos3)/36;
    countnum1(1,2) = sum(pos4)/36;
    countnum1(1,3) = (sum(pos3)+sum(pos4))/72;
  % leave out unsure
    A = xlsread('po2',name);
    pos = find(A(:,3)== 2|A(:,3)== 3|A(:,3)== 4);
    A = A(pos,:);
    
    countnum2 = zeros(1,3);
    pos1 = find(A(:,1)== 11);
    temp1 = A(pos1,:);
    pos2 = find(A(:,1)== 22);
    temp2 = A(pos2,:);
   
    pos3 = temp1(:,4)==1;
    pos4 = temp2(:,4)==1;
    countnum2(1,1) = sum(pos3)/36;
    countnum2(1,2) = sum(pos4)/36;
    countnum2(1,3) = (sum(pos3)+sum(pos4))/72;
    
 % HC
    A = xlsread('po2',name);
    pos = find(A(:,3)== 3|A(:,3)== 4);
    A = A(pos,:);
    
    countnum3 = zeros(1,3);
    pos1 = find(A(:,1)== 11);
    temp1 = A(pos1,:);
    pos2 = find(A(:,1)== 22);
    temp2 = A(pos2,:);
   
    pos3 = temp1(:,4)==1;
    pos4 = temp2(:,4)==1;
    countnum3(1,1) = sum(pos3)/36;
    countnum3(1,2) = sum(pos4)/36;
    countnum3(1,3) = (sum(pos3)+sum(pos4))/72;
 
 % 4
    A = xlsread('po2',name);
    pos = find(A(:,3)== 4);
    A = A(pos,:);
    
    countnum4 = zeros(1,3);
    pos1 = find(A(:,1)== 11);
    temp1 = A(pos1,:);
    pos2 = find(A(:,1)== 22);
    temp2 = A(pos2,:);
   
    pos3 = temp1(:,4)==1;
    pos4 = temp2(:,4)==1;
    countnum4(1,1) = sum(pos3)/36;
    countnum4(1,2) = sum(pos4)/36;
    countnum4(1,3) = (sum(pos3)+sum(pos4))/72;
    
    result(j).a1 = countnum1;
    result(j).a2 = countnum2;
    result(j).a3 = countnum3;
    result(j).a4 = countnum4;
end
    
%% pos3
X = xlsread('po1&po3','po3');
% all confidence
for i=35:97
  posi = find(X(:,1)== i); 
  tempi = X(posi,:);
 %missing data
  posim = find(isnan(tempi(:,3)) == 1);
  B(i,1) = size(posim,1);
  %neg & neu
  posi11=tempi(:,3)==1;
  posi22=tempi(:,3)==2;
  B(i,2)= sum(posi11)/36;
  B(i,3)= sum(posi22)/36;
  posi1=tempi(:,2)==11;
  posi2=tempi(:,2)==22;
  tempi1=tempi(posi1,:);
  tempi2=tempi(posi2,:);
  posi1=tempi1(:,3)==1;
  posi2=tempi2(:,3)==2;
  B(i,4)= sum(posi1)/36;
  B(i,5)= sum(posi2)/36;
  B(i,6)= (sum(posi1)+sum(posi2))/72;
end

% leave out unsure
for i=35:97
  posi = find(X(:,1)== i); 
  tempi = X(posi,:);
  posi = find(tempi(:,4)== 2|tempi(:,4)== 3|tempi(:,4)== 4);
  tempi = tempi(posi,:);
  %neg & neu 
  posi11=tempi(:,3)==1;
  posi22=tempi(:,3)==2;
  B(i,7)= sum(posi11)/36;
  B(i,8)= sum(posi22)/36;
  posi1=tempi(:,2)==11;
  posi2=tempi(:,2)==22;
  tempi1=tempi(posi1,:);
  tempi2=tempi(posi2,:);
  posi1=tempi1(:,3)==1;
  posi2=tempi2(:,3)==2;
  B(i,9)= sum(posi1)/36;
  B(i,10)= sum(posi2)/36;
  B(i,11)= (sum(posi1)+sum(posi2))/72;
end

% HC
for i=35:97
  posi = find(X(:,1)== i); 
  tempi = X(posi,:);
  posi = find(tempi(:,4)== 3|tempi(:,4)== 4);
  tempi = tempi(posi,:);
  %neg & neu 
  posi11=tempi(:,3)==1;
  posi22=tempi(:,3)==2;
  B(i,12)= sum(posi11)/36;
  B(i,13)= sum(posi22)/36;
  posi1=tempi(:,2)==11;
  posi2=tempi(:,2)==22;
  tempi1=tempi(posi1,:);
  tempi2=tempi(posi2,:);
  posi1=tempi1(:,3)==1;
  posi2=tempi2(:,3)==2;
  B(i,14)= sum(posi1)/36;
  B(i,15)= sum(posi2)/36;
  B(i,16)= (sum(posi1)+sum(posi2))/72;
end

% 4
for i=35:97
  posi = find(X(:,1)== i); 
  tempi = X(posi,:);
  posi = find(tempi(:,4)== 4);
  tempi = tempi(posi,:);
  %neg & neu 
  posi11=tempi(:,3)==1;
  posi22=tempi(:,3)==2;
  B(i,17)= sum(posi11)/36;
  B(i,18)= sum(posi22)/36;
  posi1=tempi(:,2)==11;
  posi2=tempi(:,2)==22;
  tempi1=tempi(posi1,:);
  tempi2=tempi(posi2,:);
  posi1=tempi1(:,3)==1;
  posi2=tempi2(:,3)==2;
  B(i,19)= sum(posi1)/36;
  B(i,20)= sum(posi2)/36;
  B(i,21)= (sum(posi1)+sum(posi2))/72;
end
%% pos1
 X = xlsread('po1&po3','po1');
% all confidence
for i=35:97
  posi = find(X(:,1)== i); 
  tempi = X(posi,:);
 %missing data
  posim = find(isnan(tempi(:,4)) == 1);
  C(i,1) = size(posim,1);
 %FA
   posi0 = find(isnan(tempi(:,3)) == 1);
   tempi0 = tempi(posi0,:);
   posi0 = tempi0(:,4)==1;
   C(i,2) = sum(posi0)/72;
  %neg & neu
  posi1=tempi(:,3)==11;
  posi2=tempi(:,3)==22;
  tempi1=tempi(posi1,:);
  tempi2=tempi(posi2,:);
  posi1=tempi1(:,4)==1;
  posi2=tempi2(:,4)==1;
  C(i,3)= sum(posi1)/36;
  C(i,4)= sum(posi2)/36;
  C(i,5)= (sum(posi2)+sum(posi1))/72;
end

% leave out unxure
for i=35:97
  posi = find(X(:,1)== i); 
  tempi = X(posi,:);
  posi = find(tempi(:,5)== 2|tempi(:,5)== 3|tempi(:,5)== 4);
  tempi = tempi(posi,:);
 %FA
   posi0 = find(isnan(tempi(:,3)) == 1);
   tempi0 = tempi(posi0,:);
   posi0 = tempi0(:,4)==1;
   C(i,6) = sum(posi0)/72;
  %neg & neu 
  posi1=tempi(:,3)==11;
  posi2=tempi(:,3)==22;
  tempi1=tempi(posi1,:);
  tempi2=tempi(posi2,:);
  posi1=tempi1(:,4)==1;
  posi2=tempi2(:,4)==1;
  C(i,7)= sum(posi1)/36;
  C(i,8)= sum(posi2)/36;
  C(i,9)= (sum(posi1)+sum(posi2))/72;
end

% HC
for i=35:97
  posi = find(X(:,1)== i); 
  tempi = X(posi,:);
  posi = find(tempi(:,5)== 3|tempi(:,5)== 4);
  tempi = tempi(posi,:);
 %FA
   posi0 = find(isnan(tempi(:,3)) == 1);
   tempi0 = tempi(posi0,:);
   posi0 = tempi0(:,4)==1;
   C(i,10) = sum(posi0)/72;
  %neg & neu
  posi1=tempi(:,3)==11;
  posi2=tempi(:,3)==22;
  tempi1=tempi(posi1,:);
  tempi2=tempi(posi2,:);
  posi1=tempi1(:,4)==1;
  posi2=tempi2(:,4)==1;
  C(i,11)= sum(posi1)/36;
  C(i,12)= sum(posi2)/36;
  C(i,13)= (sum(posi1)+ sum(posi2))/72;
end
% 4
for i=35:97
  posi = find(X(:,1)== i); 
  tempi = X(posi,:);
  posi = find(tempi(:,5)== 4);
  tempi = tempi(posi,:);
 %FA
   posi0 = find(isnan(tempi(:,3)) == 1);
   tempi0 = tempi(posi0,:);
   posi0 = tempi0(:,4)==1;
   C(i,14) = sum(posi0)/72;
  %neg & neu
  posi1=tempi(:,3)==11;
  posi2=tempi(:,3)==22;
  tempi1=tempi(posi1,:);
  tempi2=tempi(posi2,:);
  posi1=tempi1(:,4)==1;
  posi2=tempi2(:,4)==1;
  C(i,15)= sum(posi1)/36;
  C(i,16)= sum(posi2)/36;
  C(i,17)= (sum(posi1)+ sum(posi2))/72;
end
end

