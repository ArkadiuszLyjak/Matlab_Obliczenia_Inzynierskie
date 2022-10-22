%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arkadiusz £yjak, 170330, Gr. 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clearvars;
clc; 

FFT2 = 1;
analiza_sygn_1 = 1;
analiza_sygn_2 = 1;
analiza_sygn_3 = 1;

% Fs=500e3; 
Fs = 1024;
T=1/Fs;
okno = 1.5;
L = okno*Fs;
fsyg = 50; % dla prostokata!
w = 2*pi*fsyg;
t = 0:T:(1-T);

Fsyg1 = 50;     
Fsyg2 = 100;     
Fsyg3 = 150;    
Fsyg4 = 500;    

% Generacja sygna³ów:

y1 = 1.0*sin(2*pi*Fsyg1*t)+0;
y2 = 2.0*sin(2*pi*Fsyg2*t)+0;
y3 = 3.0*sin(2*pi*Fsyg3*t)+0;
y4 = 4.0*sin(2*pi*Fsyg4*t)+0;
y5 = sin(2*pi*fsyg*t);

wynik = [];

for i = 3 : 2 : 9
    szum = randn(1, length(y5));
    y5 = y5 + (1/i)*sin(2*pi*i*fsyg*t);
    ys = y5 + szum;
    wynik = [wynik; abs(fft(ys))];
end

fig1 = figure;
plot(t(1:end/8),ys(1:end/8)); grid on;
title('ys = y5 + szum', 'FontSize',12, 'FontWeight','bold','Color','b')
xlabel('t[s]', 'FontSize', 12, 'FontWeight','bold','Color','b'); 
ylabel('Amplituda', 'FontSize', 12, 'FontWeight','bold','Color','b'); 

N = length(ys);
xwidmo = 0:N-1;
% widmo = abs(fft(ys, 500000));
widmo = abs(fft(ys, Fs));
widmo(1) = widmo(1)/N; 
widmo(2:end) = widmo(2:end)./(N/2);

fig7 = figure;
% stem(xwidmo(1:250000), widmo(1:250000));
stem(xwidmo(1:(Fs/2)), widmo(1:(Fs/2)));

fig2 = figure;
% semilogy(xwidmo(1:250000), widmo(1:250000));
semilogy(xwidmo(1:(Fs/2)), widmo(1:(Fs/2)));

% Sygnaly poddane analizie FFT.

y6 = sin(w*t)+ ...
    (1/3)*sin(3*w*t)+ ...
    (1/5)*sin(5*w*t)+ ...
    (1/7)*sin(7*w*t)+ ...
    (1/9)*sin(9*w*t);
y_sum = y1+y2+y3+y4+y5;

% FFT2.

if FFT2 == 1

    if analiza_sygn_1 == 1 
        
        yn = fft(ys,1000);
        n = length(yn);
        pyy1 = sqrt(yn.*conj(yn))/n;
        f = 500*(0:500)/500;
        pyy1(2:500) = 2*pyy1(2:500);
        pyy1(502:1000) = [];
        fig8 = figure;
        plot(f,pyy1);
        grid,xlabel('f'),ylabel('Amplitudy harmonicznych')   
        
    end

    if analiza_sygn_1 == 1
        
        figure;
        plot(t(1:100),y6(1:100));
        title('y6 = sin(w*t)+ (1/3)*sin(3*w*t)+ (1/5)*sin(5*w*t)+ ...', ...
        'FontSize',12, 'FontWeight','bold','Color','b');
        xlabel('f', 'FontSize', 12, 'FontWeight','bold','Color','b'); 
        ylabel('Amplituda', 'FontSize', 12, 'FontWeight','bold','Color','b'); 

        yn = fft(y6,1000);
        n = length(yn);
        pyy2 = sqrt(yn.*conj(yn))/n;
        f = 500*(0:500)/500;
        pyy2(2:500) = 2*pyy2(2:500);
        pyy2(502:1000) = [];
        fig9 = figure;
        plot(f,pyy2);
        grid,xlabel('f'),ylabel('Amplitudy harmonicznych')
        
    end

    if analiza_sygn_1 == 1
        
        figure;
        plot(t(1:100),y_sum(1:100));
        title('y_sum = y1+y2+y3+y4+y5', ...
        'FontSize',12, 'FontWeight','bold','Color','b');
        xlabel('f', 'FontSize', 12, 'FontWeight','bold','Color','b'); 
        ylabel('Amplituda', 'FontSize', 12, 'FontWeight','bold','Color','b'); 
        
        yn = fft(y_sum,1000);
        n = length(yn);
        pyy3 = sqrt(yn.*conj(yn))/n;
        f = 500*(0:500)/500;
        pyy3(2:500) = 2*pyy3(2:500);
        pyy3(502:1000) = [];
        fig10 = figure;
        plot(f,pyy3);
        title('y_sum = y1+y2+y3+y4+y5');
        grid,xlabel('f'),ylabel('Amplitudy harmonicznych')
        
    end

end

