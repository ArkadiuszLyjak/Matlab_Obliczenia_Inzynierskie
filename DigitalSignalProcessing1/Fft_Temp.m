close all;
clearvars;
clc; 

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector

Fsyg0 = 50;         % Czestotliwosc pierwszego sygnalu.
Fsyg1 = 100;        % Czestotliwosc drugiego sygnalu.
Fsyg2 = 150;        % Czestotliwosc trzeciego sygnalu.
y0 = 1.0*sin(2*pi*Fsyg0*t);
y1 = 2.0*sin(2*pi*Fsyg1*t);
y2 = 3.0*sin(2*pi*Fsyg2*t);
y = y0+y1+y2;

% S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
% X = S + 2*randn(size(t));

plot(1000*t(1:50),y(1:50))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')
Y = fft(y);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')