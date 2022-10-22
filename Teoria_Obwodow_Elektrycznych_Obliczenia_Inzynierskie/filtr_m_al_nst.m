clc; 
clearvars; 
close all;

% za³ó¿my, ¿e program obliczaj¹cy filtr w MATLAB-ie mia³ nazwê filtr_al.m
% piszemy jego nazwê aby go uruchomiæ

filtr_al_nst

% Pamietajmy aby przejsc na dysk F: i swój katalog w MATLAB-ie
% Na tym samym dysku i katalogu trzymamy plik w NAP-ie i tam bedzie plik 
% wynikowy PCNAP.mat
% A - uruchomic program numer 3 FILTR w MATLAB-ie
% ---- pjawi siê wykres, którego nie zamykamy
% B - pobieramy plik z dysku do MATLABA

load('PCNAP.MAT');

% piszemy polecenie po którym ka¿de polecenie narysowania wykresu bêdzie w 
% tym samym okienku

hold on

% polecenie narysowania wykresu z MATLAB-a (semilogx bo skala w osi X musi 
% byæ logarytmiczna)

% semilogx(freq(10:205), v4_ma(10:205), '--red', 'DisplayName', 'NAP', ...
%         'LineWidth',2);
% semilogx(freq(10:end), v4_ma(10:end),'--red','DisplayName',...
%     'Z NAP-a','LineWidth',4);

plot(time,v4,'--red','LineWidth',2,'DisplayName','Z NAPA');