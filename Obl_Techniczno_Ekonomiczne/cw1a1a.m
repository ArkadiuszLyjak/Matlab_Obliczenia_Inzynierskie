close all;
clc; 
clearvars;

z10=1-2i;
z12=0.5+1i;
z13=2+4i;
z30=0.3-3i;
z34=1.5+2i;
z40=2-3i;

Y1=[1/z10+1/z12+1/z13 -1/z12 -1/z13 0
    -1/z12 1/z12 0 0
    -1/z13 0 1/z13+1/z34+1/z30 -1/z34
    0 0 -1/z34 1/z34+1/z40]
op= [ 1/z10 1/z12 1/z13 1/z30 1/z34 1/z40];
G=diag(op);

K=[1 0 0 1 0 1
   -1 -1 -1 0 0 0
   0 1 0 0 0 0
   0 0 1 -1 -1 0
   0 0 0 0 1 -1]

 Dane=[1 0 1 -2
     1 2 0.5 1
     1 3 2 4
     3 0 0.3 -3
     3 4 1.5 2
     4 0 2 -3];
 
 wp=Dane(:,1); 
 wk=Dane(:,2); 
 r=Dane(:,3); 
 x=Dane(:,4);
 n=max(wp);
m=length(Dane);
Y=zeros(n);
K=zeros(n+1,m);
G=zeros(m,m);
L=zeros(n);


z= r + x*1i;
y=1./z;
licz.gal=length(y)
for i= 1:licz.gal
    if (wp(i)~=0 && wk(i)~=0)
        Y(wp(i),wk(i))= -y(i)
        Y(wp(i),wk(i))= -y(i)
    end
end
licz.wez=max(max(wp),max(wk))

 
 for j=1:m
    K(wp(j)+1,j)=1;
    K(wk(j)+1,j)=-1;
end
for j=1:m
    G(j,j)=Dane(j,4)+Dane(j,3)*1i;
end
K
G
Y=K*G*K'
for i=1:n
    for j=1:n
L(j,i)=Y(j+1,i+1);
    end
end


