% InterpolacjaVandermonda
clc; clear; close all;
format shortG ,format compact
%-------------------------------------------------------------------------
xmin=-1; % lewy kraniec przedzia³u
xmax=1;  % prawy kraniec przedzia³u
st=13; % stopieñ wielomianu / ilosæ punktów interpolacji
x = linspace(xmin,xmax,st);
y= 1./(1+25*x.^2) ;
V=vander(x);  % Budowa macierzy Vandermonde'a 
% Uk³ad równañ - rozwiazanie dla wsp. wielomianu interpoluj¹cego
%[a0 a1 a2 ... an-1]^T=V^-1*[y0 y1...Yn-1]^T
a=inv(V)*y'; % wspó³czynniki wielomianu interpoluj¹cego
a=a';
np=51;

xv = linspace(-1,1,np);
yv = polyval(a,xv); %interpolacja do zadanych punktow obliczenie wartoœci wielomianu


x=linspace(-1,1,100)
y= 1./(1+25*x.^2) ;
%
figure(1)
clf
plot(x,y,'r')  % wykres dok³adny do porównania
grid on
hold on
%
plot(xv,yv,'g')  % wykres dla macierzy Vandermonde'a 
xlabel('x');ylabel('f(x)');
title( 'Wykresinter interpolacyjny funkcji y=1/(1+25*x^2)');
legend('Dok³adny''Vandermondea');