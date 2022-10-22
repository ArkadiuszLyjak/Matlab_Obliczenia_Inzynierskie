clc; 
clearvars; 
close all;

% za��my, �e program obliczaj�cy filtr w MATLAB-ie mia� nazw� filtr_al.m
% piszemy jego nazw� aby go uruchomi�

filtr_al_nst

% Pamietajmy aby przejsc na dysk F: i sw�j katalog w MATLAB-ie
% Na tym samym dysku i katalogu trzymamy plik w NAP-ie i tam bedzie plik 
% wynikowy PCNAP.mat
% A - uruchomic program numer 3 FILTR w MATLAB-ie
% ---- pjawi si� wykres, kt�rego nie zamykamy
% B - pobieramy plik z dysku do MATLABA

load('PCNAP.MAT');

% piszemy polecenie po kt�rym ka�de polecenie narysowania wykresu b�dzie w 
% tym samym okienku

hold on

% polecenie narysowania wykresu z MATLAB-a (semilogx bo skala w osi X musi 
% by� logarytmiczna)

% semilogx(freq(10:205), v4_ma(10:205), '--red', 'DisplayName', 'NAP', ...
%         'LineWidth',2);
% semilogx(freq(10:end), v4_ma(10:end),'--red','DisplayName',...
%     'Z NAP-a','LineWidth',4);

plot(time,v4,'--red','LineWidth',2,'DisplayName','Z NAPA');