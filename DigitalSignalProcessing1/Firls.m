%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arkadiusz £yjak, 170330, Gr. 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clearvars;
clc;  

Fsyg0 = 50;         % Czestotliwosc pierwszego sygnalu.
Fsyg1 = 100;        % Czestotliwosc drugiego sygnalu.
Fsyg2 = 150;        % Czestotliwosc trzeciego sygnalu.
T0 = 1/Fsyg0;       % Obliczenie okresu przebiegu.
T1 = 1/Fsyg1;       % Obliczenie okresu przebiegu.
T2 = 1/Fsyg2;       % Obliczenie okresu przebiegu.

% t = 0:T:1-T;      % Wektor czasu.
t = 0:pi/100:(1/2)*pi;

% Sygnal zlozony z trzech przebiegow sinusoidalnych.

y0 = 1.5 *  sin(2*pi*Fsyg0*t);
y1 = 0.8 *  sin(2*pi*Fsyg1*t);
y2 = 1.1 *  sin(2*pi*Fsyg2*t);
y = y0 + y1 + y2;

fp = 512;   % Czestotliwosc probkowania  

% Narysowanie badanego przebiegu.

h_fig = plot(t(1:50), y0(1:50), '--r', ...
            t(1:50), y1(1:50),':g', ...
            t(1:50), y2(1:50), 'b'); grid
title('y = y0 + y1 + y2')
legend('y0','y1', 'y2')
xlabel('0 < x < (1/2)*pi') % x-axis label
ylabel('Przebieg sygnalu zlozonego.') % y-axis label
set(h_fig, 'LineWidth',2);

F = [0 50*2/fp 51*2/fp 149*2/fp 150*2/fp 256*2/fp];
A = [0 0 1 1 0 0];

% 1.Wykorzystanie funkcji FIR2 w filtrze.

B = fir2(200, F, A);
[h_fir2, p_fir2] = freqz(B,1,500);
subplot(4,1,1)
plot((p_fir2/pi), abs(h_fir2),'--','LineWidth', 2);
hold on;
plot(F,A,'r','LineWidth',2)
xlabel('Czestotliwosc unormowana');
ylabel('Amplituda');
legend('Charakt. filtru FIR2','Charakt. zalozona:')

% 2.Wykorzystanie funkcji FIRLS w filtrze.

B = firls(200, F, A);
[h_firls, p_firls] = freqz(B,1);
subplot(4,1,2)
plot((p_firls/pi),abs(h_firls),'--');
hold on;
plot(F,A,'r','LineWidth',2);
xlabel('Czestotliwosc unormowana');
ylabel('Amplituda');
legend('Charakt. filtru FIRLS','Charakt. zalozona:');

% 3.Wykorzystanie funkcji FIRPM w filtrze.

B = firpm(200, F, A);
[h_firpm, p_firpm] = freqz(B,1);
subplot(4,1,3)
plot((p_firpm/pi),abs(h_firpm));
hold on;
plot(F,A,'r','LineWidth',2)
xlabel('Czestotliwosc unormowana');
ylabel('Amplituda');
legend('Charakt. filtru FIRPM','Charakt. zalozona:');

% 4. Wykorzystanie funkcji yulewalk.

[l_y, m_y] = yulewalk(10,F,A);
[h_y, p_y] = freqz(l_y, m_y,200);
subplot(4,1,4)
plot(p_y/pi,abs(h_y),'-',F,A,'-r','LineWidth',2);
xlabel('Czestotliwosc unormowana');
ylabel('Amplituda');
legend('Charakt. filtru zapr. met. YuleWalk','Charakt. zalozona:');
title('Filtr YuleWalkera');

% 5. Sprawdzenie filtracji sygnalu.

figure;
y_filtered = filter(h_y,1,y);
subplot(2,1,1)
plot(t,y_filtered);
subplot(2,1,2)
plot(t,y);



