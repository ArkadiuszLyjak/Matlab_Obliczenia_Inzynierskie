%2. Narysowa� wykres dok�adny funkcji f(x) dla 100, r�wno odleg�ych
%punkt�w zawieraj�cych si� w badanym przedziale.

n = 100;% ilo�� punkt�w
xmin = -1; % lewy kraniec przedzia�u
xmax = 1;  % prawy kraniec przedzia�u
x = linspace(xmin,xmax,n);
y = 1./(1+25*x.^2);

figure(1)
% clf
plot(x,y,'r')  % wykres dok�adny
xlabel('x');ylabel('f(x)');
title( 'Wykres funkcji y = 1/(1+25*x^2)');