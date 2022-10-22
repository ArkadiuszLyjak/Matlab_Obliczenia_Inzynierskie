%2. Narysowaæ wykres dok³adny funkcji f(x) dla 100, równo odleg³ych
%punktów zawieraj¹cych siê w badanym przedziale.

n = 100;% iloœæ punktów
xmin = -1; % lewy kraniec przedzia³u
xmax = 1;  % prawy kraniec przedzia³u
x = linspace(xmin,xmax,n);
y = 1./(1+25*x.^2);

figure(1)
% clf
plot(x,y,'r')  % wykres dok³adny
xlabel('x');ylabel('f(x)');
title( 'Wykres funkcji y = 1/(1+25*x^2)');