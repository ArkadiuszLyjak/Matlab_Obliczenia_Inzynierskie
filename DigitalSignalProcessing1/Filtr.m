close all;
clearvars;
clc;  

filtracja=input('filtracja:{1-funkcja Matlaba,2-bufory przesuwne}=');
                       
fx1=10;     % czêstotliwoœæ sygna³u podstawowego
fx2=50;     % czêstotliwoœæ sygna³u na³o¿onego
fmax=100;   % maksymalna czêstotliwoœæ na ch-ce czêst.
fpr=1000;   % czêstotliwoœæ próbkowania
Nx=1024;    % liczba próbek

% Generacja sygna³u testowego

n=0:Nx-1;
tpr=1/fpr; 
t=tpr*n;
x=sin(2*pi*fx1*t)+sin(2*pi*fx2*t);

% Podaj parametry zer i biegunów transmitancji filtru dolnoprzepustowego

fz=[50];    % czêstotliwoœci zer w Hz
fp=[10];    % czêstotliwoœci biegunów w HZ
Rz=[1];     % promienie kolejnych zer
Rp=[0.98];  % promienie kolejnych biegunów
    
% Oblicz zera i bieguny transmitancji

fi_z=(2*pi/fpr)*fz;  % k¹ty zer w paœmie zaporowym       
fi_p=(2*pi/fpr)*fp;  % k¹ty biegunów w paœmie przepuszczania
z=Rz.*exp(j*fi_z);   % zera
p=Rp.*exp(j*fi_p);   % bieguny
z=[z conj(z)];       % dodanie zer sprzê¿onych
p=[p conj(p)];       % dodanie biegunów sprzê¿onych

% Po³o¿enie zer i biegunów - rysunek 

NP=1000; 
fi=2*pi*(0:1:NP-1)/NP; 
s=sin(fi); 
c=cos(fi);
plot(s,c,'-g',real(z),imag(z),'or',real(p),imag(p),'xb');
title('ZERA i BIEGUNY'); grid; pause
  
% Oblicz wspó³czynniki transmitancji {z,p} -> {b,a}

wzm=1; 
[b,a]=zp2tf(z',p',wzm)
pause

% Charakterystyka czêstotliwoœciowa {b,a} -> H(f)

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
plot(f,Hfa,'r'); grid; title('k¹t H(f)'); xlabel('f [Hz]'); ylabel('[rd]'); pause
  

% Filtracja sygna³u: x(n) ---[b,a]---> y(n) 

if filtracja==1             % funkcja Matlaba 
   y=filter(b,a,x);
elseif filtracja==2        % filtracja z wykorzystaniem buforów przesuwnych
   M=length(b); 
   N=length(a);
   a=a(2:N); 
   N=N-1;
   bx=zeros(1,M); 
   by=zeros(1,N); 
   y=[];
   for n=1:Nx
      bx=[x(n) bx(1:M-1)];
      y(n)=sum(bx.*b)-sum(by.*a);   % suma próbek wejœciowych i wyjœciowych
      by=[y(n) by(1:N-1)];
   end
end
   
% Prezentacja wyników filtracji
clf;
subplot(211);
plot(t,x,'r'); grid; axis tight; title('Wejscie x(n)'); pause
subplot(212); 
plot(t,y,'r'); grid; axis tight; title('Wyjœcie y(n)'); xlabel('t[s]'); pause
                           
X=freqz(x,1,wn)/(Nx/2);
Y=freqz(y,1,wn)/(Nx/2);
X=abs(X); 
Y=abs(Y);
clf;
subplot(211); 
plot(f,X,'r'); grid; title('Wejscie X(f)'); pause
subplot(212); 
plot(f,Y,'r'); grid; title('Wyjœcie Y(f)'); xlabel('f [Hz]'); pause

close all;