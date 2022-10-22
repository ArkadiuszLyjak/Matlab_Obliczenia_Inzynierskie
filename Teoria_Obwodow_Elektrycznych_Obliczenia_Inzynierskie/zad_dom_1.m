clc; 
clearvars; 
close all;

disp('#####################################################');
disp('### Zadanie domowe - Arkadiusz £yjak GR.3 170330 ####');
disp('########### Metoda potencja³ów wêz³owych. ###########');
disp('#####################################################');
disp(' ');

f = 50; % zdefiniowalismy czestotliwosc
w = 2 * pi * f; % wyliczylismy pulsacjê

% Wartosci symboliczne elem. obwodu

J1 = 1 - 1 * 1i; 
J2 = 2 + 5 * 1i;
J3 = 4 - 5 * 1i;
J4 = 4 + 5 * 1i;
R12 = 1e2; % 100
R50 = 1e2; % 100
R10 = 1e2; % 100
R04 = 1e2; % 100
R03 = 1e2; % 100
R34 = 1e2; % 100
R20 = 1e2; % 100
R30 = R03;
C12 = 1e-4; % 0.0001
C03 = 1e-5; % 0.00001
C34 = 1e-4; % 0.0001
C20 = 1e-6; % 0.000001
L12 = 1e-6;
L50 = 1e-3;
L10 = 1e-3;
L04 = 1e-7;
L03 = 1e-4;
L30 = L03;

% Impedancje galeziowe:

Z12 = R12 + 1i * w * L12;
Z10 = R10 + 1i * w * L10;
Z20 = R20 + 1 / (1i * w * C20);
Z30 = R30 + 1i * w * L30 + 1 / (1i * w * C03);
Z34 = R34 + 1 / (1i * w * C34);
Z40 = R04 + 1i * w * L04;
Z50 = R50 + 1i * w * L50;

% Macierz admitancji - elementy symboliczne:

Y11 = 1 / Z10 + 1 / Z12;
Y22 = 1 / Z12 + 1 / Z20;
Y33 = 1 / Z30 + 1 / Z34;
Y44 = 1 / Z34 + 1 / Z40;
Y55 = 1 / Z50;
Y12 = - 1 / Z12;
Y34 = - 1 / Z34;
Y50 = - 1 / Z50;
Y10 = - 1 / Z10;

% Macierz admitancyjna:

Y = [   Y11 Y12 0 0 0
        Y12 Y22 0 0 0
        0 0 Y33 Y34 0
        0 0 Y34 Y44 0
        0 0 0 0 Y55];
    
% Y_disp = num2cell(Y)

% Wektor wymuszen pradowych:

% Jzr = [J11 J22 J33 J44 J55];
Jzr = [ J1 
        J2
        -J2
        -J3
        -J4-J1];
    
% Jzr_disp = num2cell(Y);
    

% Rozwiaz uklad równañ J = V * Y:
% disp('### Wartoœci potencja³ów w wêz³ach obwodu: ####');

V = Y \ Jzr;
V1 = V(1);
V2 = V(2);
V3 = V(3);
V4 = V(4);
V5 = V(5);

% Bilans pr¹dów dla wêz³a 1:
% disp('############### Bilans pr¹dów: ################');

I1 = (V1 - V2) / Z12;
I2 = V1 / Z10;
I3 = V2 / Z20;
I4 = -V3 / Z30;
I7 = V4 / Z40;
I5 = -V5 / Z50;
I6 = (V3 - V4) / Z34;

% Wszystko ponizej 1e-8 to dla nas ZERO
% w programach komp. czyste ZERO zdarza siê rzadko.

BPW1 = J1 - I1 - I2;
BPW2 = I1 - I3 + J2;
BPW3 = -J2 + I4 - I6;
BPW4 = -J3 - I7 + I6;
BPW5 = -J1 +I5 - J4;

X1 = ['BPW1', ' = ', num2str(J1 - I1 - I2)];   disp(X1)
X2 = ['BPW2', ' = ', num2str(I1 - I3 + J2)];   disp(X2)
X3 = ['BPW3', ' = ', num2str(-J2 + I4 - I6)];  disp(X3)
X4 = ['BPW4', ' = ', num2str(-J3 - I7 + I6)];  disp(X4)
X5 = ['BPW5', ' = ', num2str(-J1 +I5 - J4)];   disp(X5)

%% Bilans energetyczny na ga³eziach
%% suma mocy wytwarzanej + suma mocy traconej
%% ma dac zera
%% MOC = U * Isprzezone => u * conj(I)
MOC_ZR = (V5 - V1) * conj(J1); % nap na zr1 * J1sprz
% strzalka nap 0, og 1
%% zmienna MC_ZR bedzie zawierala sumê mocy zrodel
%% MOC_ZR zawiera moc zródla 1, dodaje mo zr 2
MOC_ZR = MOC_ZR + (V3 - V2) * conj(J2);
% do sumy mocy zr 1 i 2 dodajê moc trzeciego
MOC_ZR = MOC_ZR + V4 * conj(J3);

% disp('############ Moc Ÿróde³ energii: ##############');

MOC_ZR = MOC_ZR + V5 * conj(J4);
X6 = ['MOC_ZR', ' = ', num2str(MOC_ZR)];   disp(X6)
% disp('############ Moce na elementach obw.: #########');

MOC_GAL = (V1 - V2) * conj(I1);
MOC_GAL = MOC_GAL - V5 * conj(I5);
MOC_GAL = MOC_GAL + V4 * conj(I7);
MOC_GAL = MOC_GAL + V2 * conj(I3);
MOC_GAL = MOC_GAL + (V3 - V4) * conj(I6);
MOC_GAL = MOC_GAL + V1 * conj(I2);
MOC_GAL = MOC_GAL - V3 * conj(I4);
X7 = ['MOC_GAL', ' = ', num2str(MOC_GAL)];   disp(X7)

%% MOC_GAL zawiera sumê mocy wszystkich ga³ezi

BILANS_MOCY = MOC_ZR + MOC_GAL;
X8 = ['BILANS_MOCY', ' = ', num2str(BILANS_MOCY)];   disp(X8)
