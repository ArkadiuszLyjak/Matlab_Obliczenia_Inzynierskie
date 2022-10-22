%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arkadiusz £yjak, 170330, Gr. 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clearvars;
clc; 

% Zaprojektowac filtr, aby usunac zbedne czestotliwosci.

[Y, Fs] = audioread('glos.wav');
% [Y, Fs] = audioread('bebny2_high.wav');
% [Y, Fs] = audioread('bebny2_low.wav');

figure;
[S,F,T,P] = spectrogram(Y,256,200,256,Fs);
surf(T,F,10*log10(P),'edgecolor', 'none');
axis tight;
view(0,90);
shading interp;
xlabel('Time (Seconds)'); ylabel('Hz');
% soundsc(Y,Fs);

% Moje:

F = [0 50*2/Fs 51*2/Fs 199*2/Fs 200*2/Fs 1];
% A = [0 0 1 1 0 0];
A = [1 1 0 0 1 1];
B = fir2(200, F, A);
figure; 
freqz(B,1,Fs,Fs);
title('FIR2');

% Filtr butterworth - high.

[b, a] = butter(12,120*2/Fs,'high');
figure; 
freqz(b,a,Fs,Fs);
title('BUTTER');
Y2 = filter(b, a, Y);
figure; 
plot(Y2);
title('Sygnal przefiltrowany:');