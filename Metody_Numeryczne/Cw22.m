%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arkadiusz £yjak, 170330, Gr. 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clearvars;
clc;  

% policzyæ b³êdy bezwzglêdne i wzglêdne dla poszczególnych funkcji
% wyrysowaæ b³êdy (w razie potrzeby zastosowaæ skalê 
% logarytmiczn¹ w osi rzêdnych)

% efekt rungego - oscylacje na krañcach przedzia³u
y = @(x) 1./(1+25*x.^2);

% modu³ x, brak ci¹g³ej pochodnej
y1 = @(x) abs(x);

% nieograniczona pochodna na krañcach przedzia³u
y2 = @(x) sqrt(1-x.^2);

% nieró¿niczkowalna dla x=0
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
