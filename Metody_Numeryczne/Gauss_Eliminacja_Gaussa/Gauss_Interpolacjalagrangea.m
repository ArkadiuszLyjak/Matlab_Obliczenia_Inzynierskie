%Interpolacja Lagrangea
%3. Samodzielna implementacja interpolacji Lagrange'a lub Newtona.

close all;
clearvars;
clc;  

format shortG ,format compact

st=13;
xmin = 0;
xmax = 1;
x = linspace(xmin,xmax,st);
y = 1./(1+25*x.^2);
[p,L] = Gauss_F_Interpollagrange(x,y); %wyznacza wielomian Lagrange'a Implementacja w funkcji InterpolLagrange

np=51; 
xl = linspace(xmin,xmax,np);
yl = polyval(p,xl); %interpolacja do zadanych punktow


%  dla potzreb porównawczych
x=linspace(-1,1,100);
y= 1./(1+25*x.^2) ;
%

figure(1)
clf
plot(x,y,'r')  % wykres dok³adny
grid on
hold on
%
plot(xl,yl,'--b')  % wykres dla interpolacji lagrangea
%
xlabel('x');ylabel('f(x)');
title( ' Interpolacja Lagrangea  funkcji y=1/(1+25*x^2)');
legend('Dok³adny','Lagrangea',1);




%
yref= 1./(1+25*xl.^2);
bbyl=(yref-yl);       % b³ad bezwzgledny
%
figure(2); 
clf
plot(xl,bbyl,'--b') 
title( 'B³¹d bezwzglêdny interpolacji Lagrangea')
legend( 'Lagrangea',1)