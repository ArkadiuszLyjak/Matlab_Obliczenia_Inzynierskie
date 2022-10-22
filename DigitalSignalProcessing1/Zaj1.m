% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arkadiusz £yjak, 170330, Gr. 3 %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all; 
clc; 

% Dane zadania:
A = 2; % Amplituda
F = 5;
fi = 0;
s = 1;
Fs = 512;
Ts = 1 / Fs;
t = 0 : Ts : (1 - Ts);
y1 = A * sin(2*pi*t*F) + s;
y2 = 1 * sin(2 * pi / 2 * t * F) + 0;


% Rysowanie wykresów:
% x = -pi:0.01:pi;
fig7 = figure;
plot(t, y1), hold
plot(t, y2), grid on
    
fig2 = figure;
subplot(2, 1, 1);
plot(t, y1), grid on
subplot(2, 1, 2); 
plot(t, y2), grid on