clear all;

% Wygeneruj Np próbek sygna³u sinusoidalnego x(t) o amplitudzie A, 
% czêstotliwoœci fx i liczbie okresów NT. Narysuj ten sygna³.
   
A=input('amplituda=');                  % Parametry sygna³u
fx=input('czêstotliwoœæ sygna³u=');     
NT=input('liczba okresów=');
N=input('liczba próbek=');

znak=input('metoda generowania funkcji sinc (1,2)=');

if znak==1
symbol=input('sposób definiowania funkcji sinc (1.1,1.2)=');
end

t0=0;                   % poczêtek analizowanego sygna³u (okna prostok¹tnego)
tk=NT/fx;               % koniec analizowanego sygna³u
t=linspace(t0,tk,N+1);  % generacja liniowego wektora czasu
Tp=(tk-t0)/N;           % okres próbkowania
fp=1/Tp;                % czêstotliwoœæ prókowania
f=linspace(0,fp,N+1);   % generacja liniowego wektora czêstotliwoœci
x=A*sin(2*pi*fx*t);     % sygna³ sin

clf;
hold on;
plot(t,x); grid; title('Sygna³ x(t)'); xlabel('czas [s]'); pause
plot(t,x,'r*'); pause
stem(t,x,'g'); pause
   
% Oblicz wspó³czynniki zespolonego szeregu Fouriera dla tego sygna³u.

x=x(1:N);       % d³ugoœæ wektora wartoœci funkcji
t=t(1:N);       % d³ugoœæ wektora chwil czasowych
f=f(1:N);       % d³ugoœæ wektora czêstotliowœci
X=fft(x);       % transformata Fouriera
    
% Generowanie funkcji aproksymuj¹cej sinc metod¹ 1

if znak==1

if symbol==1.1
    fFA=linspace(0,fp,100*N+1);             % funkcja aproksymuj¹ca widmo sygna³u 
    FA=A*(N/2)*sin(pi*tk*(fFA-fx))./(pi*tk*(fFA-fx));
    FA((fx/fp)*100*N+1)=A*(N/2);

elseif symbol==1.2
    fFA=linspace(0,fp,100*N+1);             % funkcja aproksymuj¹ca widmo sygna³u
    FAI=zeros(1,100*N+1);
    % FAII=zeros(1,100*N+1);
    for i=-100:100
        FAIi=A*(N/2)*sin(pi*tk*(fFA-fx+i*fp))./(pi*tk*(fFA-fx+i*fp));
        FAI=FAI+FAIi;
    end
    FAI((fx/fp)*100*N+1)=A*(N/2);

    FAII=fliplr(FAI);   % for i=-100:100
                        % FAIIi=A*(N/2)*sin(pi*tk*(fFA+fx+i*fp))./(pi*tk*(fFA+fx+i*fp));
                        % FAII=FAII+FAIIi;
                        % end
    FA=FAI+FAII;
end
% Generowanie funkcji aproksymuj¹cej sinc metod¹ 2

elseif znak==2
ta=linspace(t0,100*tk,100*N+1);
fa=linspace(0,fp,100*N+1);
z=zeros(1,99*N);
xa=[x,z];

xa=xa(1:100*N);
ta=ta(1:100*N);
fa=fa(1:100*N);

FA=fft(xa);

end

% Narysuj przebieg sygna³u, modu³ wspó³czynników widma
% oraz przebieg funkcji sinc.

clf;
subplot(211);
hold on;
plot(f,abs(X),'r*'); grid; title('Mod(X)'); xlabel('Hz'); pause
stem(f,abs(X),'b'); pause
subplot(212);
hold on;
if znak==1
if symbol==1.1
plot(fFA,FA,'g'); grid; title('Funkcja sinc(f)'); xlabel('Hz'); pause
plot(fFA,abs(FA),'b'); pause
elseif symbol==1.2
plot(fFA,FAI,'c'); grid; title('Funkcja sinc(f)'); xlabel('Hz'); pause
plot(fFA,FAII,'g'); pause
plot(fFA,FA,'r'); pause
plot(fFA,abs(FA),'b'); pause
end
elseif znak==2
plot(fa,FA,'g'); grid; title('Funkcja sinc(f)'); xlabel('Hz'); pause
plot(fa,abs(FA),'b'); pause
end

% Narysuj modu³ widma sygna³u po przeskalowaniu dla czêstotliwoœci <0,df*N/2>
% z naniesion¹ na wykresie funkcj¹ aproksymuj¹c¹ to widmo   

clf;
hold on;
if znak==1
if symbol==1.1
plot(f(1:N/2+1),abs(X(1:N/2+1))/(N/2),'r*'); grid; title('Widmo po wyskalowaniu'); xlabel('Hz'); pause   
stem(f(1:N/2+1),abs(X(1:N/2+1))/(N/2),'g'); pause
plot(fFA(1:100*N/2+1),abs(FA(1:100*N/2+1))/(N/2),'b'); pause
elseif symbol==1.2
plot(f(1:N/2+1),abs(X(1:N/2+1))/(N/2),'r*'); grid; title('Widmo po wyskalowaniu'); xlabel('Hz'); pause   
stem(f(1:N/2+1),abs(X(1:N/2+1))/(N/2),'g'); pause
plot(fFA(1:100*N/2+1),abs(FAI(1:100*N/2+1))/(N/2),'c'); pause
plot(fFA(1:100*N/2+1),abs(FAII(1:100*N/2+1))/(N/2),'y'); pause
plot(fFA(1:100*N/2+1),abs(FA(1:100*N/2+1))/(N/2),'b'); pause
end
elseif znak==2
plot(f(1:N/2+1),abs(X(1:N/2+1))/(N/2),'r*'); grid; title('Widmo po wyskalowaniu'); xlabel('Hz'); pause   
stem(f(1:N/2+1),abs(X(1:N/2+1))/(N/2),'g'); pause
plot(fa(1:100*N/2+1),abs(FA(1:100*N/2+1))/(N/2),'b'); pause
end

close all;