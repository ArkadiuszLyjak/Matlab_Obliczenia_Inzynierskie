% Ilustracja zjawiska aliasingu. Poprawne rezultaty amalizy 
% otrzymamy dla czestotliwosci sygnalu f mniejszej od 50 Hz
% tj. czêstotliwosci probkowania Fs/2

clear;
clc;
close all;

Fs=100;
T=1/Fs;
t=0:T:(1-T);

for f=1:99,
 
 %f=9*f;
 y=sin(2*pi*f*t);
 plot(y,'-o');
 grid on;
 xlabel('Probki');
 ylabel('Amplituda');
 title(num2str(f));
 pause(0.4);

end