%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arkadiusz £yjak, 170330, Gr. 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clearvars;
clc;

okno = 0.1;

fs = 1000;
dt = 1/fs;
n = okno/dt;
t = 0:dt:okno;
syg_we = 10+100*cos(2*pi*50*t)+ ...
             80*cos(2*pi*150*t+pi)+ ...
             50*cos(2*pi*250*t)+...
             40*cos(2*pi*430*t+pi/2);
y1 = syg_we; 

subplot(2,1,1); 
stg = plot(t,y1);  grid on;
set(stg, 'LineWidth', 2);
ylabel('y1(t)'), xlabel('t'); 
title('postac czasowa sygnalu');
yf1 = fft(y1);
Freq = (0:n);
subplot(2,1,2);
bar(Freq,yf1); grid; 
ylabel('amplituda'), xlabel('k'); 
title('postac czestotliwosciowa');