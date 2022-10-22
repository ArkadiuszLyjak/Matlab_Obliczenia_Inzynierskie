%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arkadiusz £yjak, 170330, Gr. 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clearvars;
clc; 

wykresy = 1;
FFT_zaszumione = 1;
FFT_sygnal = 1;

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal 1.5 sek
t = (0:L-1)*T;        % Time vector
S1 = 0.3*sin(2*pi*50*t);
S2 = 0.5*sin(2*pi*100*t);
S3 = 0.7*sin(2*pi*150*t);
S = S1+S2+S3;    
X = S;
Xszum = X + 2*randn(size(t));

if wykresy == 1
    
    figure;
    subplot(3,1,1)
    plot(1000*t(1:100),S1(1:100))
    title('S1 = 0.3*sin(2*pi*50*t)')
    xlabel('t (milliseconds)')
    ylabel('X(t)')

    subplot(3,1,2)
    plot(1000*t(1:100),X(1:100))
    title('S = S1+S2+S3')
    xlabel('t (milliseconds)')
    ylabel('X(t)')

    subplot(3,1,3)
    plot(1000*t(1:100),Xszum(1:100))
    title('S1+S2+S3+2*randn(size(t)')
    xlabel('t (milliseconds)')
    ylabel('X(t)')
    
end

if FFT_sygnal == 1
    
    Y = fft(X);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;

    figure;
    plot(f,P1);
    title('Single-Sided Amplitude Spectrum of X(t)')
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
    
end

if FFT_zaszumione == 1
    
    Y = fft(Xszum);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;

    figure;
    plot(f,P1) 
    title('Single-Sided Amplitude Spectrum of X(t)')
    xlabel('f (Hz)')
    ylabel('|P1(f)|')

end