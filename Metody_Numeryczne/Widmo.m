%% Czyszczenie okna danych, zmiennych i zamykanie okien
clc; clear all; close all;okno=0.1;


%Parametry generowanego sygna³u
fsyg=50; %czêstotliwoœæ sygna³u
A=4;     %amplituda sygna³u
sk=2;    %sk³adowa sta³a

Tsyg=1/fsyg; %okres sygna³u generowanego
tk=10*Tsyg; %czas analizy - liczba okresów * Tsyg
            %ca³kowita liczba okresów - analiza synchroniczna
            %nieca³kowita liczba okresów - analiza asynchroniczna

Fs=1000; %czêstotliwoœæ próbkowania
Ts=1/Fs; %okres próbkowania
t=0:Ts:(tk-Ts); %wektor czasu liczony od 0 do tk
                %jeden okres próbkowania Ts jest odjêty, ¿eby otrzymaæ
                %analizê synchroniczn¹


%sygna³y generowane, dla których dalej jest liczone widmo
%nale¿y odkomentowaæ jeden

y=A*sin(2*pi*fsyg*t)+sk;
%y=A*sin(2*pi*fsyg*t)+sin(2*pi*(fsyg+4)*t);
%y=A*square(2*pi*fsyg*t);
%y=A*sawtooth(2*pi*fsyg*t);

%rysowanie sygna³u y w funkcji czasu
figure(1)
subplot(211);
plot(t,y,'-o');
grid on;
xlabel('Czas')
ylabel('Amplituda')
title('Sygnal')

%zastosowanie okna czasowego, boxcar to okno prostok¹tne
%nale¿y odkomentowaæ jedeno wybrane okno
n=length(y);
%win=boxcar(n);
win=hamming(n);
%win=blackman(n);

y=y.*win'; %zastosowanie okna

%rysowanie kszta³tu okna i sygna³u y wyciêtego oknem w funkcji czasu
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

%obliczenie widma amplitudowego sygna³u y
wid=abs(fft(y));

%przeskalowanie amplitud pr¹¿ków widma
N=length(wid);
wid(1)=wid(1)/N;
wid(2:end)=wid(2:end)./(N/2);

%policzenie rozdzielczoœci widma - odleg³oœci pomiêdzy dwoma s¹siednimi
%punktami na osi czêstotliwoœci
df=Fs/N;

%przeskalowanie osi czêstotliwoœci widma
f=0:df:(Fs-df);

%rysowanie widma amplitudowego sygna³u y w funkcji czêstotliwoœci
figure(1)
subplot(212)
stem(f,wid,'b');
grid on
xlabel('Czestotliwosc')
ylabel('Amplituda')
title('Widmo')











