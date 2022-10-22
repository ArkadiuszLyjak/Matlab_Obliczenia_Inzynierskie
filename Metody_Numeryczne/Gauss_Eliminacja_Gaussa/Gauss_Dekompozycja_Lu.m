% Dekompozycja LU
%------------------------Opis zadania w razie potzreby do kasacji---------------------------------
%3.Wykorzystaæ funkcjê Matlaba do dekompozycji lu - nale¿y koniecznie
%pamiêtaæ o macierzy permutacji i do dalszych obliczeñ zmodyfikowaæ wektor
%prawych stron b (pb = P*b, gdzie P - macierz permutacji zwrócona przez
%funkcjê lu() w Matlabie)
%4.Samodzielnie zaimplementowaæ wsteczne podstawienie ZSTÊPUJ¥CE
%wykorzystuj¹c dolntrójk¹tn¹ macierz L oraz wektor prawych stron (w naszym
%przypadku wektor I), uzyskuj¹c poœrednik wynik y
%5.Samodzielnie zaimplementowaæ wsteczne podstaiwenia WSTÊPUJ¥CE
%wykorzystuj¹c górnotrójk¹tn¹ macierz U oraz uzyskany w poprzednim kroku
%wynik y

close all;
clearvars;
clc;

%--------obwód
format shortG ,format compact

I = 10;   %[A], 
E1 = 5;   %[V],
E2 = 8;   %[V], 
R1 = 5;   %[?],
R2 = 5;   %[?],
R3 = 3;   %[?],
R4 = 7;   %[?],
R5 = 2;   %[?],

% Wyznaczenie postaci macierzowej
% I1 + I4 = I                  | I1 + I4 = I                 | 1   0   0   1    0  ||I1|  |I  |   
% I3 + I4 = I5                 | I3 + I4 - I5 = 0             | 0   0   1   1   -1  ||I2|  |0  |     
% I2 + I3 = I1                 |-I1 + I2 + I3 = 0            |-1   1   1   0    0  ||I3| = |0  |                       
% R1 I1 + R3 I3 - R4 I4 = E1   | R1 I1 + R2 I3 - R4 I4 = E1  |R1   0   R3 -R4   0  ||I4|  |E1 |           
% R2 I2 - R3 I3 - R5 I5 = -E2  | R2 I2 - R3 I3 - R5 I5 = -E2 | 0   R2 -R3  0   -R5 ||I5|  |-E2|  

% Ax = b
A = [1 0 0 1 0;
   0 0 1 1 -1;
   -1 1 1 0 0;
   R1 0 R3 -R4 0;
   0 R2 -R3 0 -R5];
 b = [I 0 0 E1 -E2]';
 
%************   punkt3***************
% Depompozycja LU
  [L,U,P] = lu(A);

% Macierz Pb
  Pb = P*b;
%************   punkt 2***************
Y = Gauss_F_Podstawienia_Wsteczne_Zstep(L,Pb) % funkcja podstawienia_wsteczne_zstep.m


%************   punkt 4 ***************
% podstawieniea wsteczne zstêpuj¹ce
X = Gauss_F_Podstawienia_Wsteczne_Wstep(U,Y) %funkcja podstawienia_wsteczne_wstep.m

