%%
close all; 
clear; 
clc; 
%%
% Czestotliwosc musi byc podana jako znormalizowana, czyli
% podajemy od 0 do 1*2/fp.
fp = 512;
t = linspace(-pi,pi,100);
rng default  %initialize random number generator
x = sin(t) + 0.25*rand(size(t));
plot(x);
%%
% Wykorzystanie metody okien
% B = fir1(100, 100 * 2/fp);
% freqz(B, 1, 512, 512)
% B = fir1(500, [50*2/fp 200*2/fp], 'DC-0');
% freqz(B, 1, 512, 512)
%%
% Chcemy miec porzadana charakterystyke czestotliwosciowa
load chirp
y = y + 0.25*(rand(size(y))-0.5);
F = [0 50*2/fp 51*2/fp 199*2/fp 200*2/fp 256*2/fp];
A = [0 0 1 1 0 0];
B = fir2(20, F, A);
fig2 = figure;
freqz(B, 1, 512, 512)
[h p] = freqz(B, 1);
fig3 = figure;
plot((p/pi)*256, abs(h));
hold on
plot(F*256, A);
y = filter(B, 1, x);
% fig4 = figure;
% plot(y);
% Inne formy projektowania np. FIRLS czy FIRPM.
