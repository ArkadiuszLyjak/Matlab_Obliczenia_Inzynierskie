%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arkadiusz �yjak, 170330, Gr. 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clearvars;
clc;  

% policzy� b��dy bezwzgl�dne i wzgl�dne dla poszczeg�lnych funkcji
% wyrysowa� b��dy (w razie potrzeby zastosowa� skal� 
% logarytmiczn� w osi rz�dnych)

% efekt rungego - oscylacje na kra�cach przedzia�u
y = @(x) 1./(1+25*x.^2);

% modu� x, brak ci�g�ej pochodnej
y1 = @(x) abs(x);

% nieograniczona pochodna na kra�cach przedzia�u
y2 = @(x) sqrt(1-x.^2);

% nier�niczkowalna dla x=0
y3 = @(x) x.*exp(x);


x = linspace(-1,1,100);
figure;
plot(x,y1(x),'r')

hold on;

xn = [-1 -0.5 0 0.5 1];
yn = [y1(xn)];

ylgr = [];
ynwt = [];
for i=1:length(x)
ylgr = [ylgr lagrange_int(xn,yn,x(i))];
% ynwt = [ynwt newton_int(xn,yn,x(i))];
end
plot(x,ylgr,'b');


% function xv=lagrange_int(xn, yn; x)
%  licznik=1 ;
%  mianownik=1 ;
%  sum=0 ;
%  N=length(xn);
%     for i=1:N
%             for j=1:N
%                 if(j~=i)
%                          mianownik=mianownik*(xn(i)-xn(j));
%                          licznik=licznik*(x-xn(j));
% 
%                 end
%             end
%     
%          sum=sum+yn(i)*licznik/mianownik;
%          licznik=1;
%          mianownik=1;
%  
%     end
%  xv=sum;
%  end
