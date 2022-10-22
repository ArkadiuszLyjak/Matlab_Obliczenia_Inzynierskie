% ------------------------------------
% Æwiczenie 1
% Generowanie sygna³u deterministycznego (dyskretnego, skwantowanego) - 
% sinusoidalnego i ocena jego parametrów 
% ------------------------------------

%% Czyszczenie okna danych, zmiennych i zamykanie okien
clc; clear all; close all;okno=0.1;


% Wygeneruj Np próbek sygna³u sinusoidalnego x(t) o amplitudzie A, 
% czêstotliwoœci fx i liczbie okresów NT. Narysuj ten sygna³.
   
A=input('amplituda=');                  % Parametry sygna³u
fx=input('czêstotliwoœæ sygna³u=');     
NT=input('liczba okresów=');
N=input('liczba próbek=');

znak=input('wariant programu (1/2)=');

if znak==1  % pierwszy wariant programu
    
    Tx=1/fx;            % okres sygna³u
    Tp=(NT/N)*Tx;       % okres próbkownia (mo¿na zapisaæ, ¿e: Tp=dt - krok czasowy)
    t=Tp*(0:N);	        % wektor chwil próbkowania
    
elseif znak==2  % drugi wariant programu
    
    t0=0;                   % poczêtek analizowanego sygna³u (okna prostok¹tnego)
    tk=NT/fx;               % koniec analizowanego sygna³u
    t=linspace(t0,tk,N+1);  % generacja liniowego wektora czasu
    
end

    x=A*sin(2*pi*fx*t);     % sygna³ sin
    % x=A*cos(2*pi*fx*t);   % sygna³ cos
    hold on;
    plot(t,x); grid; title('Sygna³ x(t)'); xlabel('czas [s]'); pause
    plot(t,x,'r*'); pause
    stem(t,x,'g'); pause
    
    % Oblicz wartoœci parametrów sygna³u (wart. œrednia, maksymalna,
    % minimalna, skuteczna, odchylenie standardowe)
   
    x=x(1:N);       % d³ugoœæ wektora wartoœci sygna³u
    t=t(1:N);       % d³ugoœæ wektora czasu
    
    x_sred1=mean(x)		    % œrednia (funkcja)
    x_sred2=sum(x)/N        % œrednia (obliczona)
    pause	
    x_max=max(x)		% maksymalna
    x_min=min(x)		% minimalna
    pause
    x_std1=std(x)						    % odchylenie standardowe (funkcja)
    x_std2=sqrt(sum((x-mean(x)).^2)/(N-1))  % odchylenie standardowe (obliczone)
    pause
    x_skt=sqrt((1/N)*sum(x.^2))		% wartoœæ skuteczna
    pause

    % Oblicz wspó³czynniki zespolonego szeregu Fouriera dla tego sygna³u.
    % Narysuj modu³ i fazê, czêœæ rzeczywist¹ i urojon¹ tych wspó³czynników. 

if znak==1  % pierwszy wariant programu
    
    df=1/(N*Tp);	% czêstotliwoœæ podstawowa f0=df=1/T=1/(N*dt)
    f=df*(0:N);	    % kolejne czêstotliwoœci w szeregu Fouriera
    
elseif znak==2  % drugi wariant programu
    
    Tp=(tk-t0)/N;           % okres próbkowania
    fp=1/Tp;                % czêstotliwoœæ prókowania
    f=linspace(0,fp,N+1);   % generacja liniowego wektora czêstotliwoœci
    
end
    
    f=f(1:N);       % d³ugoœæ wektora czêstotliowœci
    X=fft(x);       % transformata Fouriera
    mod_X_dB=20*log10(abs(X)/max(abs(X)));  % modu³ wspó³czynników widma w [dB]  
    
    clf;
    subplot(211);
    hold on;
    plot(f,abs(X),'r*'); grid; title('Mod(X)'); xlabel('Hz'); pause
    stem(f,abs(X),'b'); pause
    subplot(212);
    hold on;
    plot(f,mod_X_dB,'r*'); grid; title('Mod(X)dB'); xlabel('Hz'); pause
    stem(f,mod_X_dB,'b'); pause
    clf;
    subplot(211);
    hold on;
    plot(f,real(X),'r*'); grid; title('Real(X)'); xlabel('Hz'); pause
    stem(f,real(X),'b'); pause
    subplot(212);
    hold on;
    plot(f,imag(X),'r*'); grid; title('Imag(X)'); xlabel('Hz'); pause
    stem(f,imag(X),'b'); pause
    
    % Narysuj modu³ widma sygna³u po przeskalowaniu dla czêstotliwoœci <0,df*N/2>.
    
    clf;
    hold on;
    plot(f(1:N/2+1),abs(X(1:N/2+1))/(N/2),'r*'); grid; title('Po wyskalowaniu'); xlabel('Hz'); pause   
    stem(f(1:N/2+1),abs(X(1:N/2+1))/(N/2),'b'); pause

    % Zyntetyzuj sygna³ na podstawie wspó³czynników jego szeregu Fouriera
    % i porównaj go z orygina³em
    
    xs=ifft(X);     % odwrotna transformata Fouriera
    clf;
    hold on;
    plot(t,(x-xs)); grid; title('Roznica'); pause		% b³¹d rzêdu 10^(-14)    
    plot(t,(x-xs),'r*'); pause
    
close all;