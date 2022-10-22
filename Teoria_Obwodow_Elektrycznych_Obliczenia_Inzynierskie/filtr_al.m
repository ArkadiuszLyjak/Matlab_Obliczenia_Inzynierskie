clc; 
clearvars; 
close all;

% Dane ze strony http://sim.okawa-denshi.jp 
% fc = 294.27759387763[Hz]
% Q = 0.69337524528154

R1 = 3.9e3;
R2 = 7.5e3;
C1 = 0.1e-6;
C2 = 0.1e-6;

%Licznik transmitancji - macierz

l_0 = [1 0 0];
L = l_0;

%Mianownik transmitancji - macierz

m_0 = 1/(R1*R2*C1*C2);
m_1 = (1/(R2*C1))+(1/(R2*C2));
m_2 = 1;
M = [m_2 m_1 m_0];

% Wykres
% pocz¹tek:krok:koniec
% wartosci mnoze przez 2*pi aby by³y zgodne z NAP-em
% bo w NAP-ie mamy czestotliwosc f
% w MATLAB-ie mamy OMEGA w

w0 = [0.01*2*pi 0.001*2*pi 1*2*pi];
% w = 0.1*2*pi:0.1*2*pi:1000*2*pi; % w = 2*pi*f;
w = 1*2*pi:1*2*pi:1000*2*pi; % w = 2*pi*f;
H = freqs(L,M,w);

% polecenie rysowania wykresu
% semilogx ozncza, ze na osi X bedzie skala LOGARYTMICZNA
% w takiej skali rysuje sie wykresy czestotliwosciowe
% aby z w przejsc na f wystarczy podzieliæ przez 2*pi

figure;

semilogx((w(1:end)/(2*pi)),abs(H(1:end)),'b','DisplayName',...
        'Z MATLABA','LineWidth',2); 
grid;
title('Sallen-Key High-pass Filter', 'FontSize',12, 'FontWeight', ...
        'bold','Color','b')
xlabel('f [Hz]','FontSize', 12, 'FontWeight','bold','Color','b'); 
ylabel('Amplituda','FontSize', 12, 'FontWeight','bold','Color','b');
