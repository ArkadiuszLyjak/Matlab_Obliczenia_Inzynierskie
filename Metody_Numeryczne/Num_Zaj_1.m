%% Czyszczenie okna danych, zmiennych i zamykanie okien
clc; clear all; close all;okno=0.1;

fs = 1000;
Ts = 1 / fs;
L = 2000;
t = 0:Ts:(L-1)*Ts;
A = 1;
x = zeros(1, L);
% x(100:119) = A;

for k = 1:100
    x(k) = k;
end

% for k = 1:100
%     x(k) = k;
% end

figure('rend', 'painters', 'pos', [100 100 800 800])
subplot(3,1,1);
plot(t, x);
title('Dziedzina czasu');
xlabel('t[s]');
ylabel('x(t)');
Y = fft(x);
display(Y(1:10));
P_all = abs(2*Y/L);
P_half = P_all(1:L/2+1);
f = 0:fs/L:fs/2;

subplot(3,1,2);
plot(f, P_half);
title('Dziedzina czestotliwosci');
xlabel('f[Hz]');
ylabel('H[f]');

l_ifft = 300;
Y(l_ifft+1:L) = 0;
x_r = 2*ifft(Y);

subplot(3,1,3);
plot(t,x_r);
title('Zrekonstruowany sygnal');
xlabel('t[s]');
ylabel('x[t]');

display(Y(1:10));
% pause(1);
% close all 