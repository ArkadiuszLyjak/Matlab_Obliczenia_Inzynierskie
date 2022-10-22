clear all;

% Wygeneruj Np pr�bek sygna�u sinusoidalnego x(t) o amplitudzie A, 
% cz�stotliwo�ci fx i liczbie okres�w NT. Narysuj ten sygna�.
   
A=input('amplituda=');                  % Parametry sygna�u
fx=input('cz�stotliwo�� sygna�u=');     
NT=input('liczba okres�w=');
N=input('liczba pr�bek=');
W=input('okno{1-Hamming,2-Hanning,3-Blackman,4-Bartletta}=');

t0=0;                   % pocz�tek analizowanego sygna�u (okna prostok�tnego)
tk=NT/fx;               % koniec analizowanego sygna�u
t=linspace(t0,tk,N+1);  % generacja liniowego wektora czasu
Tp=(tk-t0)/N;           % okres pr�bkowania
fp=1/Tp;                % cz�stotliwo�� pr�kowania
f=linspace(0,fp,N+1);   % generacja liniowego wektora cz�stotliwo�ci
x=A*sin(2*pi*fx*t);     % sygna� sin

win1=hamming(N+1);
win2=hanning(N+1);
win3=blackman(N+1);
win4=bartlett(N+1);

if W==1
xw=x.*win1';
elseif W==2
xw=x.*win2';
elseif W==3
xw=x.*win3';
elseif W==4
xw=x.*win4';
end

% Narysuj kszta�t funkcji okien czasowych
clf;
hold on;
plot(t,win1','g'); grid; title('Okna czasowe'); xlabel('czas [s]'); pause
plot(t,win2','y'); pause
plot(t,win3','c'); pause
plot(t,win4','m'); pause

% Narysuj kszta�t sygna�u badanego 
% oraz przemno�onego przez funkcje okien

clf;
subplot(211);
hold on;
plot(t,x); grid; title('Sygna� x(t)'); xlabel('czas [s]'); pause
plot(t,x,'r*'); pause
stem(t,x,'g'); pause
subplot(212);
hold on;
plot(t,xw); grid; title('Sygna� x(t)'); xlabel('czas [s]'); pause
plot(t,xw,'r*'); pause
stem(t,xw,'g'); pause

% Oblicz wsp�czynniki zespolonego szeregu Fouriera dla 
% sygna�u badanego oraz przemno�onego przez funkcj� okien.

x=x(1:N);       % d�ugo�� wektora warto�ci funkcji
xw=xw(1:N);
t=t(1:N);       % d�ugo�� wektora chwil czasowych
f=f(1:N);       % d�ugo�� wektora cz�stotliow�ci
X=fft(x);       % transformata Fouriera
XW=fft(xw);

mod_X_dB=20*log10(abs(X)/max(abs(X)));
mod_XW_dB=20*log10(abs(XW)/max(abs(XW)));

% Generowanie funkcji aproksymuj�cej sinc oraz
% funkcji aproksymuj�cej widmo sygna��w z funkcjami okien
    
ta=linspace(t0,100*tk,100*N+1);
fa=linspace(0,fp,100*N+1);
z=zeros(1,99*N);

xa=[x,z];
xa=xa(1:100*N);
ta=ta(1:100*N);
fa=fa(1:100*N);
FA=fft(xa);

xaw=[xw,z];
xaw=xaw(1:100*N);
FAW=fft(xaw);

mod_FA_dB=20*log10(abs(FA)/max(abs(FA)));
mod_FAW_dB=20*log10(abs(FAW)/max(abs(FAW)));

% Narysuj modu� wsp�czynnik�w widma sygna�u podstawowego
% oraz przemno�onego przez funkcj� okien
% wraz z przebiegiem funkcji aproksymuj�cej widmo.

clf;
subplot(211);
hold on;
plot(f,abs(X),'r*'); grid; title('Mod(X)'); xlabel('Hz'); pause
stem(f,abs(X),'b'); pause
plot(fa,abs(FA),'g'); pause
subplot(212);
hold on;
plot(f,abs(XW),'r*'); grid; title('Mod(X)'); xlabel('Hz'); pause
stem(f,abs(XW),'b'); pause
plot(fa,abs(FAW),'g'); pause

clf;
subplot(211);
hold on;
plot(f,mod_X_dB,'r*'); grid; title('Mod(X)dB'); xlabel('Hz'); pause
stem(f,mod_X_dB,'b'); pause
plot(fa,mod_FA_dB,'g'); pause
subplot(212);
hold on;
plot(f,mod_XW_dB,'r*'); grid; title('Mod(X)dB'); xlabel('Hz'); pause
stem(f,mod_XW_dB,'b'); pause
plot(fa,mod_FAW_dB,'g'); pause

% Narysuj modu� widma sygna�u podstawowego oraz przemno�onego przez funkcj� okien
% po przeskalowaniu dla cz�stotliwo�ci <0,df*N/2>
% z naniesion� na wykresie funkcj� aproksymuj�c� to widmo   

clf;
subplot(211);
hold on;
plot(f(1:N/2+1),abs(X(1:N/2+1))/(N/2),'r*'); grid; title('Widmo po wyskalowaniu'); xlabel('Hz'); pause   
stem(f(1:N/2+1),abs(X(1:N/2+1))/(N/2),'b'); pause
plot(fa(1:100*N/2+1),abs(FA(1:100*N/2+1))/(N/2),'g'); pause
subplot(212);
hold on;
plot(f(1:N/2+1),abs(XW(1:N/2+1))/(N/2),'r*'); grid; title('Widmo po wyskalowaniu'); xlabel('Hz'); pause   
stem(f(1:N/2+1),abs(XW(1:N/2+1))/(N/2),'b'); pause
plot(fa(1:100*N/2+1),abs(FAW(1:100*N/2+1))/(N/2),'g'); pause

close all;