clear all;

% Wygeneruj Np pr�bek sygna�u sinusoidalnego x(t) o amplitudzie A, 
% cz�stotliwo�ci fx i liczbie okres�w NT. Narysuj ten sygna�.
   
A=input('amplituda=');                  % Parametry sygna�u
fx=input('cz�stotliwo�� sygna�u=');     
NT=input('liczba okres�w=');
N=input('liczba pr�bek=');

znak=input('metoda generowania funkcji sinc (1,2)=');

if znak==1
symbol=input('spos�b definiowania funkcji sinc (1.1,1.2)=');
end

t0=0;                   % pocz�tek analizowanego sygna�u (okna prostok�tnego)
tk=NT/fx;               % koniec analizowanego sygna�u
t=linspace(t0,tk,N+1);  % generacja liniowego wektora czasu
Tp=(tk-t0)/N;           % okres pr�bkowania
fp=1/Tp;                % cz�stotliwo�� pr�kowania
f=linspace(0,fp,N+1);   % generacja liniowego wektora cz�stotliwo�ci
x=A*sin(2*pi*fx*t);     % sygna� sin

clf;
hold on;
plot(t,x); grid; title('Sygna� x(t)'); xlabel('czas [s]'); pause
plot(t,x,'r*'); pause
stem(t,x,'g'); pause
   
% Oblicz wsp�czynniki zespolonego szeregu Fouriera dla tego sygna�u.

x=x(1:N);       % d�ugo�� wektora warto�ci funkcji
t=t(1:N);       % d�ugo�� wektora chwil czasowych
f=f(1:N);       % d�ugo�� wektora cz�stotliow�ci
X=fft(x);       % transformata Fouriera
    
% Generowanie funkcji aproksymuj�cej sinc metod� 1

if znak==1

if symbol==1.1
    fFA=linspace(0,fp,100*N+1);             % funkcja aproksymuj�ca widmo sygna�u 
    FA=A*(N/2)*sin(pi*tk*(fFA-fx))./(pi*tk*(fFA-fx));
    FA((fx/fp)*100*N+1)=A*(N/2);

elseif symbol==1.2
    fFA=linspace(0,fp,100*N+1);             % funkcja aproksymuj�ca widmo sygna�u
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
% Generowanie funkcji aproksymuj�cej sinc metod� 2

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

% Narysuj przebieg sygna�u, modu� wsp�czynnik�w widma
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

% Narysuj modu� widma sygna�u po przeskalowaniu dla cz�stotliwo�ci <0,df*N/2>
% z naniesion� na wykresie funkcj� aproksymuj�c� to widmo   

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