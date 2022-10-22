%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arkadiusz £yjak, 170330, Gr. 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clearvars;
clc; 

% Dane do zadania.

Fs = 512;  % Czestotliwosc probkowania.
T = 1/Fs;  % Okres probkowania.
Fsyg = 25;  % Czestotliwosci poszczeg. sygnalow.
Fsyg1 = 50;  
Fsyg2 = 100;       
Ts = 1/Fsyg;       
okres = 1/Fsyg;       
t = 0:T:1-T;      

% Wygenerowany sygnal.

y = 1.0*sin(2*pi*Fsyg*t)+ ...
    0.5*sin(2*pi*Fsyg1*t)+ ...
    0.9*sin(2*pi*Fsyg2*t);  

Wynik = []; 

for i = 1:50  
    szum = 4*randn(1,length(y));           
    ys = y+szum; 
    Wynik = [Wynik; abs(fft(ys))];       
end    

srednia = mean(Wynik);  

plot(y); 
plot(srednia);  

figure;       
N = length(y);  
xwidmo = 0:N-1;       
widmo = abs(fft(y+szum));       
widmo(1) = widmo(1)/N;       
widmo(2:end) = widmo(2:end)./(N/2);   
stem(xwidmo,widmo);  

figure;         
widmo = srednia;       
widmo(1) = widmo(1)/N;  
widmo(2:end) = widmo(2:end)./(N/2);  
stem(xwidmo, widmo);  