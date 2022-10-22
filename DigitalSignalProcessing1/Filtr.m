close all;
clearvars;
clc;  

filtracja=input('filtracja:{1-funkcja Matlaba,2-bufory przesuwne}=');
                       
fx1=10;     % cz�stotliwo�� sygna�u podstawowego
fx2=50;     % cz�stotliwo�� sygna�u na�o�onego
fmax=100;   % maksymalna cz�stotliwo�� na ch-ce cz�st.
fpr=1000;   % cz�stotliwo�� pr�bkowania
Nx=1024;    % liczba pr�bek

% Generacja sygna�u testowego

n=0:Nx-1;
tpr=1/fpr; 
t=tpr*n;
x=sin(2*pi*fx1*t)+sin(2*pi*fx2*t);

% Podaj parametry zer i biegun�w transmitancji filtru dolnoprzepustowego

fz=[50];    % cz�stotliwo�ci zer w Hz
fp=[10];    % cz�stotliwo�ci biegun�w w HZ
Rz=[1];     % promienie kolejnych zer
Rp=[0.98];  % promienie kolejnych biegun�w
    
% Oblicz zera i bieguny transmitancji

fi_z=(2*pi/fpr)*fz;  % k�ty zer w pa�mie zaporowym       
fi_p=(2*pi/fpr)*fp;  % k�ty biegun�w w pa�mie przepuszczania
z=Rz.*exp(j*fi_z);   % zera
p=Rp.*exp(j*fi_p);   % bieguny
z=[z conj(z)];       % dodanie zer sprz�onych
p=[p conj(p)];       % dodanie biegun�w sprz�onych

% Po�o�enie zer i biegun�w - rysunek 

NP=1000; 
fi=2*pi*(0:1:NP-1)/NP; 
s=sin(fi); 
c=cos(fi);
plot(s,c,'-g',real(z),imag(z),'or',real(p),imag(p),'xb');
title('ZERA i BIEGUNY'); grid; pause
  
% Oblicz wsp�czynniki transmitancji {z,p} -> {b,a}

wzm=1; 
[b,a]=zp2tf(z',p',wzm)
pause

% Charakterystyka cz�stotliwo�ciowa {b,a} -> H(f)

df=fpr/Nx;       % parametry obliczanego widma Fouriera    
f=0:df:fmax; 
% w=2*pi*f;	
wn=2*pi*f/fpr;
H=freqz(b,a,wn);
Habs=abs(H); 
HdB=20*log10(Habs); 
Hfa=unwrap(angle(H));

plot(f,Habs,'r'); grid; title('|H(f)|'); xlabel('f [Hz]'); pause
plot(f,HdB,'r'); grid; title('|H(f)| dB'); xlabel('f [Hz]'); pause
plot(f,Hfa,'r'); grid; title('k�t H(f)'); xlabel('f [Hz]'); ylabel('[rd]'); pause
  

% Filtracja sygna�u: x(n) ---[b,a]---> y(n) 

if filtracja==1             % funkcja Matlaba 
   y=filter(b,a,x);
elseif filtracja==2        % filtracja z wykorzystaniem bufor�w przesuwnych
   M=length(b); 
   N=length(a);
   a=a(2:N); 
   N=N-1;
   bx=zeros(1,M); 
   by=zeros(1,N); 
   y=[];
   for n=1:Nx
      bx=[x(n) bx(1:M-1)];
      y(n)=sum(bx.*b)-sum(by.*a);   % suma pr�bek wej�ciowych i wyj�ciowych
      by=[y(n) by(1:N-1)];
   end
end
   
% Prezentacja wynik�w filtracji
clf;
subplot(211);
plot(t,x,'r'); grid; axis tight; title('Wejscie x(n)'); pause
subplot(212); 
plot(t,y,'r'); grid; axis tight; title('Wyj�cie y(n)'); xlabel('t[s]'); pause
                           
X=freqz(x,1,wn)/(Nx/2);
Y=freqz(y,1,wn)/(Nx/2);
X=abs(X); 
Y=abs(Y);
clf;
subplot(211); 
plot(f,X,'r'); grid; title('Wejscie X(f)'); pause
subplot(212); 
plot(f,Y,'r'); grid; title('Wyj�cie Y(f)'); xlabel('f [Hz]'); pause

close all;