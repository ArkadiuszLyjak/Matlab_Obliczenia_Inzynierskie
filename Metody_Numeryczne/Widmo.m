%% Czyszczenie okna danych, zmiennych i zamykanie okien
clc; clear all; close all;okno=0.1;


%Parametry generowanego sygna�u
fsyg=50; %cz�stotliwo�� sygna�u
A=4;     %amplituda sygna�u
sk=2;    %sk�adowa sta�a

Tsyg=1/fsyg; %okres sygna�u generowanego
tk=10*Tsyg; %czas analizy - liczba okres�w * Tsyg
            %ca�kowita liczba okres�w - analiza synchroniczna
            %nieca�kowita liczba okres�w - analiza asynchroniczna

Fs=1000; %cz�stotliwo�� pr�bkowania
Ts=1/Fs; %okres pr�bkowania
t=0:Ts:(tk-Ts); %wektor czasu liczony od 0 do tk
                %jeden okres pr�bkowania Ts jest odj�ty, �eby otrzyma�
                %analiz� synchroniczn�


%sygna�y generowane, dla kt�rych dalej jest liczone widmo
%nale�y odkomentowa� jeden

y=A*sin(2*pi*fsyg*t)+sk;
%y=A*sin(2*pi*fsyg*t)+sin(2*pi*(fsyg+4)*t);
%y=A*square(2*pi*fsyg*t);
%y=A*sawtooth(2*pi*fsyg*t);

%rysowanie sygna�u y w funkcji czasu
figure(1)
subplot(211);
plot(t,y,'-o');
grid on;
xlabel('Czas')
ylabel('Amplituda')
title('Sygnal')

%zastosowanie okna czasowego, boxcar to okno prostok�tne
%nale�y odkomentowa� jedeno wybrane okno
n=length(y);
%win=boxcar(n);
win=hamming(n);
%win=blackman(n);

y=y.*win'; %zastosowanie okna

%rysowanie kszta�tu okna i sygna�u y wyci�tego oknem w funkcji czasu
figure(2)
subplot(211)
plot(t,win,'-o');
grid on
xlabel('Czas')
ylabel('Amplituda')
title('Zastosowane okno')
subplot(212)
plot(t,y,'-o')
grid on
xlabel('Czas')
ylabel('Amplituda')
title('Sygnal wyciety oknem')

%obliczenie widma amplitudowego sygna�u y
wid=abs(fft(y));

%przeskalowanie amplitud pr��k�w widma
N=length(wid);
wid(1)=wid(1)/N;
wid(2:end)=wid(2:end)./(N/2);

%policzenie rozdzielczo�ci widma - odleg�o�ci pomi�dzy dwoma s�siednimi
%punktami na osi cz�stotliwo�ci
df=Fs/N;

%przeskalowanie osi cz�stotliwo�ci widma
f=0:df:(Fs-df);

%rysowanie widma amplitudowego sygna�u y w funkcji cz�stotliwo�ci
figure(1)
subplot(212)
stem(f,wid,'b');
grid on
xlabel('Czestotliwosc')
ylabel('Amplituda')
title('Widmo')











