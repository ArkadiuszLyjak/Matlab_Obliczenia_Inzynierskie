close all;
clc; 
clearvars;

B=[ 1 0 2       -1
    1 2 0.5     2
    1 4 1       3
    2 3 1.5     2
    2 5 1       2
    3 5 3       1.5
    3 4 0.5     2
    3 7 2.5     1
    4 0 1       -1.5
    4 7 1.5     2
    7 0 1.5     -1.5
    5 6 0       1
    6 7 0       0.5
    6 0 0.5     -2.5];
fb=B(:,1)
tb=B(:,2);
n=max(fb);
m=length(B);
Y=zeros(n);
K=zeros(n+1,m);
G=zeros(m,m);
L=zeros(n);

for j=1:m
    K(fb(j)+1,j)=1;
    K(tb(j)+1,j)=-1;
end
for j=1:m
    G(j,j)=B(j,4)+B(j,3)*1i;
end
K
G;
Y=K*G*K';
for i=1:n
    for j=1:n
L(j,i)=Y(j+1,i+1);
    end
end
