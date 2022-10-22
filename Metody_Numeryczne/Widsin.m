% ------------------------------------
% �wiczenie 1
% Generowanie sygna�u deterministycznego (dyskretnego, skwantowanego) - 
% sinusoidalnego i ocena jego parametr�w 
% ------------------------------------

%% Czyszczenie okna danych, zmiennych i zamykanie okien
clc; clear all; close all;okno=0.1;


% Wygeneruj Np pr�bek sygna�u sinusoidalnego x(t) o amplitudzie A, 
% cz�stotliwo�ci fx i liczbie okres�w NT. Narysuj ten sygna�.
   
A=input('amplituda=');                  % Parametry sygna�u
fx=input('cz�stotliwo�� sygna�u=');     
NT=input('liczba okres�w=');
N=input('liczba pr�bek=');

znak=input('wariant programu (1/2)=');

if znak==1  % pierwszy wariant programu
    
    Tx=1/fx;            % okres sygna�u
    Tp=(NT/N)*Tx;       % okres pr�bkownia (mo�na zapisa�, �e: Tp=dt - krok czasowy)
    t=Tp*(0:N);	        % wektor chwil pr�bkowania
    
elseif znak==2  % drugi wariant programu
    
    t0=0;                   % pocz�tek analizowanego sygna�u (okna prostok�tnego)
    tk=NT/fx;               % koniec analizowanego sygna�u
    t=linspace(t0,tk,N+1);  % generacja liniowego wektora czasu
    
end

    x=A*sin(2*pi*fx*t);     % sygna� sin
    % x=A*cos(2*pi*fx*t);   % sygna� cos
    hold on;
    plot(t,x); grid; title('Sygna� x(t)'); xlabel('czas [s]'); pause
    plot(t,x,'r*'); pause
    stem(t,x,'g'); pause
    
    % Oblicz warto�ci parametr�w sygna�u (wart. �rednia, maksymalna,
    % minimalna, skuteczna, odchylenie standardowe)
   
    x=x(1:N);       % d�ugo�� wektora warto�ci sygna�u
    t=t(1:N);       % d�ugo�� wektora czasu
    
    x_sred1=mean(x)		    % �rednia (funkcja)
    x_sred2=sum(x)/N        % �rednia (obliczona)
    pause	
    x_max=max(x)		% maksymalna
    x_min=min(x)		% minimalna
    pause
    x_std1=std(x)						    % odchylenie standardowe (funkcja)
    x_std2=sqrt(sum((x-mean(x)).^2)/(N-1))  % odchylenie standardowe (obliczone)
    pause
    x_skt=sqrt((1/N)*sum(x.^2))		% warto�� skuteczna
    pause

    % Oblicz wsp�czynniki zespolonego szeregu Fouriera dla tego sygna�u.
    % Narysuj modu� i faz�, cz�� rzeczywist� i urojon� tych wsp�czynnik�w. 

if znak==1  % pierwszy wariant programu
    
    df=1/(N*Tp);	% cz�stotliwo�� podstawowa f0=df=1/T=1/(N*dt)
    f=df*(0:N);	    % kolejne cz�stotliwo�ci w szeregu Fouriera
    
elseif znak==2  % drugi wariant programu
    
    Tp=(tk-t0)/N;           % okres pr�bkowania
    fp=1/Tp;                % cz�stotliwo�� pr�kowania
    f=linspace(0,fp,N+1);   % generacja liniowego wektora cz�stotliwo�ci
    
end
    
    f=f(1:N);       % d�ugo�� wektora cz�stotliow�ci
    X=fft(x);       % transformata Fouriera
    mod_X_dB=20*log10(abs(X)/max(abs(X)));  % modu� wsp�czynnik�w widma w [dB]  
    
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
    
    % Narysuj modu� widma sygna�u po przeskalowaniu dla cz�stotliwo�ci <0,df*N/2>.
    
    clf;
    hold on;
    plot(f(1:N/2+1),abs(X(1:N/2+1))/(N/2),'r*'); grid; title('Po wyskalowaniu'); xlabel('Hz'); pause   
    stem(f(1:N/2+1),abs(X(1:N/2+1))/(N/2),'b'); pause

    % Zyntetyzuj sygna� na podstawie wsp�czynnik�w jego szeregu Fouriera
    % i por�wnaj go z orygina�em
    
    xs=ifft(X);     % odwrotna transformata Fouriera
    clf;
    hold on;
    plot(t,(x-xs)); grid; title('Roznica'); pause		% b��d rz�du 10^(-14)    
    plot(t,(x-xs),'r*'); pause
    
close all;