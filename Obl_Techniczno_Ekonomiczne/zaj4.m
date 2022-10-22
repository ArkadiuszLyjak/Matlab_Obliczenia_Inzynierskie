clc;
clear; 
close all;

Z10 = 1 - 2i;
Z12 = 0.5 + i;
Z13 = 2 + 4i;
Z34 = 1.5 + 2i;
Z30 = 0.5 - 3i;
Z40 = 2 - 3i;

Y10 = Z10^-1;
Y12 = Z12^-1;
Y13 = Z13^-1;
Y34 = Z34^-1;
Y30 = Z30^-1;
Y40 = Z40^-1;

Y11 = Y10 + Y12 + Y13;
Y22 = Y12;
Y33 = Y13 + Y34 + Y30;
Y44 = Y34 + Y40;

Y = [Y11, -Y12, -Y13, 0;
    -Y12, Y22, 0, 0;
    -Y13, 0, Y33, -Y34;
    0, 0, -Y34, Y44];

G = diag([Y10, Y12, Y13, Y30, Y34, Y40]);

K = [    1, 0, 0, 1, 0, 1; %wêze³ 0
        -1,-1,-1, 0, 0, 0; %wêze³ 1
         0, 1, 0, 0, 0, 0; %wêze³ 2
         0, 0, 1,-1,-1, 0; %wêze³ 3
         0, 0, 0, 0, 1,-1]; %wêze³ 4
%Ga³¹Ÿ:[10,12,13,30,34,40]

Yo = K*G*K';
% Teraz z Yo usuwamy pierwszy wiersz
% i pierwsz¹ kolumnê, ¿eby otrzymaæ Yk

Yo(1,:) = []; % usuwamy wartoœci wszystkich kolumn w pierwszym wierszu 
Yo(:,1) = []; % usuwamy wartoœci wszystkich wieszy w pierwszej kolumnie
Yk=Yo;

% Tworzymy macierz danych pocz¹tkowych
%     Wpocz Wkonc r    x
Dane = [ 1    0   1   -2
         1    2  0.5   1
         1    3   2    4
         3    0  0.5  -3
         3    4  1.5   2
         4    0   2   -3];

WP = Dane(:,1);
WK = Dane(:,2);
r = Dane(:,3);

x = Dane(:,4);
z = r + 1i*x;
y = 1./z;
     
liczba_wezlow = max(max(WP), max(WK));
liczba_galezi = length(WP);
Ya = zeros(liczba_wezlow,liczba_wezlow);

for i=1:liczba_wezlow
    for j=1:liczba_galezi
        if (WP(j)== i||WK(j)== i)
            Ya(i,i) = Ya(i,i)+y(j);
        end
    end
end

for i=1:liczba_galezi
    if (WP(1)~= 0 && WK(i)~= 0)
         Ya(WP(i),WK(i)) = -y(i);
         Ya(WK(i),WP(i)) = -y(i);
    end
end

Delata = Y - Ya;
