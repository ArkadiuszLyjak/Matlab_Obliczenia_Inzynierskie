%% Zasady pracy z MATLAB-em
%% 1. ZAWSZE zmieniamy katalog roboczy na dysk F i swoj podkatalog
%% 1a. Do tego s�uzy �rodkowa ikona po lewej od nazwy katalogu
% Komentarze w MATLAB-ie po znaku % do ko�ca linii
% Piszemy ZAWSZE skrypt a nie piszemy w oknie COMMAND
%% 2. W tym celu naciskamy NewScript i piszemy w edytorze
%% MPW => I = V * Y
% Musimy zdefiniowa� najpierw macierz Y
% Jezeli mamy sam zrodle pr�dowe i el. liniowe
% to macierz bedzie symetryczna Yij == Yji
% Wtedy prosze o wyliczenie tylko g�rnej polowki mac
% Y = [ Y11 Y12 Y13
% Y12 Y22 Y23
% Y13 Y23 Y33 ] 
clc; clear; close all;
format shortG ,format compact

f = 50; % zdefiniowalismy czestotliwosc
w = 2 * pi * f; % wyliczylismy pulsacj�

J1 = 1 - j;
J2 = 2 + 5 * j;
J3 = 4 - 5 * j;
R1 = 1e3; % 1000
R2 = 1e4; % 10000
R3 = 1e3; % 1000
C2 = 1e-4; % 0.0001
C4 = 1e-5; % 0.00001
L1 = 1e-4;
L3 = 1e-3;

% Przydadz� si� impendacje ga��ziowe
Z10 = R1 + j * w * L1;
Z02 = 1 / (j * w * C4);

%% to samo co -j / (w * C4)
%% natomiast -j / w * C4 to b��d bo to b�dzie:
%% (-j / w) * C4 => NIE O TO CHODZILO
%% Najwiecej b�ed�w jest przez BRAK NAWIASOW
% Z23 = R2 - j / (w * C2);
Z23 = R2 + 1 / (j * w * C2);
Z03 = R3 + j * w * L3;

%% Regu�y tworzenia macierzy Y
%% Yii to suma Y-k�w �acz�cych si� bezposrednio z 
%% w�zlem i-tym Z PLUSAMI

%%Zrodla traktujemy jako przerwy przy budowie Y
Y11 = 1/Z10;
Y22 = 1/Z02 + 1/Z23;

%% Matlab rozr�znia wielko�� liter Z02 
%% to co innego jak z02 !!!!!
Y33 = 1/Z23 + 1/Z03;

%% Yij to suma Y-k�w Z MINUSAMI ga��zi ��cz�cych
%% BEZPOSREDNIO w�z�y i z j
Y12 = 0;
Y13 = 0;
Y23 = -1/Z23;

% Zapisujemy macierz Y
Y = [ Y11 Y12 Y13
Y12 Y22 Y23
Y13 Y23 Y33 ];

% definicja pr�d�w �r�d�owych
% jak do w�z�a wchodzi pr�d zrodlowy to PLUS
% jak wychodzi to MINUS jak nic to ZERO
% Numer wiersza w wektorze to nomer w�z�a
Jz = [ J1+J2 % uwaga na spacje w wektorach
-J2-J3
J3];

% ponizsze polecenie oznacza:
% rozwiaz uklad r�wna� J = V * Y
V = Y \ Jz;
v1 = V(1);
v2 = V(2);
v3 = V(3);

% Po nacisnieciu RUN w edytorze (ZIELONA STRZALKA)
% przy pierwszym razie pojawi sie prosba o zapisanie
% pliku. Zapisujemy na F na swoim podkatalogu
%% Nazwa zawsze MAX 8 znak�w
%% Bez PL liter bez spacji, kropek, same litery i cyfry
%% Nie moze zaczyna� sie od CYFRY
% wyczyszczenie echa w oknie command clc

% Sprawdzenie poprawnosci PRAWA KIRCHOFFA
% czyli suma pr�d�w ga��ziowych w w�z�ach 
%% MUSI BYC ZERO
% do pr�d�w ga��ziowych b�dziemy potrzebowali 
% napi�cia na elementach
% jak mamy narysowane napi�cie to 
% U => STRZALKA MINUS OGONEK (napiecia)
U10 = v1 - 0;
I10 = U10 / Z10;

%% Bilans W�z�a 1-wszego
%% pr�d wchodzi PLUS, wychodzi MINUS
BW1 = J1 + J2 - I10

% Wszystko ponizej 1e-8 to dla nas ZERO
% w programach komp czyste ZEO zdarza si� rzadko

U02 = 0 - v2; % strza�ka napiecia wskazuje na 0
% a ogonek na 2
I02 = U02 / Z02;
U23 = v2 - v3; % strzalka 2, ogonek 3
I23 = U23 / Z23;
% Bilans Wezla 2 => suma prad�w w w�zle 2
BW2 = -J2-I23+I02-J3 % do w�zla wchodz� 4 ga��zie

U03 = 0 - v3;
I03 = U03 / Z03;

BW3 = J3 + I03 + I23

%% Bilans energetyczny na ga�eziach
%% suma mocy wytwarzanej + suma mocy traconej
%% ma dac zera
%% MOC = U * Isprzezone => u * conj(I)
MOC_ZR = (0 - v1) * conj(J1); % nap na zr1 * J1sprz
% strzalka nap 0, og 1
%% zmienna MC_ZR bedzie zawierala sum� mocy zrodel
%% MOC_ZR zawiera moc zr�dla 1, dodaje mo zr 2
MOC_ZR = MOC_ZR + (v2-v1) * conj(J2);
% do sumy mocy zr 1 i 2 dodaj� moc trzeciego
MOC_ZR = MOC_ZR + (v2-v3) * conj(J3)
MOC_GAL = U10 * conj(I10);
MOC_GAL = MOC_GAL + U02 * conj(I02);
MOC_GAL = MOC_GAL + U23 * conj(I23);
MOC_GAL = MOC_GAL + U03 * conj(I03)
%% MOC_GAL zawiera sum� mocy wszystkich 4-ech ga�ezi
BILANS_MOCY = MOC_ZR + MOC_GAL