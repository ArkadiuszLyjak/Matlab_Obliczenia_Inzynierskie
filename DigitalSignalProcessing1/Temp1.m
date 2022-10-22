% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arkadiusz £yjak, 170330, Gr. 3 %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all; 
clc; 

Fs = 512;

Fsyg0 = 50;     %Czestotl. sygnalu 1.
Fsyg1 = 100;    %Czestotl. sygnalu 2.
Fsyg2 = 150;    %Czestotl. sygnalu 3.
T = 1/Fsyg0;    %Okres syg. 1.
t = linspace(0, 1/Fsyg0, Fs);

y1 = 1.0*sin(2*pi*Fsyg0*t);
y2 = 0.5*sin(2*pi*Fsyg1*t);
y3 = 0.9*sin(2*pi*Fsyg2*t);
y = y1+y2+y3;
y = y+0.25*(rand(size(y))-0.5);

f = [0 0.48 0.48 1];
mhi = [0 0 1 1];
bhi = fir2(34,f,mhi);
freqz(bhi,1)

outhi = filter(bhi,1,y);
t = (0:length(y)-1)/Fs;
fig1 = figure;
subplot(2,1,1)
plot(t,y);
title('Original Signal')
ylim([-1.2 1.2])
subplot(2,1,2)
plot(t,outhi)
title('Higpass Filtered Signal')
xlabel('Time (s)')
ylim([-1.2 1.2])

fig2 = figure;
mlo = [1 1 0 0];
blo = fir2(34,f,mlo);
outlo = filter(blo,1,y);
subplot(2,1,1)
plot(t,y)
title('Original Signal')

subplot(2,1,2)
plot(t,outlo)
title('Lowpass Filtered Signal')
xlabel('Time (s)')
ylim([-1.2 1.2])