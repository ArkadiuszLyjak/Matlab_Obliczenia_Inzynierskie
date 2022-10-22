% ------------------------------------
% Æwiczenie 2
% Generowanie sygna³u deterministycznego sinusoidalnego z³o¿onego
% lub zaszumionego i ocena jego parametrów 
% ------------------------------------

%% Czyszczenie okna danych, zmiennych i zamykanie okien
clc; clear all; close all;okno=0.1;


% Wygeneruj Np próbek sygna³u sinusoidalnego x(t) o amplitudzie A, 
% czêstotliwoœci fx i liczbie okresów NT. Narysuj ten sygna³.
    
A=input('amplituda=');                  % Parametry sygna³u
fx=input('czêstotliwoœæ sygna³u=');     
NT=input('liczba okresów=');
N=input('liczba próbek=');

znak=input('przebieg (1/2/3/4)=');

    t0=0;                   % poczêtek analizowanego sygna³u (okna prostok¹tnego)
    tk=NT/fx;               % koniec analizowanego sygna³u
    t=linspace(t0,tk,N+1);  % generacja liniowego wektora czasu
    Tp=(tk-t0)/N;           % okres próbkowania
    fp=1/Tp;                % czêstotliwoœæ prókowania
    f=linspace(0,fp,N+1);   % generacja liniowego wektora czêstotliwoœci 
    
if znak==1  % sygna³ sinusoidalny przesuniêty
    
    xst=input('sk³adowa sta³a=');  
    n0=input('próbka pocz¹tkowa=');  
    x=xst+A*sin(2*pi*fx*(t+n0*Tp));     % sygna³   

    % Narysuj przebieg sygna³u z zaznaczeniem poszczególnych próbek 
    
    clf;
    hold on;    
    plot(t,x,'b'); grid; title('Sygna³ x(t)'); xlabel('czas [s]'); pause
    plot(t,x,'r*'); pause
    
elseif znak==2  % z³o¿enie sygna³ów sinusoidalnyuch
    
    A1_A2=input('stosunek ampl.syg.x1 do ampl.syg.x2=');
    A1_A3=input('stosunek ampl.syg.x1 do ampl.syg.x3=');
    f2_f1=input('stosunek czêst.syg.x2 do czêst.syg.x1=');
    f3_f1=input('stosunek czêst.syg.x3 do czêst.syg.x1=');
    x1=A*sin(2*pi*fx*t);                    % sygna³ podstawowy
    x2=(A/A1_A2)*sin(2*pi*fx*(f2_f1)*t);    % sygna³ na³o¿ony
    x3=(A/A1_A3)*sin(2*pi*fx*(f3_f1)*t);    % sygna³ na³o¿ony
    x=x1+x2+x3;                             % sygna³ koñcowy
    
    % Narysuj przebieg sygna³u z zaznaczeniem poszczególnych próbek 
    
    clf;
    hold on;    
    plot(t,x,'b'); grid; title('Sygna³ x(t) i jego sk³adowe'); xlabel('czas [s]'); pause
    plot(t,x,'r*'); pause
    plot(t,x1,'g'); 
    plot(t,x2,'c');
    plot(t,x3,'y'); pause
    
elseif znak==3  % sygna³ sinusoidalny zaszumiony
    
    alfa=input('stosunek ampl.syg.x do ampl.szumu s=');
    xp=A*sin(2*pi*fx*t);                    % sygna³ podstawowy
    symbol=input('charakter szumu (3.1/3.2)=');
    if symbol==3.1  
        s=(A/alfa)*(2*rand(size(xp))-1.0);  % szum "równomierny"
    elseif symbol==3.2
        s=(A/alfa)*randn(size(xp));         % szum "Gaussowski"
    end
    x=xp+s;
    clf;
    hold on;    
    plot(t,x,'b'); grid; title('Sygna³ x(t)'); xlabel('czas [s]'); pause
    plot(t,x,'r*'); pause
    plot(t,xp,'g'); 
    plot(t,s,'c'); pause
    
elseif znak==4  % sygna³y prostok¹tne i trójk¹tne   
    
    symbol=input('charakter przebiegu (4.1/4.2/4.3)=');
    if symbol==4.1  
        % x=A*square(2*pi*fx*t);      % sygna³ prostok¹tny
        x1=[0 A*ones(1,N/(NT*2)-1) 0 -A*ones(1,N/(NT*2)-1)];
        x=x1;
        for i=1:(NT-1),
            x=[x x1];
        end
    elseif symbol==4.2
        % x=A*sawtooth(2*pi*fx*t);    % sygna³ trójk¹tny unipolarny
        Tx=1/fx;
        x1=[0 ((2*A/Tx)*t(1:N/NT-1))-A*(N/(2*NT)-1)/(N/(2*NT))];
        x=x1;
        for i=1:(NT-1),
            x=[x x1];  
        end
    elseif symbol==4.3
        % x=A*sawtooth(2*pi*fx*t,0.5);    % sygna³ trójk¹tny bipolarny
        Tx=1/fx;
        x1=[((4*A/Tx)*t(1:N/(2*NT)))-A ((-4*A/Tx)*t(N/(2*NT)+1:N/NT))+3*A];
        x=x1;
        for i=1:(NT-1),
            x=[x x1];
        end
    end
    
    clf;
    hold on;    
    plot(t(1:N),x(1:N),'b'); grid; title('Sygna³ x(t)'); xlabel('czas [s]'); pause
    plot(t(1:N),x(1:N),'r*'); pause
end   
     
    % Oblicz wspó³czynniki zespolonego szeregu Fouriera dla tego sygna³u.
    % Narysuj wykresy s³upkowe modu³u widma w skali liniowej i logarytmicznej (decybelowej)
    
    x=x(1:N);     % d³ugoœæ wektora wartoœci sygna³u
    t=t(1:N);     % d³ugoœæ wektora czasu
    f=f(1:N);     % d³ugoœæ wektora czêstotliowœci
    X=fft(x);     % transformata Fouriera
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
    plot(f(2:N/2+1),abs(X(2:N/2+1))/(N/2),'r*'); grid; title('Po wyskalowaniu'); xlabel('Hz'); 
    plot(f(1),abs(X(1)/N),'r*'); pause   
    stem(f(2:N/2+1),abs(X(2:N/2+1))/(N/2),'b'); 
    stem(f(1),abs(X(1)/N),'b'); pause

    % Zyntetyzuj sygna³ na podstawie wspó³czynników jego szeregu Fouriera
    % i porównaj go z orygina³em
    
    xs=ifft(X);     % odwrotna transformata Fouriera
    clf;
    subplot(211);
    hold on;
    plot(t,xs); grid; title('Synteza sygna³u'); pause	% synteza sygna³u ze wspó³czynników rozwiniêcia
    plot(t,xs,'r*'); pause
    subplot(212);
    hold on;
    plot(t,(x-xs)); grid; title('Roznica'); pause		% b³¹d rzêdu 10^(-14)    
    plot(t,(x-xs),'r*'); pause
    
if znak==4
    % Zyntetyzuj sygna³ na podstawie wspó³czynników jego szeregu Fouriera
    % dla ró¿nej iloœci wspó³czynników
    a=real(X)/(N/2);
    b=imag(X)/(N/2);
    y=zeros(1,N);
    for k=0:N-1
        y=y+a(k+1)*cos(k*2*pi*(fp/N)*t)-b(k+1)*sin(k*2*pi*(fp/N)*t);
        clf;
        hold on;
        plot(t,y); grid; title('Suma = k pierwszych funkcji bazowych'); 
        plot(t,y,'r*'); pause
    end
end      
    
close all;