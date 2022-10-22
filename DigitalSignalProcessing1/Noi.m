close all; clear; clc;

przebiegi = 1;
porownanie = 0;

if ((przebiegi == 1) && (porownanie == 0))
    %% Dane zadania:
    Fs=500e3; T=1/Fs;
    Fsyg1 = 20;     okres1 = 1/Fsyg1;
    Fsyg2 = 50;     okres2 = 1/Fsyg2;
    Fsyg3 = 70;     okres3 = 1/Fsyg3;
    Fsyg4 = 100;    okres4 = 1/Fsyg4;

    fsyg = 26000; % dla prostokata!
    w = 2*pi*fsyg;
    t = 0:T:(1-T);
    % t = -pi:0.01:pi;

    %% Generacja sygna³ów:
    y1 = 1.5 *  sin(2 * pi * Fsyg1 * t) + 0;
    y2 = 0.8 *  sin(2 * pi * Fsyg2 * t) + 0;
    y3 = 10 *  sin(2 * pi * Fsyg3 * t) + 0;
    y4 = 1 *    sin(2 * pi * Fsyg4 * t) + 0;
    y5 = y1 + y2 + y3 + y4;
    plot(t, y5);

    elseif ((przebiegi == 0) && (porownanie == 1))
    % Te wartosci sa poprawne.
    % figure;
    [b, a] = butter(8, 30*2/512);
    freqz(b, a, 512, 512);
    pause(1);
    
    % Z tym rzedem filtr bedzie niestabilny.
    [b, a] = butter(100, 30*2/512);
    freqz(b, a, 512, 512);
    pause(1);
    
    % Sprawdzenie stabilnosci filtra.
    isstable(b, a);
    pause(1);
    
    [b0, a0] = cheby2(8, 50, 30*2/512);
    freqz(b0, a0, 512, 512);
    pause(1);
    
    [b1, a1] = ellip(8, 3, 50, 30*2/512);
    freqz(b1, a1, 512, 512);
    pause(1);
    
    [b, a] = butter(8, [30*2/512 50*2/512], 'stop');
    freqz(b, a, 512, 512);
    grpdelay(b, a, 512, 512);

    % Porownanie filtrow.
        if porownanie == 1
            Fs = 512;
            [b a] = butter(100, [30*2/Fs 50*2/Fs]);
            [h p] = freqz(b, a);
            plot((p/pi)*256, abs(h)); hold on

            [b2, a2] = cheby1(8, 50, [30*2/Fs 50*2/Fs]);
            [h, p] = freqz(b2, a2);
            plot((p/pi)*256, abs(h))

            [b2, a2] = cheby2(8, 50, [30*2/Fs 50*2/Fs]);
            [h p] = freqz(b2, a2);
            plot((p/pi)*256, abs(h))

            [b2, a2] = ellip(8, 3, 50, [30*2/Fs 50*2/Fs]);
            [h p] = freqz(b2, a2);
            plot((p/pi)*256, abs(h))

            legend('butterworth', 'chebyschev1', 'chebyschev2', 'elliptic');
        end

end




